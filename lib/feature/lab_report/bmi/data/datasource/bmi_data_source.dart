import '../../../common/domain/entities/screening_success_response_entity.dart';


abstract class BmiRemoteDataSource {
  Future<ScreeningSuccessResponse> saveBmiParameters({
    required String uhid,
    required Map<String, dynamic> bmiRequestBody,
  });
}
