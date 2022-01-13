import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_first_app/constants.dart';
import 'package:my_first_app/screens/details/components/icon_card.dart';
import 'package:my_first_app/screens/details/components/image_and_icons.dart';
import 'package:my_first_app/screens/details/components/title_and_price.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ImageAndIcons(size: size),
          TitleAndPrice(
            title: "Ang2elica",
            country: "Russia",
            price: 440,
          ),
          SizedBox(height: defaultPadding),
          Row(
            children: <Widget>[
              SizedBox(
                width: size.width / 2,
                height: 84,
                child: TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(20)),
                    )),
                    backgroundColor: MaterialStateProperty.all(myPrimaryColor),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Buy Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Description",
                    style: TextStyle(
                      color: myTextColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
