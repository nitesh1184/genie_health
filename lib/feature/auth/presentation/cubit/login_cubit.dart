import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/user/cubit/user_cubit.dart';
import '../../domain/entity/login_request.dart';
import '../../domain/usecase/login_usecase.dart';
import 'login_state.dart';

class LoginCubit
    extends
        Cubit<LoginState> {
  final LoginUseCase
  loginUseCase;
  final SharedPreferences
  storage;
  final UserCubit userCubit;

  LoginCubit(
    this.loginUseCase,
    this.storage,
    this.userCubit,
  ) : super(LoginInitial());

  Future<void> login(
    String email,
    String password,
  ) async {
    emit(LoginLoading());
    var connectivityResult =
        await Connectivity()
            .checkConnectivity();
    if (connectivityResult ==
        ConnectivityResult
            .none) {
      emit(
        LoginFailure(
          "Your are not connected to Internet, PLease connect to the internet and try again",
        ),
      );
    }
    else {
      final result =
      await loginUseCase(
        LoginParams(
          email: email,
          password:
          password,
        ),
      );
      result.fold(
            (failure) =>
            emit(
              LoginFailure(
                failure.message,
              ),
            ),
            (data) {
          emit(
            LoginSuccess(data),
          );
        },
      );
    }
  }
}
