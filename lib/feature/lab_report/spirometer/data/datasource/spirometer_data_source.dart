import '../../../common/domain/entities/screening_success_response_entity.dart';

abstract class SpirometerDataSource {
  Future<ScreeningSuccessResponse> saveParameters({
    required String uhid,
    required Map<String, dynamic> requestBody,
  });
}