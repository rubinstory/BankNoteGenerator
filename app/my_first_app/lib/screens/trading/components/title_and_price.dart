import 'package:flutter/material.dart';
import 'package:my_first_app/constants.dart';

class TitleAndPrice extends StatelessWidget {
  const TitleAndPrice({
    Key? key,
    required this.title,
    required this.country,
    required this.price,
  }) : super(key: key);

  final String title, country;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
      ),
      child: Row(
        children: <Widget>[
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: "$title\n",
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: myTextColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextSpan(
                text: "$country",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: myPrimaryColor,
                ),
              )
            ]),
          ),
          Spacer(),
          Text(
            "\$$price",
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: myPrimaryColor,
                ),
          )
        ],
      ),
    );
  }
}
