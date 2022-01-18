import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/balance/balance_bloc.dart';
import 'package:my_first_app/balance/balance_model.dart';
import 'package:my_first_app/constants.dart';
import 'package:my_first_app/screens/charts/color_extensionds.dart';

class PieChartSample1 extends StatefulWidget {
  const PieChartSample1({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => PieChartSample1State();
}

class PieChartSample1State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<BalanceResponseModel>(
        stream: balanceBloc.balanceList,
        builder: (context, snapshot) {
          return Container(
            width: size.width * 0.9,
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: myPrimaryColor.withOpacity(0.05),
                    )
                  ],
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: myPrimaryColor.withOpacity(myShadowBlurOpacity),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 28,
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                        width: size.width * 0.7,
                        child: snapshot.hasData
                            ? _build(snapshot.data!)
                            : Text("Loading"),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Expanded(
                        child: snapshot.hasData
                            ? AspectRatio(
                                aspectRatio: 1,
                                child: PieChart(
                                  PieChartData(
                                      pieTouchData: PieTouchData(touchCallback:
                                          (FlTouchEvent event,
                                              pieTouchResponse) {
                                        setState(() {
                                          if (!event
                                                  .isInterestedForInteractions ||
                                              pieTouchResponse == null ||
                                              pieTouchResponse.touchedSection ==
                                                  null) {
                                            touchedIndex = -1;
                                            return;
                                          }
                                          touchedIndex = pieTouchResponse
                                              .touchedSection!
                                              .touchedSectionIndex;
                                        });
                                      }),
                                      startDegreeOffset: 180,
                                      borderData: FlBorderData(
                                        show: false,
                                      ),
                                      sectionsSpace: 1,
                                      centerSpaceRadius: 0,
                                      sections:
                                          showingSections(snapshot.data!)),
                                ),
                              )
                            : Text("LOADING"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _build(BalanceResponseModel model) {
    List<BalanceModel> list = model.result;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(defaultPadding / 5),
          child: Indicator(
            color: getColor(list[index].coin),
            text: list[index].coin,
            isSquare: false,
            size: touchedIndex == index ? 18 : 16,
            textColor: touchedIndex == index ? Colors.black : Colors.grey,
          ),
        );
      },
    );
  }

  Color getColor(String ticker) {
    switch (ticker) {
      case "USD":
        return Color(0xff0293ee);
      case "XRP":
        return Color(0xfff8b250);
      case "USDT":
        return Color(0xff845bef);
    }
    return Color(0xff13d38e);
  }

  List<PieChartSectionData> showingSections(BalanceResponseModel model) {
    List<BalanceModel> list = model.result;
    return List.generate(
      4,
      (i) {
        final isTouched = i == touchedIndex;
        final opacity = isTouched ? 1.0 : 0.6;
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: getColor(list[i].coin),
              value: 10,
              title: '',
              radius: 80,
              titleStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff044d7c)),
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? BorderSide(
                      color: getColor(list[i].coin).darken(40), width: 6)
                  : BorderSide(color: getColor(list[i].coin).withOpacity(0)),
            );
          case 1:
            return PieChartSectionData(
              color: getColor(list[i].coin).withOpacity(opacity),
              value: 8,
              title: '',
              radius: 80,
              titleStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff90672d)),
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? BorderSide(
                      color: getColor(list[i].coin).darken(40), width: 6)
                  : BorderSide(color: getColor(list[i].coin).withOpacity(0)),
            );
          case 2:
            return PieChartSectionData(
              color: getColor(list[i].coin).withOpacity(opacity),
              value: 6,
              title: '',
              radius: 80,
              titleStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4c3788)),
              titlePositionPercentageOffset: 0.6,
              borderSide: isTouched
                  ? BorderSide(
                      color: getColor(list[i].coin).darken(40), width: 6)
                  : BorderSide(color: getColor(list[i].coin).withOpacity(0)),
            );
          case 3:
            return PieChartSectionData(
              color: getColor(list[i].coin).withOpacity(opacity),
              value: 4,
              title: '',
              radius: 80,
              titleStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0c7f55)),
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? BorderSide(
                      color: getColor(list[i].coin).darken(40), width: 6)
                  : BorderSide(color: getColor(list[i].coin).withOpacity(0)),
            );
          default:
            throw Error();
        }
      },
    );
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key? key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}
