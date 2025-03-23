import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {

  final String message;
  final String token;
  final String role;


  const LoginModel({
    required this.message,
    required this.token,
    required this.role
  });

  @override
  List<Object> get props => [message, token];

}