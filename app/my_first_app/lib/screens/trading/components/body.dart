import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_first_app/api.dart';
import 'package:my_first_app/asset_manage/asset_manage.dart';
import 'package:my_first_app/asset_manage/asset_manage_bloc.dart';
import 'package:my_first_app/constants.dart';
import 'package:my_first_app/screens/charts/pie_chart.dart';
import 'package:my_first_app/screens/home/components/title_with_only_text.dart';
import 'package:my_first_app/screens/survey/survey_finished_screen.dart';
import 'package:my_first_app/screens/survey/survey_screen.dart';
import 'package:my_first_app/screens/trading/components/user_auto_status_view.dart';
import 'package:my_first_app/screens/transaction/transaction_screen.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    assetManageBloc.fetchAssetManageItem(CURRENT_USER_ID);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // assetManageBloc.fetchAssetManageItem(CURRENT_USER_ID);
    return StreamBuilder<AssetManageModel>(
        stream: assetManageBloc.currentUserAssetManageItem,
        builder: (context, snapshot) {
          return RefreshIndicator(
            onRefresh: () {
              return assetManageBloc.fetchAssetManageItem(CURRENT_USER_ID);
            },
            backgroundColor: myPrimaryColor,
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  UserAutoStatusView(),
                  HorizontalBar(height: 7.5),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: <Widget>[
                          TitleWithOnlyText(title: "?????? ?????? ??????"),
                          PieChartSample1(),
                          TitleWithOnlyText(title: "?????? ?????? ??????"),
                          UserInvestmentTypeView(size: size),
                          SingleRowWithTextAndButton(
                              title: "?????? ?????? ??????",
                              press: () {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SurveyScreen(),
                                  ),
                                );
                              }),
                          SingleRowWithTextAndButton(
                              title: "?????? ??????",
                              press: () {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TransactionScreen(),
                                  ),
                                );
                              }),
                          SingleRowWithTextAndButton(
                              title: "?????? ??????", press: () {}),
                          SizedBox(height: defaultPadding),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class HorizontalBar extends StatelessWidget {
  const HorizontalBar({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: EdgeInsets.only(
        top: defaultPadding / 2,
        // bottom: defaultPadding / 2,
      ),
      height: this.height,
      decoration: BoxDecoration(
        color: lightlightgrey,
      ),
    );
  }
}

class SingleRowWithTextAndButton extends StatelessWidget {
  const SingleRowWithTextAndButton({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: defaultPadding,
      ),
      padding: EdgeInsets.only(
        top: defaultPadding / 2,
        bottom: defaultPadding / 2,
        left: defaultPadding,
        right: defaultPadding,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/right_arrow.svg",
              width: 20,
              height: 20,
            ),
            onPressed: press,
          ),
        ],
      ),
    );
  }
}

class UserInvestmentTypeView extends StatefulWidget {
  const UserInvestmentTypeView({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<UserInvestmentTypeView> createState() => _UserInvestmentTypeViewState();
}

class _UserInvestmentTypeViewState extends State<UserInvestmentTypeView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AssetManageModel>(
        stream: assetManageBloc.currentUserAssetManageItem,
        builder: (context, snapshot) {
          AssetManageModel model = snapshot.data!;
          return Container(
            margin: EdgeInsets.only(
              left: defaultPadding,
              top: defaultPadding / 2,
              bottom: defaultPadding / 2,
              right: defaultPadding,
            ),
            width: widget.size.width * 0.9,
            height: 150,
            decoration: BoxDecoration(
              color: lightlightgrey,
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
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${getTitle(model.algorithm_type)}\n\n",
                          // ????????? ?????????, ????????? ??????
                          style: TextStyle(
                            color: myTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              "?????? ????????? ?????? ????????? ??????????????? ?????????\n??????????????????. ?????? ???????????? GOOSE??? ??????\n????????? ????????? ????????? ????????? ????????? ?????????\n???????????? ????????????.",
                          style: TextStyle(
                            color: myTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          );
        });
  }
}
