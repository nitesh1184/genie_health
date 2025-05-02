import '../../domain/entities/lab_report_parameter_entity.dart';

abstract class LabReportDataSource {
  Future<LabReportEntity> getLabReport(String uhid, String group);
}