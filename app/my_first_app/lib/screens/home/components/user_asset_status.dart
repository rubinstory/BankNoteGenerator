import 'package:flutter/material.dart';
import 'package:my_first_app/balance/balance_bloc.dart';
import 'package:my_first_app/balance/balance_model.dart';
import 'package:my_first_app/constants.dart';
import 'package:my_first_app/user/user.dart';
import 'package:my_first_app/user/user_bloc.dart';

class UserAssetStatusView extends StatefulWidget {
  @override
  _UserAssetStatusViewState createState() => _UserAssetStatusViewState();
}

double getBalance(List<BalanceModel> list) {
  double result = 0;
  for (var item in list) {
    result += item.total;
  }
  return result;
}

bool getResult(BalanceResponseModel? list, double originBalance) {
  if (list == null) return false;
  double calc = (getBalance(list.result)) / originBalance * 100 - 100;
  return calc >= 0 ? true : false;
}

class _UserAssetStatusViewState extends State<UserAssetStatusView> {
  final double originBalance = 84.0;
  @override
  Widget build(BuildContext context) {
    userBloc.fetchCurrentUser();
    balanceBloc.fetchBalances();
    return StreamBuilder<BalanceResponseModel>(
      stream: balanceBloc.balanceList,
      builder: (context, snapshot) {
        BalanceResponseModel? model = snapshot.data;
        return Container(
          margin: EdgeInsets.only(
            top: defaultPadding * 2,
            left: defaultPadding,
            right: defaultPadding,
            bottom: defaultPadding,
          ),
          child: Row(
            children: [
              StreamBuilder<UserModel>(
                  stream: userBloc.currentUser,
                  builder: (context, snapshot) {
                    UserModel? currentUser = snapshot.data;
                    return Container(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: currentUser != null
                                ? "${currentUser.fullName}님의 자산 현황\n\n"
                                : "NULL",
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
                            text: model != null
                                ? "${getBalance(model.result).toStringAsFixed(3)}"
                                : "NULL",
                            style: TextStyle(
                              color: myTextColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                      ),
                    );
                  }),
              Spacer(),
              Container(
                padding: EdgeInsets.only(
                  left: defaultPadding,
                  right: defaultPadding,
                  top: defaultPadding / 2,
                  bottom: defaultPadding / 2,
                ),
                decoration: BoxDecoration(
                  color: getResult(model, originBalance) ? positive : blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  model != null
                      ? "${(getBalance(model.result) / originBalance * 100 - 100).toStringAsFixed(2)}%"
                      : "NULL",
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
