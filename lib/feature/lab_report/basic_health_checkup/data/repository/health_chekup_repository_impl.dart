import 'package:dartz/dartz.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/health_check.dart';
import '../../domain/repository/health_checkp_repository.dart';
import '../datasource/health_check_data_source.dart';

class HealthCheckRepositoryImpl implements HealthCheckRepository {
  final HealthCheckDataSource healthCheckDataSource;

  HealthCheckRepositoryImpl({required this.healthCheckDataSource});

  @override
  Future<Either<Failure, HealthCheck>> getReport(String uhid) async {
    try {
      final result = await healthCheckDataSource.getReport(uhid);
      return Right(result);
    } on NoInternetException {
      return Left(
        NoInternetFailure(
          message:
              'You are not connected to the internet, Please try connect to internet and try again',
        ),
      ); // Handle No Internet
    } on ServerException {
      return Left(
        ServerFailure(
          message:
              'There is some issue with service, please wait we are working on it',
        ),
      ); // Generic server failure
    }
  }
}
