import '../../domain/entity/login_model.dart';

class LoginResponse extends LoginModel{

  const LoginResponse({
    required super.message,
    required super.token,
    required super.role
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json)
  => LoginResponse(
    message: json['message'],
    token: json['token'],
    role: json['role'],
  );
}