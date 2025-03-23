import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../core/utils/constants.dart';
import '../../domain/entity/login_model.dart';
import '../models/login_response.dart';
import 'login_data_source.dart';

class LoginDataSourceDataSourceImpl extends LoginDataSource {
  @override
  Future<LoginModel> login(String email, String password) async {
    final response = await DioHelper.postData(
      path: Constants.Login_API,
      data: {'email_id': email, 'password': password},
    );
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(response.data);
    } else {
      throw const ServerException();
    }
  }
}
