import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:my_first_app/constants.dart';
import 'package:my_first_app/screens/login/components/authentication.dart';
import 'package:my_first_app/screens/main/tab_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _password = 123456;
  var _currentIndex = 0;
  var _enteredPassword = 0;

  void _update(int value) {
    setState(() {
      HapticFeedback.lightImpact();
      _enteredPassword = _enteredPassword * 10 + value;
      if (_currentIndex < 5) {
        _currentIndex++;
      } else {
        _currentIndex++;
        if (_enteredPassword != _password) {
          Future.delayed(Duration(milliseconds: 350), () {
            setState(() {
              _currentIndex = 0;
              _enteredPassword = 0;
            });
            HapticFeedback.heavyImpact();
          });
        } else {
          Future.delayed(Duration(milliseconds: 350), () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => TabPage(),
              ),
              (route) => false,
            );
          });
        }
      }
    });
  }

  void _delete() {
    setState(() {
      HapticFeedback.lightImpact();
      if (_currentIndex > 0) {
        _currentIndex--;
        _enteredPassword -= _enteredPassword % 10;
        _enteredPassword = _enteredPassword ~/ 10;
      }
    });
  }

  Future<void> _faceIdAuthentication() async {
    var result = await Authentication.authenticateWithBiometrics();
    if (result) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => TabPage(),
        ),
        (route) => false,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _faceIdAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(defaultPadding),
        padding: EdgeInsets.all(defaultPadding / 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Spacer(),
            Text(
              "GOOSE 비밀번호를\n입력해주세요.",
              style: TextStyle(
                color: myTextColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Container(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(defaultPadding / 4),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: _currentIndex >= 1 ? Colors.grey : lightlightgrey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(defaultPadding / 4),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: _currentIndex >= 2 ? Colors.grey : lightlightgrey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(defaultPadding / 4),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: _currentIndex >= 3 ? Colors.grey : lightlightgrey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(defaultPadding / 4),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: _currentIndex >= 4 ? Colors.grey : lightlightgrey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(defaultPadding / 4),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: _currentIndex >= 5 ? Colors.grey : lightlightgrey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(defaultPadding / 4),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: _currentIndex >= 6 ? Colors.grey : lightlightgrey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(
                top: defaultPadding * 5,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: defaultPadding / 2,
                      bottom: defaultPadding / 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        KeyPadItem(value: 1, update: _update),
                        KeyPadItem(value: 2, update: _update),
                        KeyPadItem(value: 3, update: _update),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: defaultPadding / 2,
                      bottom: defaultPadding / 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        KeyPadItem(value: 4, update: _update),
                        KeyPadItem(value: 5, update: _update),
                        KeyPadItem(value: 6, update: _update),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: defaultPadding / 2,
                      bottom: defaultPadding / 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        KeyPadItem(value: 7, update: _update),
                        KeyPadItem(value: 8, update: _update),
                        KeyPadItem(value: 9, update: _update),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: defaultPadding / 2,
                      bottom: defaultPadding / 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(),
                        ),
                        KeyPadItem(value: 0, update: _update),
                        Expanded(
                          child: IconButton(
                            icon: SvgPicture.asset("assets/icons/delete.svg"),
                            onPressed: () => _delete(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class KeyPadItem extends StatelessWidget {
  const KeyPadItem({
    Key? key,
    required this.value,
    required this.update,
  }) : super(key: key);
  final ValueChanged<int> update;

  final int value;
  // final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: TextButton(
        child: Text(
          value.toString(),
          style: TextStyle(
            color: myTextColor,
            fontSize: 25,
          ),
        ),
        onPressed: () => update(value),
      ),
    );
  }
}
