import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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
    return Container(
      width: size.width * 0.9,
      child: AspectRatio(
        aspectRatio: 1.1,
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
                // Row(
                //   children: [
                //     Container(
                //       margin: EdgeInsets.only(
                //         left: defaultPadding,
                //         bottom: defaultPadding / 2,
                //       ),
                //       child: Text(
                //         "보유 자산 항목",
                //         style: TextStyle(
                //           color: myPrimaryColor,
                //           fontSize: 20,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Indicator(
                      color: const Color(0xff0293ee),
                      text: 'BTC',
                      isSquare: false,
                      size: touchedIndex == 0 ? 18 : 16,
                      textColor: touchedIndex == 0 ? Colors.black : Colors.grey,
                    ),
                    Indicator(
                      color: const Color(0xfff8b250),
                      text: 'ETC',
                      isSquare: false,
                      size: touchedIndex == 1 ? 18 : 16,
                      textColor: touchedIndex == 1 ? Colors.black : Colors.grey,
                    ),
                    Indicator(
                      color: const Color(0xff845bef),
                      text: 'XRP',
                      isSquare: false,
                      size: touchedIndex == 2 ? 18 : 16,
                      textColor: touchedIndex == 2 ? Colors.black : Colors.grey,
                    ),
                    Indicator(
                      color: const Color(0xff13d38e),
                      text: 'EMC2',
                      isSquare: false,
                      size: touchedIndex == 3 ? 18 : 16,
                      textColor: touchedIndex == 3 ? Colors.black : Colors.grey,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                          pieTouchData: PieTouchData(touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          }),
                          startDegreeOffset: 180,
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 1,
                          centerSpaceRadius: 0,
                          sections: showingSections()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      4,
      (i) {
        final isTouched = i == touchedIndex;
        final opacity = isTouched ? 1.0 : 0.6;

        const color0 = Color(0xff0293ee);
        const color1 = Color(0xfff8b250);
        const color2 = Color(0xff845bef);
        const color3 = Color(0xff13d38e);

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: color0.withOpacity(opacity),
              value: 25,
              title: '',
              radius: 80,
              titleStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff044d7c)),
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? BorderSide(color: color0.darken(40), width: 6)
                  : BorderSide(color: color0.withOpacity(0)),
            );
          case 1:
            return PieChartSectionData(
              color: color1.withOpacity(opacity),
              value: 25,
              title: '',
              radius: 65,
              titleStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff90672d)),
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? BorderSide(color: color1.darken(40), width: 6)
                  : BorderSide(color: color2.withOpacity(0)),
            );
          case 2:
            return PieChartSectionData(
              color: color2.withOpacity(opacity),
              value: 25,
              title: '',
              radius: 60,
              titleStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4c3788)),
              titlePositionPercentageOffset: 0.6,
              borderSide: isTouched
                  ? BorderSide(color: color2.darken(40), width: 6)
                  : BorderSide(color: color2.withOpacity(0)),
            );
          case 3:
            return PieChartSectionData(
              color: color3.withOpacity(opacity),
              value: 25,
              title: '',
              radius: 70,
              titleStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0c7f55)),
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? BorderSide(color: color3.darken(40), width: 6)
                  : BorderSide(color: color2.withOpacity(0)),
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
