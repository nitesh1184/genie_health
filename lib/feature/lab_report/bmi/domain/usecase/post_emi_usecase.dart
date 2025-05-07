import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/common_use_case.dart';
import '../../../common/domain/entities/screening_success_response_entity.dart';
import '../repository/bmi_repository.dart';

class PostBmiUseCase extends BaseUseCase<ScreeningSuccessResponse, SaveBmiParams> {

  final BmiRepository repository;

  PostBmiUseCase({required this.repository});


  @override
  Future<Either<Failure, ScreeningSuccessResponse>> call(SaveBmiParams params) async {
    return repository.saveBmiData(params.uhid,params.bmiRequestBody);
  }
}





class SaveBmiParams {
  final Map<String, dynamic> bmiRequestBody;
  final String uhid;

  SaveBmiParams({required this.bmiRequestBody, required this.uhid});
}