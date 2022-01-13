import 'package:flutter/material.dart';

import '../../../constants.dart';

class TitleWithTextButton extends StatelessWidget {
  const TitleWithTextButton({
    Key? key,
    required this.title,
    required this.button,
    required this.press,
  }) : super(key: key);

  final String title, button;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding,
      ),
      child: Row(
        children: [
          TitleWithCustomUnderline(text: "$title"),
          Spacer(),
          FlatButtonWithCustomText(
            title: "$button",
            press: press,
          ),
        ],
      ),
    );
  }
}

class FlatButtonWithCustomText extends StatelessWidget {
  const FlatButtonWithCustomText({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: myBackGroundColor,
        minimumSize: Size(88, 45),
        padding: EdgeInsets.symmetric(
          horizontal: defaultPadding,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        backgroundColor: myPrimaryColor,
      ),
      onPressed: press,
      child: Text(title,
          style: TextStyle(
            color: Colors.white,
          )),
    );
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: defaultPadding / 4,
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.only(
                  right: defaultPadding / 4,
                ),
                height: 7,
                color: myPrimaryColor.withOpacity(0.2),
              ))
        ],
      ),
    );
  }
}
