import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_first_app/api.dart';
import 'package:my_first_app/asset_manage/asset_manage_bloc.dart';
import 'package:my_first_app/constants.dart';
import 'package:my_first_app/screens/trading/components/body.dart';
import 'package:my_first_app/transaction/transaction_bloc.dart';
import 'package:my_first_app/transaction/transaction_model.dart';
import 'package:my_first_app/user/user.dart';
import 'package:my_first_app/user/user_bloc.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    userBloc.fetchCurrentUser();
    return StreamBuilder<UserModel>(
      stream: userBloc.currentUser,
      builder: (context, snapshot) {
        UserModel user = snapshot.data!;
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(defaultPadding / 4),
                padding: EdgeInsets.all(defaultPadding),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${user.fullName}님의\n거래 현황",
                        style: TextStyle(
                          color: myTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              HorizontalBar(height: 10),
              Expanded(
                child: TransactionListView(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TransactionListView extends StatefulWidget {
  @override
  State<TransactionListView> createState() => _TransactionListViewState();
}

class _TransactionListViewState extends State<TransactionListView> {
  @override
  Widget build(BuildContext context) {
    transactionBloc.fetchTransactionList(CURRENT_USER_ID);
    return RefreshIndicator(
      onRefresh: () {
        return transactionBloc.fetchTransactionList(CURRENT_USER_ID);
      },
      backgroundColor: myPrimaryColor,
      color: Colors.white,
      child: StreamBuilder<List<TransactionModel>>(
        stream: transactionBloc.currentUserTransactionList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _build(snapshot.data!);
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
        },
      ),
    );
  }
}

Widget _build(List<TransactionModel> transactionList) {
  return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: transactionList.length,
      itemBuilder: (BuildContext context, int index) {
        return TransactionItem(
          date: transactionList[index].createdAt,
          time: transactionList[index].createdAt,
          ticker: transactionList[index].market,
          side: transactionList[index].side,
          quantity: transactionList[index].size,
          avgPrice: transactionList[index].avgFillPrice,
        );
      });
}

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.date,
    required this.time,
    required this.ticker,
    required this.side,
    required this.quantity,
    required this.avgPrice,
  }) : super(key: key);

  final String date, time, ticker, side;
  final double quantity, avgPrice;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 1.0,
      margin: EdgeInsets.all(defaultPadding / 4),
      padding: EdgeInsets.all(defaultPadding),
      child: Row(
        children: [
          Container(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${date.split("T")[0]}\n",
                    style: TextStyle(
                      color: lightgrey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "${date.split("T")[1].split(".")[0]}\n\n",
                    style: TextStyle(
                      color: myTextColor,
                      fontSize: 20,
                    ),
                  ),
                  TextSpan(
                    text: "${ticker.split("-")[0]}",
                    style: TextStyle(
                      color: side == "buy" ? negative : positive,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Quantity\n",
                  style: TextStyle(
                    color: lightgrey,
                    fontSize: 13,
                  ),
                ),
                TextSpan(
                  text: "$quantity\n\n",
                  style: TextStyle(
                    color: side == "buy" ? negative : positive,
                    fontSize: 17,
                  ),
                ),
                TextSpan(
                  text: "Avg. Fill Price\n",
                  style: TextStyle(
                    color: lightgrey,
                    fontSize: 13,
                  ),
                ),
                TextSpan(
                  text: "$avgPrice",
                  style: TextStyle(
                    color: side == "buy" ? negative : positive,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
