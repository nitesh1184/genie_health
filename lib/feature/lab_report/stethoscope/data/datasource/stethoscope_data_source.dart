import '../../../common/domain/entities/screening_success_response_entity.dart';

abstract class StethoscopeDataSource {
  Future<ScreeningSuccessResponse> saveParameters({
    required String uhid,
    required Map<String, dynamic> requestBody,
  });
}