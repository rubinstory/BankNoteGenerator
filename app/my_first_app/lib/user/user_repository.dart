import 'package:my_first_app/user/user.dart';
import 'package:my_first_app/user/user_api_provider.dart';

class UserRepository {
  final userAPIProvider = UserAPIProvider();
  Future<UserModel> fetchUser(int userId) => userAPIProvider.fetchUser(userId);
}
