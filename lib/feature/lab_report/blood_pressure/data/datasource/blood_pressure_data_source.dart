import '../../../common/domain/entities/screening_success_response_entity.dart';

abstract class BloodPressureDataSource {
  Future<ScreeningSuccessResponse> saveParameters({
    required String uhid,
    required Map<String, dynamic> requestBody,
  });
}