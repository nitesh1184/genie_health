import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:heath_genie/feature/detail/data/datasource/patient_detail_data_source.dart';
import 'package:heath_genie/feature/detail/data/model/patient_response_model.dart';
import 'package:heath_genie/feature/detail/domain/entity/patient_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../core/utils/constants.dart';

class PatientDetailDataSourceImpl extends PatientDetailDataSource {
  @override
  Future<Patient> getPatientDetails(String patientId) async {
    try {
      final storage = await SharedPreferences.getInstance();
      final token = storage.getString('token');
      final response = await DioHelper.getData(
        url: '${Constants.Patient_API}$patientId',
        token: token,
      );
      return PatientModel.fromJson(response.data);
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
