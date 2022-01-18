import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/api.dart';
import 'package:my_first_app/asset_manage/asset_manage.dart';
import 'package:my_first_app/asset_manage/asset_manage_bloc.dart';
import 'package:my_first_app/constants.dart';
import 'package:my_first_app/user/user_bloc.dart';

class UserAutoStatusView extends StatefulWidget {
  @override
  State<UserAutoStatusView> createState() => _UserAutoStatusViewState();
}

class _UserAutoStatusViewState extends State<UserAutoStatusView> {
  @override
  void initState() {
    super.initState();
    assetManageBloc.fetchAssetManageItem(CURRENT_USER_ID);
  }

  @override
  Widget build(BuildContext context) {
    // assetManageBloc.fetchAssetManageItem(CURRENT_USER_ID);
    return StreamBuilder<AssetManageModel>(
        stream: assetManageBloc.currentUserAssetManageItem,
        builder: (context, snapshot) {
          AssetManageModel assetManageModel = snapshot.data!;
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
                        text: "투자 성향\n\n",
                        style: TextStyle(
                          color: myTextColor,
                          fontSize: 18,
                        ),
                      ),
                      TextSpan(
                        text: "TYPE-${assetManageModel.algorithm_type} 알고리즘",
                        style: TextStyle(
                          color: myTextColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                  ),
                ),
                Spacer(),
                AutoTradingButton(),
              ],
            ),
          );
        });
  }
}

class AutoTradingButton extends StatefulWidget {
  @override
  _AutoTradingButtonState createState() => _AutoTradingButtonState();
}

class _AutoTradingButtonState extends State<AutoTradingButton> {
  @override
  void initState() {
    super.initState();
    assetManageBloc.fetchAssetManageItem(CURRENT_USER_ID);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AssetManageModel>(
        stream: assetManageBloc.currentUserAssetManageItem,
        builder: (context, snapshot) {
          AssetManageModel assetManageModel = snapshot.data!;
          return Container(
            decoration: BoxDecoration(
              color: assetManageModel.automatic_investment_status
                  ? onProgress
                  : lightgrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.all(defaultPadding / 2),
                ),
              ),
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text("자동 투자 유형 변경"),
                      content: assetManageModel.automatic_investment_status
                          ? Text("자동 투자를 중지하시겠습니까?")
                          : Text("자동 투자를 시작 하시겠습니까?"),
                      actions: [
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          child: Text("아니오"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoDialogAction(
                          textStyle: TextStyle(
                            color: Colors.red,
                          ),
                          isDefaultAction: true,
                          child: Text("예"),
                          onPressed: () {
                            assetManageModel.automatic_investment_status =
                                !assetManageModel.automatic_investment_status;
                            assetManageBloc
                                .updateAssetManageItem(assetManageModel);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                assetManageModel.automatic_investment_status
                    ? "자동 투자 진행 중"
                    : "자동 투자 일시정지",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
  }
}
