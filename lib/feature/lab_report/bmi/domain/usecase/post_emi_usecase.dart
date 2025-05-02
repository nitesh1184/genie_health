import 'package:dartz/dartz.dart';
import 'package:heath_genie/feature/lab_report/bmi/domain/entities/bmi_response_entity.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/common_use_case.dart';
import '../repository/bmi_repository.dart';

class PostBmiUseCase extends BaseUseCase<BMIResponse, SaveBmiParams> {

  final BmiRepository repository;

  PostBmiUseCase({required this.repository});


  @override
  Future<Either<Failure, BMIResponse>> call(SaveBmiParams params) async {
    return repository.saveBmiData(params.bmiRequestBody);
  }
}





class SaveBmiParams {
  final Map<String, dynamic> bmiRequestBody;

  SaveBmiParams({required this.bmiRequestBody});
}