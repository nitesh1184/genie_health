import 'package:dartz/dartz.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failure.dart';
import '../../../common/domain/entities/screening_success_response_entity.dart';
import '../../domain/repository/phlebotomy_repository.dart';
import '../datasource/phlebotomy_data_source.dart';

class PhlebotomyRepositoryImpl implements PhlebotomyRepository {
  final PhlebotomyDataSource phlebotomyDataSource;

  PhlebotomyRepositoryImpl({required this.phlebotomyDataSource});

  @override
  Future<Either<Failure, ScreeningSuccessResponse>> saveParameters(String uhid,Map<String, dynamic> requestBody) async{
    try{
      final result = await phlebotomyDataSource.saveParameters(uhid: uhid, requestBody: requestBody);
      return Right(result);
    } on NoInternetException {
      return Left(
        NoInternetFailure(
          message:
          'You are not connected to the internet, Please try connect to internet and try again',
        ),
      ); // Handle No Internet
    } on ServerException {
      return Left(
        ServerFailure(
          message:
          'There is some issue with service, please wait we are working on it',
        ),
      ); // Generic server failure
    }
  }

}