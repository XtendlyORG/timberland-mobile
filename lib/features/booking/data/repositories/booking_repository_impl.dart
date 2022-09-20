// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/features/booking/data/datasources/booking_datasource.dart';
import 'package:timberland_biketrail/features/booking/domain/entities/booking_response.dart';
import 'package:timberland_biketrail/features/booking/domain/params/booking_request_params.dart';
import 'package:timberland_biketrail/features/booking/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingDatasource bookingDatasource;
  BookingRepositoryImpl({
    required this.bookingDatasource,
  });

  @override
  Future<Either<Failure, int>> getFreePassCount() {
    return this(request: bookingDatasource.getFreePassCount);
  }

  @override
  Future<Either<BookingFailure, BookingResponse>> submitBookingRequest(
      BookingRequestParams requestParams) {
    return this(
        request: () => bookingDatasource.submitBookingRequest(requestParams));
  }

  Future<Either<BookingFailure, ReturnType>> call<ReturnType>({
    required Future<ReturnType> Function() request,
  }) async {
    try {
      return Right(await request());
    } on BookingException catch (exception) {
      if (exception is DuplicateBookingException) {
        return Left(
          DuplicateBookingFailure(
            message: exception.message ?? 'Server Failure.',
          ),
        );
      }
      return Left(
        BookingFailure(
          message: exception.message ?? 'Server Failure.',
        ),
      );
    } catch (e) {
      return const Left(
        BookingFailure(
          message: 'Something went wrong.',
        ),
      );
    }
  }
}
