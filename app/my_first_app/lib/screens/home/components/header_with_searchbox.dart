import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    // return height and width of our screen
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.only(bottom: defaultPadding * 2.5),
        height: size.height * 0.2, // Cover 20% of total height
        child: Stack(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(
                  left: defaultPadding,
                  right: defaultPadding,
                  bottom: 36 + defaultPadding,
                ),
                height: size.height * 0.2 - 27,
                decoration: BoxDecoration(
                  color: myPrimaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36)),
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Hi Uishopy!',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Image.asset("assets/images/logo.png"),
                  ],
                )),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  height: 54,
                  margin: EdgeInsets.symmetric(horizontal: defaultPadding),
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: myPrimaryColor.withOpacity(0.23),
                        )
                      ]),
                  child: TextField(
                    cursorColor: myPrimaryColor,
                    decoration: InputDecoration(
                      hintText: "Search ID",
                      hintStyle: TextStyle(
                        color: myTextColor.withOpacity(0.5),
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                    ),
                  ),
                ))
          ],
        ));
  }
}
