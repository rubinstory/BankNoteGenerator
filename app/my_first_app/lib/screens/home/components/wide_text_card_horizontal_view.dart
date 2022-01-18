import 'package:flutter/material.dart';

import '../../../constants.dart';

class WideTextCardHorizontalView extends StatelessWidget {
  const WideTextCardHorizontalView({
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
            color: myPrimaryColor,
            title: "매년 세액 공제 받으며\n구스와 노후 준비하기\n\n",
            keyword: "연금저축",
            image: "assets/images/umbrella.png",
          ),
          WideTextCardWithImage(
            color: lightblue,
            title: "결제하고 적립금과\n투자 지원금 받기\n\n",
            keyword: "구스 카드",
            image: "assets/images/card.png",
          ),
          WideTextCardWithImage(
            color: lightred,
            title: "잔돈 모아서\n자동으로 투자하기\n\n",
            keyword: "잔돈 저금통",
            image: "assets/images/piggy.png",
          ),
        ],
      ),
    );
  }
}

class WideTextCardWithImage extends StatelessWidget {
  const WideTextCardWithImage({
    Key? key,
    required this.color,
    required this.title,
    required this.keyword,
    required this.image,
  }) : super(key: key);
  final Color color;
  final String title, keyword, image;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: defaultPadding,
        top: defaultPadding / 2,
        bottom: defaultPadding / 2,
        right: defaultPadding,
      ),
      width: size.width * 0.9,
      height: 185,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: defaultPadding,
              top: 0,
            ),
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "$title",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "$keyword",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ]),
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.only(right: defaultPadding),
            child: Image.asset(
              "$image",
              width: 100,
              height: 100,
            ),
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
          right: defaultPadding,
        ),
        width: size.width * 0.8,
        height: 185,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}
