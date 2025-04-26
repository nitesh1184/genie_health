import 'package:heath_genie/feature/auth/data/models/user_model.dart';

import '../../domain/entity/login_model.dart';

class LoginResponse extends LoginModel{

  const LoginResponse({
    required super.message,
    required super.token,
    required super.role,
    required super.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    message: json["message"],
    role: json["role"],
    token: json["token"],
    user: UserModel.fromJson(json["user"]),
  );
}

