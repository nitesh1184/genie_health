import 'package:dartz/dartz.dart';
import 'package:heath_genie/feature/detail/domain/entity/patient_model.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/common_use_case.dart';
import '../repository/patient_repository.dart';

class PatientDetailUseCase extends BaseUseCase<Patient, String> {

  final PatientRepository patientRepository;

  PatientDetailUseCase({required this.patientRepository});

  @override
  Future<Either<Failure, Patient>> call(String params) async {
    return await patientRepository.getPatientDetails(params);
  }
}