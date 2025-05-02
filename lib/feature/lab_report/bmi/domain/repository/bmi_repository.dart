import 'package:dartz/dartz.dart';
import 'package:heath_genie/feature/lab_report/bmi/domain/entities/bmi_response_entity.dart';
import '../../../../../core/error/failure.dart';

abstract class BmiRepository {
  Future<Either<Failure,BMIResponse>>  saveBmiData(Map<String, dynamic> bmiRequestBody);
}