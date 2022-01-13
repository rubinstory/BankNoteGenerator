import 'package:flutter/material.dart';
import 'package:my_first_app/screens/details/detail_screen.dart';

import '../../../constants.dart';

class ImageCardHorizontalView extends StatelessWidget {
  const ImageCardHorizontalView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ImageCard(
            image: "assets/images/image_1.png",
            title: "samantha",
            country: "russia",
            price: 442,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(),
                ),
              );
            },
          ),
          ImageCard(
            image: "assets/images/image_2.png",
            title: "Angelica",
            country: "AMERICA",
            price: 442,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(),
                ),
              );
            },
          ),
          ImageCard(
            image: "assets/images/image_3.png",
            title: "Something",
            country: "russia",
            price: 442,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({
    Key? key,
    required this.image,
    required this.title,
    required this.country,
    required this.price,
    required this.press,
  }) : super(key: key);

  final String image, title, country;
  final int price;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
          left: defaultPadding,
          top: defaultPadding / 2,
          bottom: defaultPadding * 2.5),
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[
          Image.asset(image),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: EdgeInsets.all(defaultPadding / 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: myPrimaryColor.withOpacity(0.23),
                  )
                ],
              ),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "$title\n".toUpperCase(),
                          style: Theme.of(context).textTheme.button,
                        ),
                        TextSpan(
                          text: "$country".toUpperCase(),
                          style: TextStyle(
                            color: myPrimaryColor.withOpacity(0.5),
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    '\$$price',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: myPrimaryColor),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
