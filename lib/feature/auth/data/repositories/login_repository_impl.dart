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
    } on ServerException catch(failure){
      return Left(ServerFailure(message: failure.toString()));
    }
  }
}