import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_first_app/constants.dart';

import 'header_with_searchbox.dart';
import 'image_card_horizontal_view.dart';
import 'image_horizontal_without_text.dart';
import 'title_with_text_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return height and width of our screen
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          TitleWithTextButton(title: "Views", button: "More", press: () {}),
          TransactionImageHorizontalList(),
          TitleWithTextButton(
              title: "Recommended", button: "Add", press: () {}),
          ImageHorizontalViewWithoutText(),
          SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
