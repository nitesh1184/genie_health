import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:heath_genie/feature/lab_report/basic_health_checkup/domain/entities/health_check.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/network/dio_helper.dart';
import '../../../../../core/utils/constants.dart';
import '../model/health_check_model.dart';
import 'health_check_data_source.dart';

class HealthCheckDataSourceImpl extends HealthCheckDataSource{
  @override
  Future<HealthCheck> getReport(String uhid) async {
    try {
      final storage = await SharedPreferences.getInstance();
      final token = storage.getString('token');
      final response = await DioHelper.getData(
        url: '${Constants.Result_Report_API}$uhid',
        token: token,
      );
      return HealthCheckModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown) {
        throw NoInternetException(); // Network issue
      }
      else if(e.response?.statusCode == 500){

      }
      else if (kDebugMode) {
        print("Error: $e");
      }
      throw const ServerException();
    }
  }

  @override
  Future<void> saveHealthCheck({required String uhid, required Map<String, dynamic> requestBody}) {
    // TODO: implement saveHealthCheck
    throw UnimplementedError();
  }

}