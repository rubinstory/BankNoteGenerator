import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({
    Key? key,
    required this.press,
  }) : super(key: key);

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: defaultPadding * 2,
        right: defaultPadding * 2,
        bottom: defaultPadding,
      ),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: myPrimaryColor.withOpacity(myShadowBlurOpacity),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: press,
            icon: SvgPicture.asset(
              "assets/icons/home.svg",
              color: Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/chart.svg",
              color: Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/stock.svg",
              color: Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/user-icon.svg",
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
