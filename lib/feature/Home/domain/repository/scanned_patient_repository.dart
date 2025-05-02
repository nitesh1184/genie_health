import 'package:dartz/dartz.dart';
import 'package:heath_genie/feature/Home/domain/entity/previously_scanned_patient.dart';

import '../../../../core/error/failure.dart';

abstract class ScannedPatientListRepository {
  Future<Either<Failure,ScannedPatientEntity>> getScannedPatientList();
}