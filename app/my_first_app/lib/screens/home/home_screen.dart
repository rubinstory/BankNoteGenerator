import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_first_app/constants.dart';

import 'components/body.dart';
import 'components/bottom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myPrimaryColor,
      // appBar: BuildAppBar(),
      body: Body(),
      // bottomNavigationBar: MyBottomNavigationBar(),
    );
  }

  AppBar BuildAppBar() {
    return AppBar(
        title: Text("홈"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/icons/menu.svg")),
        ]);
  }
}
