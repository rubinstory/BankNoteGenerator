import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_first_app/constants.dart';

import 'components/body.dart';

class SurveyScreen extends StatefulWidget {
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(),
      body: Body(),
    );
  }

  AppBar BuildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: myBackGroundColor,
      title: Text(""),
      actions: [
        Container(
          margin: EdgeInsets.only(right: defaultPadding / 2),
          padding: EdgeInsets.all(defaultPadding / 5),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset(
                "assets/icons/cancel.svg",
                color: myPrimaryColor,
              )),
        ),
      ],
    );
  }
}
