import 'package:dartz/dartz.dart';
import 'package:heath_genie/feature/detail/domain/repository/patient_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entity/patient_model.dart';
import '../datasource/patient_detail_data_source.dart';

class PatientRepositoryImpl extends PatientRepository{

  final PatientDetailDataSource patientDetailDataSource;

  PatientRepositoryImpl({required this.patientDetailDataSource});

  @override
  Future<Either<Failure, Patient>> getPatientDetails(String patientId) async{
    try {
      final result = await patientDetailDataSource.getPatientDetails(patientId);
      return Right(result);
    } on ServerException catch(failure){
      return Left(ServerFailure(message: failure.toString()));
    }
  }
}