import 'package:flutter/material.dart';
import 'package:my_first_app/constants.dart';
import 'package:my_first_app/user/user.dart';
import 'package:my_first_app/user/user_bloc.dart';

class UserAssetStatusView extends StatefulWidget {
  @override
  _UserAssetStatusViewState createState() => _UserAssetStatusViewState();
}

class _UserAssetStatusViewState extends State<UserAssetStatusView> {
  @override
  Widget build(BuildContext context) {
    userBloc.fetchCurrentUser();
    return StreamBuilder<UserModel>(
      stream: userBloc.currentUser,
      builder: (context, snapshot) {
        UserModel currentUser = snapshot.data!;
        return Container(
          margin: EdgeInsets.only(
            top: defaultPadding * 2,
            left: defaultPadding,
            right: defaultPadding,
            bottom: defaultPadding,
          ),
          child: Row(
            children: [
              Container(
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "${currentUser.fullName}님의 자산 현황\n\n",
                      style: TextStyle(
                        color: myTextColor,
                        fontSize: 18,
                      ),
                    ),
                    TextSpan(
                      text: "USD ",
                      style: TextStyle(
                        color: myTextColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "1,214",
                      style: TextStyle(
                        color: myTextColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.only(
                  left: defaultPadding,
                  right: defaultPadding,
                  top: defaultPadding / 2,
                  bottom: defaultPadding / 2,
                ),
                decoration: BoxDecoration(
                  color: positive,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "5.24%",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
