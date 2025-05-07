import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/common_use_case.dart';
import '../../../common/domain/entities/screening_success_response_entity.dart';
import '../repository/blood_pressure_repositoy.dart';

class BloodPressureUseCase extends BaseUseCase<ScreeningSuccessResponse, SaveParams> {

  final BloodPressureRepository repository;

  BloodPressureUseCase({required this.repository});


  @override
  Future<Either<Failure, ScreeningSuccessResponse>> call(SaveParams params) async {
    return repository.saveParameters(params.uhid,params.requestBody);
  }
}


class SaveParams {
  final Map<String, dynamic> requestBody;
  final String uhid;

  SaveParams({required this.requestBody, required this.uhid});
}