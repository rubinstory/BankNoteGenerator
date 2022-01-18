import 'package:my_first_app/api.dart';
import 'package:my_first_app/user/user.dart';
import 'package:my_first_app/user/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final _repository = UserRepository();
  final _userFetcher = PublishSubject<UserModel>();

  Stream<UserModel> get currentUser => _userFetcher.stream;
  fetchCurrentUser() async {
    UserModel userModel = await _repository.fetchUser(CURRENT_USER_ID);
    CURRENT_USER_ID = userModel.id;
    _userFetcher.sink.add(userModel);
  }

  dispose() {
    _userFetcher.close();
  }
}

final userBloc = UserBloc();
