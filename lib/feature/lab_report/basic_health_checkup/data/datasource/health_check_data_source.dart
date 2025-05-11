import '../../domain/entities/health_check.dart';

abstract class HealthCheckDataSource {
  Future<HealthCheck> getReport(String uhid);
  Future<void> saveHealthCheck({
    required String uhid,
    required Map<String, dynamic> requestBody,
  });
}
