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
      return "\nπ―\n";
    case "B":
      return "\nπ¦\n";
    case "C":
      return "\nπ¦\n";
  }
  return "\nπ’\n";
}

String getTitle(String type) {
  switch (type) {
    case "A":
      return "μ©κ°ν νΈλμ΄";
    case "B":
      return "λ λ ΅ν μ¬μ°";
    case "C":
      return "νλͺν λΆμμ΄";
  }
  return "μ μ€ν κ±°λΆμ΄";
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
                                  text: "${user.fullName}λμ\n",
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
                                  text: "μλλ€!",
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
                      "μμ΅ μΆκ΅¬λ₯Ό μν΄ μνμ κ°μνλ ν¬μλ₯Ό μ νΈνμλ€μ. ν¬μ μκ³ λ¦¬μ¦ GOOSEκ° μν μμ°μ λΉμ€μ λμκ³Ό λμμ μνμ λ?μΆ μ μλ μμ  μμ°μλ ν¬μν©λλ€."),
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "μ μ±ν₯μΌλ‘ ν¬μλ₯Ό μ§ννμκ² μ΅λκΉ?",
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
                              "μ¬μ€λ¬Έ",
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
                              "μ μΆνκΈ°",
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
