import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../auth/domain/entity/login_model.dart';
import '../model/user_model.dart';


class UserCubit extends Cubit<UserHandler?> {
  UserCubit() : super(null);

  void loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    if (userData != null) {
      final userMap = jsonDecode(userData);
      emit(UserHandler.fromJson(userMap));
    }
  }

  Future<void> saveUser(LoginModel data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', data.token);
    final email = data.user.emailId;
    final name= '${data.user.firstName} ${data.user.lastName}';
    final role= data.role;
      prefs.setString('user', jsonEncode({
        'role': role,
        'name': name,
        'email':email,
      }));
      final user=UserHandler(name: name,role: role,email: email);
      emit(user);

  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    emit(null);
  }
}