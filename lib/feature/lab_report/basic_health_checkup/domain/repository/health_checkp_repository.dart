import 'package:dartz/dartz.dart';
import 'package:heath_genie/feature/lab_report/basic_health_checkup/domain/entities/health_check.dart';

import '../../../../../core/error/failure.dart';

abstract class HealthCheckRepository {
  Future<Either<Failure,HealthCheck>> getReport(String uhid);
}