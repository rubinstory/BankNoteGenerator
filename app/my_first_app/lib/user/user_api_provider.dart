import 'package:my_first_app/api.dart';
import 'package:my_first_app/user/user.dart';
import 'package:dio/dio.dart';

class UserAPIProvider {
  Future<UserModel> fetchUser(int userId) async {
    final response = RestClient(Dio()).fetchCurrentUser(userId);
    return response;
  }
}
