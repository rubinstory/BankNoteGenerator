class TranscationModel {
  String _username = "";
  String _ticker = "";
  int _price = 0;

  TranscationModel.fromJson(Map<String, dynamic> parsedJson) {
    _username = parsedJson['user_name'];
    _ticker = parsedJson['ticker'];
    _price = parsedJson['price'];
  }

  String get username => _username;
  String get ticker => _ticker;
  int get price => _price;
}
