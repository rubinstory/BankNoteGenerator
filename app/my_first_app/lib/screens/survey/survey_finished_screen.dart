import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_first_app/api.dart';
import 'package:my_first_app/asset_manage/asset_manage.dart';
import 'package:my_first_app/asset_manage/asset_manage_bloc.dart';
import 'package:my_first_app/constants.dart';
import 'package:my_first_app/screens/main/tab_page.dart';
import 'package:my_first_app/user/user.dart';
import 'package:my_first_app/user/user_bloc.dart';

String caluclate_result(List<int> list) {
  var result = (6 - list[0]) + list[1] + list[2];
  if (result == 3)
    return "D";
  else if (result <= 7)
    return "C";
  else if (result <= 11) return "B";
  return "A";
}

String getEmoji(String type) {
  switch (type) {
    case "A":
      return "\n🐯\n";
    case "B":
      return "\n🦊\n";
    case "C":
      return "\n🦉\n";
  }
  return "\n🐢\n";
}

String getTitle(String type) {
  switch (type) {
    case "A":
      return "용감한 호랑이";
    case "B":
      return "날렵한 여우";
    case "C":
      return "현명한 부엉이";
  }
  return "신중한 거북이";
}

Color getColor(String type) {
  switch (type) {
    case "A":
      return myPrimaryColor;
    case "B":
      return foxOrange;
    case "C":
      return owlBrown;
  }
  return turtleGreen;
}

class SurveyFinishedScreen extends StatefulWidget {
  SurveyFinishedScreen({
    required List<int> this.list,
  }) : super();
  final List<int> list;
  @override
  _SurveyFinishedScreenState createState() => _SurveyFinishedScreenState();
}

class _SurveyFinishedScreenState extends State<SurveyFinishedScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<int> list = widget.list;

    assetManageBloc.fetchAssetManageItem(CURRENT_USER_ID);
    return StreamBuilder<AssetManageModel>(
        stream: assetManageBloc.currentUserAssetManageItem,
        builder: (context, snapshot) {
          AssetManageModel model = snapshot.data!;
          userBloc.fetchCurrentUser();
          String type = caluclate_result(list);
          return Scaffold(
            body: Container(
              margin: EdgeInsets.only(
                top: defaultPadding * 2,
              ),
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  StreamBuilder<UserModel>(
                      stream: userBloc.currentUser,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          UserModel user = snapshot.data!;
                          return RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: getEmoji(type),
                                  style: TextStyle(
                                    color: myTextColor,
                                    fontSize: 50,
                                  ),
                                ),
                                TextSpan(
                                  text: "${user.fullName}님은\n",
                                  style: TextStyle(
                                    color: myTextColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                    text: " \n",
                                    style: TextStyle(
                                      fontSize: 5,
                                    )),
                                TextSpan(
                                  text: getTitle(type),
                                  style: TextStyle(
                                    color: getColor(type),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: "입니다!",
                                  style: TextStyle(
                                    color: myTextColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: myPrimaryColor,
                              ),
                            ],
                          );
                        }
                      }),
                  SizedBox(height: 20),
                  Text(
                      "수익 추구를 위해 위험을 감수하는 투자를 선호하시네요. 투자 알고리즘 GOOSE가 위험 자산의 비중을 높임과 동시에 위험을 낮출 수 있는 안전 자산에도 투자합니다."),
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "위 성향으로 투자를 진행하시겠습니까?",
                      style: TextStyle(
                        color: myTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(lightyellow),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: size.width * 0.325,
                            padding: EdgeInsets.all(defaultPadding / 2),
                            child: Text(
                              "재설문",
                              style: TextStyle(
                                fontSize: 17,
                                color: myPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                myPrimaryColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () {
                            // send data to server

                            // assetManageBloc.currentUserAssetManageItem;
                            model.answer_to_question_1 = list[0];
                            model.answer_to_question_2 = list[1];
                            model.answer_to_question_3 = list[2];
                            assetManageBloc.updateAssetManageItem(model);
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/Home", (route) => false);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: size.width * 0.325,
                            padding: EdgeInsets.all(defaultPadding / 2),
                            child: Text(
                              "제출하기",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  AppBar BuildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: myBackGroundColor,
      title: Text(""),
      actions: [
        Container(
          margin: EdgeInsets.only(right: defaultPadding / 2),
          padding: EdgeInsets.all(defaultPadding / 5),
          child: IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/Home", (route) => false);
              },
              icon: SvgPicture.asset(
                "assets/icons/cancel.svg",
                color: myPrimaryColor,
              )),
        ),
      ],
    );
  }
}
