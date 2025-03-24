import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entity/login_model.dart';
import '../../domain/repository/login_repository.dart';
import '../datasource/login_data_source.dart';

class LoginRepositoryImpl extends LoginRepository{

  final LoginDataSource loginDataSource;

  LoginRepositoryImpl({required this.loginDataSource});

  @override
  Future<Either<Failure, LoginModel>> login(String email, String password) async{
    try {
      final result = await loginDataSource.login(email, password);
      return Right(result);
    } on UnauthorizedException {
      return Left(UnauthorizedFailure(message: 'You have entered incorrect username and password')); // Handle 401 Unauthorized
    } on NoInternetException {
      return Left(NoInternetFailure(message: 'You are not connected to the internet, Please try connect to internet and try again')); // Handle No Internet
    } on ServerException {
      return Left(ServerFailure(message: 'There is some issue with service, please wait we are working on it')); // Generic server failure
    }
  }
}