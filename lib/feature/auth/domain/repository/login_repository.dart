import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/login_model.dart';

abstract class LoginRepository {
  Future<Either<Failure,LoginModel>> login(String email, String password);
}