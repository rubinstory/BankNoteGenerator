import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_first_app/api.dart';
import 'package:my_first_app/asset_manage/asset_manage.dart';
import 'package:my_first_app/asset_manage/asset_manage_bloc.dart';
import 'package:my_first_app/balance/balance_bloc.dart';
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    assetManageBloc.fetchAssetManageItem(CURRENT_USER_ID);
    balanceBloc.fetchBalances();
    return StreamBuilder<AssetManageModel>(
        stream: assetManageBloc.currentUserAssetManageItem,
        builder: (context, snapshot) {
          return RefreshIndicator(
            onRefresh: () {
              balanceBloc.fetchBalances();
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
                          TitleWithOnlyText(title: "보유 자산 현황"),
                          PieChartSample1(),
                          TitleWithOnlyText(title: "나의 투자 성향"),
                          UserInvestmentTypeView(size: size),
                          SingleRowWithTextAndButton(
                              title: "투자 유형 변경",
                              press: () {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SurveyScreen(),
                                  ),
                                );
                              }),
                          SingleRowWithTextAndButton(
                              title: "거래 내역",
                              press: () {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TransactionScreen(),
                                  ),
                                );
                              }),
                          SingleRowWithTextAndButton(
                              title: "보유 종목", press: () {}),
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
                          // 신중한 부엉이, 날렵한 여우
                          style: TextStyle(
                            color: myTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              "수익 추구를 위해 위험을 감수하시는 투자를\n선호하시네요. 투자 알고리즘 GOOSE가 위험\n자산의 비중을 높임과 동시에 위험을 낮추는\n채권에도 투자해요.",
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
