import 'package:heath_genie/feature/lab_report/bmi/domain/entities/bmi_response_entity.dart';
import '../../../common/data/model/lab_report_model.dart';


abstract class BmiRemoteDataSource {
  Future<BMIResponse> saveBmiParameters({
    required String uhid,
    required Map<String, dynamic> bmiRequestBody,
  });
}
