import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../entities/lab_report_parameter_entity.dart';

abstract class LabReportRepository {
  Future<Either<Failure,LabReportEntity>> getLabReport(String uhid, String group);
}