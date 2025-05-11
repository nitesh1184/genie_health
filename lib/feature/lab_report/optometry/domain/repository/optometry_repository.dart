import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../common/domain/entities/screening_success_response_entity.dart';

abstract class OptometryRepository {
  Future<Either<Failure,ScreeningSuccessResponse>>  saveParameters(String uhid, Map<String, dynamic> requestBody);
}