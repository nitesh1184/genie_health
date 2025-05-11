
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/common_use_case.dart';


import '../../../common/domain/entities/screening_success_response_entity.dart';
import '../entity/thermometer_entity.dart';
import '../repository/thermometer_repository.dart';

class ThermometerUseCase extends BaseUseCase<ThermometerEntity, ThermoMeterParams> {

  final ThermometerRepository repository;

  ThermometerUseCase({required this.repository});


  @override
  Future<Either<Failure, ThermometerEntity>> call(ThermoMeterParams param) async {
    return await repository.getThermometerReport(param.uhid,param.group);
  }

  Future<Either<Failure, ScreeningSuccessResponse>> saveThermometerReport(SaveParams params) async {
    return await repository.saveThermometerReport(params.uhid, params.requestBody);
  }
}

class SaveParams {
  final Map<String, dynamic> requestBody;
  final String uhid;

  SaveParams({required this.requestBody, required this.uhid});
}

class ThermoMeterParams {
  final String uhid;
  final String group;

  ThermoMeterParams({required this.uhid, required this.group});
}