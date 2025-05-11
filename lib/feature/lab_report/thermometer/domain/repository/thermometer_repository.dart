import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../common/domain/entities/screening_success_response_entity.dart';
import '../entity/thermometer_entity.dart';

abstract class ThermometerRepository {
  Future<Either<Failure,ThermometerEntity>> getThermometerReport(String uhid, String group);
  Future<Either<Failure,ScreeningSuccessResponse>>  saveThermometerReport(String uhid, Map<String, dynamic> requestBody);
}