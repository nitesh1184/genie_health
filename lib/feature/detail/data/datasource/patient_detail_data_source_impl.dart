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
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString('token');
    final response = await DioHelper.getData(
      url: '${Constants.Patient_API}$patientId',
      token: token,
    );
    if (response.statusCode == 200) {
      return PatientModel.fromJson(response.data);
    } else {
      throw const ServerException();
    }
  }
}
