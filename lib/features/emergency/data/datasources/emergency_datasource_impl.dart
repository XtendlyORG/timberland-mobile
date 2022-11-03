// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:timberland_biketrail/core/configs/environment_configs.dart';
import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/features/emergency/data/datasources/emergency_datasource.dart';
import 'package:timberland_biketrail/features/emergency/domain/entities/emergency_configs.dart';

class EmergencyDataSourceImpl implements EmergencyDataSource {
  final Dio dioClient;
  final EnvironmentConfig environmentConfig;
  final socket = IO.io(
    // TODO: Refactor this, move ip address to .env
    'http://146.190.194.170:3001/',
    IO.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .build(),
  );

  EmergencyDataSourceImpl({
    required this.dioClient,
    required this.environmentConfig,
  });
  @override
  Future<EmergencyConfigs> fetchToken(String channelID) {
    return this(callback: () async {
      final response = await dioClient.post(
        '${environmentConfig.apihost}/emergencies/rtctoken',
        data: {
          'channel': channelID,
          'isPublisher': true,
        },
      );

      if (response.statusCode == 200) {
        _initSocketEventHandlers(
          channelID: channelID,
        );
        socket.connect();
        return EmergencyConfigs(
          token: response.data['token'],
          channelID: channelID,
          uid: response.data['uid'],
        );
      }

      throw const EmergencyException(message: 'Failed to request a token');
    });
  }

  @override
  Future<void> reconnectToChannel(String channelID) async {
    _initSocketEventHandlers(channelID: channelID);
    socket.connect();
  }

  @override
  Future<void> disconnectFromSocket() async {
    _disposeSocket();
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

  void _initSocketEventHandlers({
    required String channelID,
  }) {
    socket.onConnect((data) {
      log(socket.connected ? 'Connected to Socket' : 'Not Connected');
      socket.emit('client-data', _toJson(channelID));
    });
    socket.on(
      'received-client-data',
      (data) {
        log('Token Received: $data');
      },
    );
    socket.onConnectError((data) {
      log('On Connect Error: $data');
      _disposeSocket();
    });
    socket.onError((data) {
      log('Socket Error: $data');
      _disposeSocket();
    });
    socket.onConnectTimeout((data) {
      log('Connection TimeOut: $data');
      _disposeSocket();
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

  _toJson(String channelID) {
    final user = Session().currentUser!;
    return {
      'channel': channelID,
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
