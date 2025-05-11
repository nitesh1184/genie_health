import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/common_use_case.dart';
import '../../../common/domain/entities/save_report_params.dart';
import '../../../common/domain/entities/screening_success_response_entity.dart';
import '../repository/oximeter_repository.dart';

class OximeterUseCase extends BaseUseCase<ScreeningSuccessResponse, SaveParams> {

  final OximeterRepository repository;

  OximeterUseCase({required this.repository});


  @override
  Future<Either<Failure, ScreeningSuccessResponse>> call(SaveParams params) async {
    return repository.saveParameters(params.uhid,params.requestBody);
  }
}
