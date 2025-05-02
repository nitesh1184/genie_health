import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entity/previously_scanned_patient.dart';
import '../../domain/repository/scanned_patient_repository.dart';
import '../datasource/scanned_patient_list_data_source.dart';

class ScannedPatientListRepositoryImpl extends ScannedPatientListRepository {
  final ScannedPatientListDataSource scannedPatientListDataSource;

  ScannedPatientListRepositoryImpl({required this.scannedPatientListDataSource});

  @override
  Future<Either<Failure, ScannedPatientEntity>> getScannedPatientList() async {
    try {
      final result = await scannedPatientListDataSource.getScannedPatientList();
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