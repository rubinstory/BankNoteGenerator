import 'package:flutter/material.dart';
import 'package:my_first_app/screens/details/detail_screen.dart';
import 'package:my_first_app/transaction/transaction.dart';
import 'package:my_first_app/transaction/transaction_bloc.dart';

import '../../../constants.dart';

class TransactionImageHorizontalList extends StatefulWidget {
  const TransactionImageHorizontalList({Key? key}) : super(key: key);

  @override
  _TransactionImageHorizontalListState createState() =>
      _TransactionImageHorizontalListState();
}

class _TransactionImageHorizontalListState
    extends State<TransactionImageHorizontalList> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    transactionBloc.fetchAllTransaction();
    return SizedBox(
      height: size.height * 0.4,
      width: size.width,
      child: StreamBuilder<List<TranscationModel>>(
        stream: transactionBloc.allTransactions,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return _build(snapshot.data!);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget _build(List<TranscationModel> transactionList) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: transactionList.length,
        itemBuilder: (BuildContext context, int index) {
          return ImageCard(
            image: "assets/images/image_1.png",
            title: "${transactionList[index].username}",
            country: "${transactionList[index].ticker}",
            price: transactionList[index].price,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(),
                ),
              );
            },
          );
        });
  }

  // Widget _build(List<TranscationModel> transactionList) {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: Row(
  //       children: [
  //         ImageCard(
  //           image: "assets/images/image_1.png",
  //           title: "samantha",
  //           country: "russia",
  //           price: 442,
  //           press: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => DetailScreen(),
  //               ),
  //             );
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

class ImageCardHorizontalView extends StatelessWidget {
  const ImageCardHorizontalView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ImageCard(
            image: "assets/images/image_1.png",
            title: "samantha",
            country: "russia",
            price: 442,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(),
                ),
              );
            },
          ),
          ImageCard(
            image: "assets/images/image_2.png",
            title: "Angelica",
            country: "AMERICA",
            price: 442,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(),
                ),
              );
            },
          ),
          ImageCard(
            image: "assets/images/image_3.png",
            title: "Something",
            country: "russia",
            price: 442,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({
    Key? key,
    required this.image,
    required this.title,
    required this.country,
    required this.price,
    required this.press,
  }) : super(key: key);

  final String image, title, country;
  final int price;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
          left: defaultPadding,
          top: defaultPadding / 2,
          bottom: defaultPadding * 2.5),
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[
          Image.asset(image),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: EdgeInsets.all(defaultPadding / 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: myPrimaryColor.withOpacity(0.23),
                  )
                ],
              ),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "$title\n".toUpperCase(),
                          style: Theme.of(context).textTheme.button,
                        ),
                        TextSpan(
                          text: "$country".toUpperCase(),
                          style: TextStyle(
                            color: myPrimaryColor.withOpacity(0.5),
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    '\$$price',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: myPrimaryColor),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
