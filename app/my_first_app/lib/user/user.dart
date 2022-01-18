class UserModel {
  int _id = 0;
  String _firstName = "";
  String _lastName = "";
  String _username = "";

  UserModel.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'];
    _firstName = parsedJson['first_name'];
    _lastName = parsedJson['last_name'];
    _username = parsedJson['username'];
  }

  int get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get fullName => _lastName + _firstName;
  String get username => _username;
}
