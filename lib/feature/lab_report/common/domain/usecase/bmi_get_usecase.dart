import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/common_use_case.dart';
import '../entities/lab_report_parameter_entity.dart';
import '../repository/lab_report_repository.dart';

class LabReportUseCase extends BaseUseCase<LabReportEntity, LabReportParams> {

  final LabReportRepository repository;

  LabReportUseCase({required this.repository});


  @override
  Future<Either<Failure, LabReportEntity>> call(LabReportParams param) async {
    return await repository.getLabReport(param.uhid,param.group);
  }
}

class LabReportParams {
  final String uhid;
  final String group;

  LabReportParams({required this.uhid, required this.group});
}