import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/patient_model.dart';

abstract class PatientRepository {
  Future<Either<Failure,Patient>> getPatientDetails(String id);
}