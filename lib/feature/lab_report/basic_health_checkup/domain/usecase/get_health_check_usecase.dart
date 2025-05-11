import 'package:dartz/dartz.dart';
import 'package:heath_genie/feature/lab_report/basic_health_checkup/domain/entities/health_check.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/common_use_case.dart';
import '../repository/health_checkp_repository.dart';

class HealthCheckUseCase extends BaseUseCase<HealthCheck, String> {

  final HealthCheckRepository repository;

  HealthCheckUseCase({required this.repository});


  @override
  Future<Either<Failure, HealthCheck>> call(String uhid) async {
    return await repository.getReport(uhid);
  }
}