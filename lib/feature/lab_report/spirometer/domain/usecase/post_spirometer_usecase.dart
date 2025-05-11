import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/common_use_case.dart';
import '../../../common/domain/entities/save_report_params.dart';
import '../../../common/domain/entities/screening_success_response_entity.dart';
import '../repository/spirometer_repository.dart';


class PostSpirometerUseCase extends BaseUseCase<ScreeningSuccessResponse, SaveParams> {

  final SpirometerRepository repository;

  PostSpirometerUseCase({required this.repository});


  @override
  Future<Either<Failure, ScreeningSuccessResponse>> call(SaveParams params) async {
    return repository.saveParameters(params.uhid,params.requestBody);
  }
}
