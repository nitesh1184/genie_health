import 'package:dartz/dartz.dart';
import 'package:heath_genie/feature/detail/domain/repository/patient_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entity/patient_model.dart';
import '../datasource/patient_detail_data_source.dart';

class PatientRepositoryImpl extends PatientRepository {
  final PatientDetailDataSource patientDetailDataSource;

  PatientRepositoryImpl({required this.patientDetailDataSource});

  @override
  Future<Either<Failure, Patient>> getPatientDetails(String patientId) async {
    try {
      final result = await patientDetailDataSource.getPatientDetails(patientId);
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
