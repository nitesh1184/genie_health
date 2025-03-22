import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../auth/domain/entity/login_model.dart';
import '../model/user_model.dart';


class UserCubit extends Cubit<User?> {
  UserCubit() : super(null);

  void loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    if (userData != null) {
      final userMap = jsonDecode(userData);
      emit(User.fromJson(userMap));
    }
  }

  Future<void> saveUser(LoginModel data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', data.token);

    final token = data.token;
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    final email = decodedToken["email"];
    int index = email.toString().indexOf("@");
    final name= email.toString().substring(0, index);
    final role= decodedToken["role"];
      prefs.setString('user', jsonEncode({
        'role': role,
        'name': name,
        'email':email,
      }));
      final user=User(name: name,role: role,email: email);
      emit(user);

  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    emit(null);
  }
}