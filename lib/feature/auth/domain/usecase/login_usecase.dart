import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/common_use_case.dart';
import '../entity/login_model.dart';
import '../entity/login_request.dart';
import '../repository/login_repository.dart';

class LoginUseCase extends BaseUseCase<LoginModel, LoginParams> {

  final LoginRepository loginRepository;

  LoginUseCase({required this.loginRepository});

  @override
  Future<Either<Failure, LoginModel>> call(LoginParams params) async {
    return await loginRepository.login(params.email, params.password);
  }
}


