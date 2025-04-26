import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:heath_genie/feature/Home/data/datasource/scanned_patient_list_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../core/utils/constants.dart';
import '../../domain/entity/previously_scanned_patient.dart';
import '../model/scanned_patient_list_model.dart';

class ScannedPatientListDataSourceImpl extends ScannedPatientListDataSource {
  @override
  Future<List<ScannedPatientList>> getScannedPatientList() async {
    try {
      final storage = await SharedPreferences.getInstance();
      final token = storage.getString('token');
      final response = await DioHelper.getData(
        url: Constants.Scanned_Patient_API,
        token: token,
      );
      final data = response.data as List;
      return data
          .map((json) => ScannedPatientListModel.fromJson(json))
          .toList();
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
