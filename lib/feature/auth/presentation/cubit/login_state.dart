import 'package:equatable/equatable.dart';

import '../../domain/entity/login_model.dart';


abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginModel data;

  LoginSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);

  @override
  List<Object> get props => [message];
}
