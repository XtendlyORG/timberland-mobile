// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/features/emergency/data/datasources/emergency_datasource.dart';
import 'package:timberland_biketrail/features/emergency/domain/entities/emergency_configs.dart';
import 'package:timberland_biketrail/features/emergency/domain/repositories/emergency_repository.dart';

class EmergencyRepositoryImpl implements EmergencyRepository {
  final EmergencyDataSource dataSource;
  EmergencyRepositoryImpl({
    required this.dataSource,
  });
  @override
  Future<Either<EmergencyFailure, EmergencyConfigs>> fetchToken(
    String channelID,
  ) {
    return this(request: () => dataSource.fetchToken(channelID));
  }

  @override
  Future<Either<EmergencyFailure, void>> disconnectFromSocket() {
    return this(request: dataSource.disconnectFromSocket);
  }

  @override
  Future<Either<EmergencyFailure, void>> reconnectToChannel(
      EmergencyConfigs config) {
    return this(request: () => dataSource.reconnectToChannel(config));
  }

  @override
  Future<Either<EmergencyFailure, void>> connectToSocket({
    required void Function(EmergencyConfigs configs) onIncomingCall,
  }) {
    return this(
        request: () =>
            dataSource.connectToSocket(onIncomingCall: onIncomingCall));
  }

  @override
  Future<Either<EmergencyFailure, void>> declineCall(String memberID) {
    return this(
      request: () => dataSource.declineCall(memberID),
    );
  }

  @override
  Future<Either<EmergencyFailure, void>> registerMissedCall(
      EmergencyConfigs configs) {
    return this(
      request: () => dataSource.registerMissedCall(configs),
    );
  }

  Future<Either<EmergencyFailure, ReturnType>> call<ReturnType>({
    required Future<ReturnType> Function() request,
  }) async {
    try {
      return Right(await request());
    } on EmergencyException catch (exception) {
      return Left(
        EmergencyFailure(
          message: exception.message ?? 'Server Failure.',
        ),
      );
    } catch (e) {
      return const Left(
        EmergencyFailure(
          message: 'Something went wrong.',
        ),
      );
    }
  }
}
