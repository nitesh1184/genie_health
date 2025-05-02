import 'package:heath_genie/feature/Home/domain/entity/previously_scanned_patient.dart';

abstract class ScannedPatientListDataSource {
  Future<ScannedPatientEntity> getScannedPatientList();
}