// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/dashboard/data/datasources/profile_datasource.dart';
import 'package:timberland_biketrail/dashboard/domain/params/update_user_detail.dart';
import 'package:timberland_biketrail/dashboard/domain/repository/profile_repository.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource profileDatasource;
  ProfileRepositoryImpl({
    required this.profileDatasource,
  });
  @override
  Future<Either<ProfileFailure, User>> updateUserDetail(
    UpdateUserDetailsParams userDetails,
  ) {
    return this(
      request: () => profileDatasource.updateUserDetails(userDetails),
    );
  }

  @override
  Future<Either<ProfileFailure, void>> updateEmailRequest(
      String email, String password) {
    return this(
      request: () => profileDatasource.updateEmailRequest(email, password),
    );
  }

  @override
  Future<Either<ProfileFailure, void>> verifyEmailUpdate(
    String email,
    String otp,
  ) {
    return this(
      request: () => profileDatasource.verifyEmailUpdate(email, otp),
    );
  }

  @override
  Future<Either<ProfileFailure, void>> resendEmailOtp(String email) {
    return this(request: () => profileDatasource.resendEmailOtp(email));
  }

  @override
  Future<Either<ProfileFailure, void>> updatePasswordRequest(
    String oldPassword,
    String newPassword,
  ) {
    return this(
      request: () => profileDatasource.updatePasswordRequest(
        oldPassword,
        newPassword,
      ),
    );
  }

  Future<Either<ProfileFailure, ReturnType>> call<ReturnType>({
    required Future<ReturnType> Function() request,
  }) async {
    try {
      return Right(await request());
    } on ProfileException catch (exception) {
      return Left(
        ProfileFailure(
          message: exception.message ?? 'Server Failure.',
        ),
      );
    } catch (e) {
      return const Left(
        ProfileFailure(
          message: 'Something went wrong.',
        ),
      );
    }
  }
}
