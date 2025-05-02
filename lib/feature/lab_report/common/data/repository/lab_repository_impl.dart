import 'package:dartz/dartz.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/lab_report_parameter_entity.dart';
import '../../domain/repository/lab_report_repository.dart';
import '../datasource/lab_report_data_source.dart';

class LabRepositoryImpl implements LabReportRepository {
  final LabReportDataSource labReportDataSource;

  LabRepositoryImpl({required this.labReportDataSource});

  @override
  Future<Either<Failure, LabReportEntity>> getLabReport(
      String uhid, String group) async {
    try {
      final result = await labReportDataSource.getLabReport(uhid, group);
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