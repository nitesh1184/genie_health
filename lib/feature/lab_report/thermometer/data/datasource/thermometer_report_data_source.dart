import '../../../common/domain/entities/screening_success_response_entity.dart';
import '../../domain/entity/thermometer_entity.dart';

abstract class ThermometerReportDataSource {
  Future<ThermometerEntity> getThermometerReport(String uhid, String group);
  Future<ScreeningSuccessResponse> saveThermometerReport({
    required String uhid,
    required Map<String, dynamic> requestBody,
  });
}