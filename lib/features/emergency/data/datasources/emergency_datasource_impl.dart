// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:timberland_biketrail/core/configs/environment_configs.dart';
import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/features/emergency/data/datasources/emergency_datasource.dart';
import 'package:timberland_biketrail/features/emergency/domain/entities/emergency_configs.dart';
import 'package:timberland_biketrail/features/emergency/domain/entities/emergency_log.dart';

class EmergencyDataSourceImpl implements EmergencyDataSource {
  final Dio dioClient;
  final EnvironmentConfig environmentConfig;
  late final IO.Socket socket;
  EmergencyDataSourceImpl({
    required this.dioClient,
    required this.environmentConfig,
  }) {
    socket = IO.io(
      environmentConfig.apihost,
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );
  }
  @override
  Future<EmergencyConfigs> fetchToken(String channelID) {
    return this(callback: () async {
      const storage = FlutterSecureStorage();
      var token = await storage.read(key: 'token');
      dioClient.options.headers["authorization"] = "token $token";
      final response = await dioClient.post(
        '${environmentConfig.apihost}/emergencies/rtctoken',
        data: {
          'channel': channelID,
          'isPublisher': true,
        },
      );

      if (response.statusCode == 200) {
        final emergencyID = await registerCallLog();

        final config = EmergencyConfigs(
          token: response.data['token'],
          channelID: channelID,
          uid: response.data['uid'],
          emergencyId: emergencyID,
        );
        _initiateCall(config);
        return config;
      }

      throw const EmergencyException(message: 'Failed to request a token');
    });
  }

  @override
  Future<void> reconnectToChannel(EmergencyConfigs configs) async {
    await registerCallLog();
    _initiateCall(configs);
  }

  @override
  Future<void> disconnectFromSocket() async {
    _disposeSocket();
  }

  @override
  Future<void> connectToSocket({
    required void Function(EmergencyConfigs configs) onIncomingCall,
  }) async {
    if (!socket.hasListeners('received-admin-data')) {
      _initSocketEventHandlers(onIncomingCall: onIncomingCall);
    }
    if (!socket.connected) {
      socket.connect();
    }
  }

  @override
  Future<void> declineCall(String memberID) async {
    log(name: "Socket", "Declining call");
    socket.emit('admin_call_decline', {
      'member_id': int.parse(memberID),
      'firstname': Session().currentUser!.firstName,
      'lastname': Session().currentUser!.lastName,
      'email': Session().currentUser!.email,
      'mobile_number': Session().currentUser!.mobileNumber,
      'emergency_contact': Session().currentUser!.emergencyContactInfo,
    });
  }

  @override
  Future<void> registerMissedCall(EmergencyConfigs configs) async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    dioClient.options.headers["authorization"] = "token $token";
    return this(callback: () async {
      log(configs.emergencyId.toString());
      final response = await dioClient.put(
        '${environmentConfig.apihost}/emergencies/${configs.emergencyId}/status',
        data: {
          'call_status': 'missed',
        },
      );

      if (response.statusCode == 200) {
        log(name: "Emergency Call", "Missed call registered");
      }

      throw const EmergencyException(message: 'Failed to register missed call');
    });
  }

  Future<int> registerCallLog() async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    dioClient.options.headers["authorization"] = "token $token";
    final user = Session().currentUser!;
    final EmergencyLog callLog = EmergencyLog(
      memberID: user.id,
      emergencyDate: DateTime.now().add(const Duration(hours: 8)),
      firstName: user.firstName,
      lastName: user.lastName,
      emergencyContact: user.emergencyContactInfo!,
      mobileNumber: user.mobileNumber,
    );

    final response = await dioClient.post(
      '${environmentConfig.apihost}/emergencies',
      data: callLog.toMap(),
    );

    if (response.statusCode == 200) {
      log(name: "Emergency Call", "Call log registered");
      return int.parse(response.data['insertId'].toString());
    }

    throw const EmergencyException(message: 'Failed to register missed call');
  }

  Future<ReturnType> call<ReturnType>({
    required Future<ReturnType> Function() callback,
  }) async {
    try {
      return await callback();
    } on DioError catch (dioError) {
      log(dioError.response?.statusCode?.toString() ?? 'statuscode: -1');
      log(dioError.response?.data.toString() ?? "no message");

      throw EmergencyException(message: dioError.message);
    } on EmergencyException {
      rethrow;
    } catch (e) {
      log(e.toString());
      throw const EmergencyException(message: "An Error Occurred");
    }
  }

  void _initiateCall(EmergencyConfigs config) {
    print("THE DATA: ${_toJson(config)}");
    socket.emit('client-data', _toJson(config));
  }

  void _initSocketEventHandlers({
    required void Function(EmergencyConfigs configs) onIncomingCall,
  }) {
    socket.onConnect((data) {
      log(socket.connected ? 'Connected to Socket' : 'Not Connected');
      log('On Connect: $data');
    });
    socket.on(
      'received-client-data',
      (data) {
        String memberId = Session().currentUser!.id;
        print('admin data received');
        if (data['member_id'].toString() == Session().currentUser!.id) {
          print('CALL RECEIVED');
          onIncomingCall(
            EmergencyConfigs(
              channelID: "tmbt-admin-emergency-$memberId",
              token: data['token'],
              uid: data['uid'],
              emergencyId: -1,
            ),
          );
        }
      },
    );
    socket.onConnectError((data) {
      log('On Connect Error: $data');
      // _disposeSocket();\
      //socket.connect();
    });
    socket.onError((data) {
      log('Socket Error: $data');
      // _disposeSocket();\
      socket.connect();
    });
    socket.onConnectTimeout((data) {
      log('Connection TimeOut: $data');
      // _disposeSocket();\
      socket.connect();
    });
    socket.onDisconnect((data) {
      log("Disconnected from Socket: $data");
    });
  }

  void _disposeSocket() {
    log("Dispose Called");
    socket.dispose();
    socket.destroy();
  }

  _toJson(EmergencyConfigs config) {
    final user = Session().currentUser!;
    return {
      'emergency_id': config.emergencyId,
      'channel': config.channelID,
      'member_id': int.parse(user.id),
      'firstname': user.firstName,
      'lastname': user.lastName,
      'email': user.email,
      'mobile_number': user.mobileNumber,
      'emergency_number': user.emergencyContactInfo,
      'address': user.address,
      'isPublisher': true,
    };
  }
}
