import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../core/utils/constants.dart';
import '../../domain/entity/login_model.dart';
import '../models/login_response.dart';
import 'login_data_source.dart';

class LoginDataSourceDataSourceImpl extends LoginDataSource {
  @override
  Future<LoginModel> login(String email, String password) async {
    try {
      final response = await DioHelper.postData(
        path: Constants.Login_API,
        data: {'email_id': email, 'password': password},
      );
      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw const UnauthorizedException(); // 401 Unauthorized
      } else {
        throw const ServerException();
      }
    }
  }
}
