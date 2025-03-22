import '../../domain/entity/patient_model.dart';

abstract class PatientDetailDataSource {
  Future<Patient> getPatientDetails(String patientId);
}