import 'package:flutter/material.dart';

import '../../../constants.dart';

class TitleWithOnlyText extends StatelessWidget {
  const TitleWithOnlyText({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

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
        ],
      ),
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
