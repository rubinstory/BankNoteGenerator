import 'package:flutter/material.dart';

import '../../../constants.dart';

class SquareCardHorizontalView extends StatelessWidget {
  const SquareCardHorizontalView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          WideTextCardWithImage(
            backgroundColor: 0xFF003399,
            title: "2021년\n성과 리포트",
            keyword: "연금저축",
            image: "assets/images/report.png",
          ),
          WideTextCardWithImage(
            backgroundColor: 0xFF00CCFF,
            title: "2022년 새해\n복 많이 받으세요\n\n",
            keyword: "구스 카드",
            image: "assets/images/champagne.png",
          ),
          WideTextCardWithImage(
            backgroundColor: 0xFFB19CD9,
            title: "생애최초\n내집마련\n\n",
            keyword: "잔돈 저금통",
            image: "assets/images/apartment.png",
          ),
        ],
      ),
    );
  }
}

class WideTextCardWithImage extends StatelessWidget {
  const WideTextCardWithImage({
    Key? key,
    required this.backgroundColor,
    required this.title,
    required this.keyword,
    required this.image,
  }) : super(key: key);
  final int backgroundColor;
  final String title, keyword, image;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: defaultPadding / 2,
        top: defaultPadding / 2,
        bottom: defaultPadding / 2,
        right: defaultPadding / 2,
      ),
      width: size.width * 0.5,
      height: 185,
      decoration: BoxDecoration(
        color: Color(backgroundColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "$title",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  "$image",
                  width: 60,
                  height: 60,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
