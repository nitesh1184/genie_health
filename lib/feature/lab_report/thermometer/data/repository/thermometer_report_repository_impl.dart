import 'package:dartz/dartz.dart';
import 'package:heath_genie/feature/lab_report/common/domain/entities/screening_success_response_entity.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entity/thermometer_entity.dart';
import '../../domain/repository/thermometer_repository.dart';
import '../datasource/thermometer_report_data_source.dart';


class ThermometerRepositoryImpl implements ThermometerRepository {
  final ThermometerReportDataSource thermoMeterDataSource;


  ThermometerRepositoryImpl({required this.thermoMeterDataSource});

  @override
  Future<Either<Failure, ThermometerEntity>> getThermometerReport(
      String uhid, String group) async {
    try {
      final result = await thermoMeterDataSource.getThermometerReport(uhid, group);
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

  @override
  Future<Either<Failure, ScreeningSuccessResponse>> saveThermometerReport(String uhid, Map<String, dynamic> requestBody) async {
    try{
      final result = await thermoMeterDataSource.saveThermometerReport(uhid: uhid, requestBody: requestBody);
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