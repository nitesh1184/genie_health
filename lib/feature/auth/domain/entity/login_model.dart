import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {

  final String message;
  final String token;


  const LoginModel({
    required this.message,
    required this.token,
  });

  @override
  List<Object> get props => [message, token];

}