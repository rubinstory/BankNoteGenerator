import 'package:flutter/material.dart';

import '../../../constants.dart';

class ImageHorizontalViewWithoutText extends StatelessWidget {
  const ImageHorizontalViewWithoutText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          SingleImage(
            image: "assets/images/bottom_img_1.png",
            press: () {
              print("123");
            },
          ),
          SingleImage(
            image: "assets/images/bottom_img_2.png",
            press: () {
              print("123");
            },
          ),
        ],
      ),
    );
  }
}

class SingleImage extends StatelessWidget {
  const SingleImage({
    Key? key,
    required this.image,
    required this.press,
  }) : super(key: key);

  final String image;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(
          left: defaultPadding,
          top: defaultPadding / 2,
          bottom: defaultPadding / 2,
        ),
        width: size.width * 0.8,
        height: 185,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(image),
            )),
      ),
    );
  }
}
