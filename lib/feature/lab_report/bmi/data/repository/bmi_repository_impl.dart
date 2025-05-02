import 'package:dartz/dartz.dart';

import 'package:heath_genie/core/error/failure.dart';
import 'package:heath_genie/feature/lab_report/bmi/domain/entities/bmi_response_entity.dart';
import '../../domain/repository/bmi_repository.dart';
import '../datasource/bmi_data_source.dart';

class BmiRepositoryImpl implements BmiRepository {
  final BmiRemoteDataSource bmiDataSource;

  BmiRepositoryImpl({required this.bmiDataSource});


  @override
  Future<Either<Failure, BMIResponse>> saveBmiData(Map<String, dynamic> bmiRequestBody) {
    // TODO: implement saveBmiData
    throw UnimplementedError();
  }
  
}