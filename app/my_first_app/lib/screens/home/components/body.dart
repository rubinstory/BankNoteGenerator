import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_first_app/constants.dart';
import 'package:my_first_app/screens/charts/line_chart.dart';
import 'package:my_first_app/screens/charts/pie_chart.dart';
import 'package:my_first_app/screens/home/components/square_card_horizontal_view.dart';
import 'package:my_first_app/screens/home/components/title_with_only_text.dart';
import 'package:my_first_app/screens/home/components/user_asset_status.dart';
import 'package:my_first_app/screens/home/components/wide_text_card_horizontal_view.dart';
import 'package:my_first_app/user/user_bloc.dart';
import 'header_with_searchbox.dart';
import 'image_horizontal_without_text.dart';
import 'title_with_text_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return RefreshIndicator(
      onRefresh: () {
        return userBloc.fetchCurrentUser();
      },
      backgroundColor: myPrimaryColor,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              UserAssetStatusView(),
              TitleWithOnlyText(title: "투자 둘러보기"),
              LineChartView(),
              TitleWithOnlyText(title: "슬기로운 투자생활"),
              WideTextCardHorizontalView(),
              TitleWithOnlyText(title: "구스 뉴스"),
              SquareCardHorizontalView(),
              SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
