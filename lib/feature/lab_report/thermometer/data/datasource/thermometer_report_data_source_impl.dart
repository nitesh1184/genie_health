import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:heath_genie/feature/lab_report/common/domain/entities/screening_success_response_entity.dart';
import 'package:heath_genie/feature/lab_report/thermometer/data/datasource/thermometer_report_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/network/dio_helper.dart';
import '../../../../../core/utils/constants.dart';
import '../../../common/data/model/screening_success_response_model.dart';
import '../../domain/entity/thermometer_entity.dart';
import '../model/thermometer_model.dart';

class ThermometerReportDataSourceImpl extends ThermometerReportDataSource {

  @override
  Future<ThermometerEntity> getThermometerReport(String uhid, String group) async {
    try {
      final storage = await SharedPreferences.getInstance();
      final token = storage.getString('token');
      final response = await DioHelper.getData(
        url: '${Constants.Lab_Report_API}$uhid/$group',
        token: token,
      );
      return ThermometerModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown) {
        throw NoInternetException(); // Network issue
      } else if (kDebugMode) {
        print("Error: $e");
      }
      throw const ServerException();
    }
  }

  @override
  Future<ScreeningSuccessResponse> saveThermometerReport({required String uhid, required Map<String, dynamic> requestBody}) async {
    try {
      final storage = await SharedPreferences.getInstance();
      final token = storage.getString('token');

      final response = await DioHelper.putData(
          path: '${Constants.Lab_Report_API}$uhid',
          token: token,
          data: requestBody
      );
      if (response.statusCode == 200) {
        return ScreeningSuccessResponseModel.fromJson(response.data);
      } else {
        throw UnauthorizedException();
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown) {
        throw NoInternetException(); // Network issue
      } else if (kDebugMode) {
        print("Error: $e");
      }
      throw const ServerException();
    }
  }
}