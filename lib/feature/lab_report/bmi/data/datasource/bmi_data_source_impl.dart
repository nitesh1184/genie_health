import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:heath_genie/feature/lab_report/common/data/model/screening_success_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/network/dio_helper.dart';
import '../../../../../core/utils/constants.dart';
import '../../../common/domain/entities/screening_success_response_entity.dart';
import 'bmi_data_source.dart';

class BmiRemoteDataSourceImpl extends BmiRemoteDataSource{

  @override
  Future<ScreeningSuccessResponse> saveBmiParameters({required String uhid, required Map<String, dynamic> bmiRequestBody}) async {
    try {
      final storage = await SharedPreferences.getInstance();
      final token = storage.getString('token');

      final response = await DioHelper.putData(
        path: '${Constants.Lab_Report_API}$uhid',
        token: token,
        data: bmiRequestBody
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
