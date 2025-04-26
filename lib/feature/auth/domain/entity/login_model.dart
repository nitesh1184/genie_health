import 'package:equatable/equatable.dart';
import 'package:heath_genie/feature/auth/domain/entity/user.dart';

class LoginModel extends Equatable {

  final String message;
  final String token;
  final String role;
  final User user;


  const LoginModel({
    required this.message,
    required this.token,
    required this.role,
    required this.user
  });

  @override
  List<Object> get props => [message, token,role,user];

}