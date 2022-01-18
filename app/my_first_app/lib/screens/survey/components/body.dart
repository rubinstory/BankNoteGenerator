import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_first_app/constants.dart';
import 'package:my_first_app/screens/survey/survey_finished_screen.dart';
import 'package:my_first_app/screens/trading/components/body.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<int> _isSelected = [
    0,
    0,
    0,
  ];
  int _currentState = 0;
  PageController _pageController = PageController();

  void nextPage() {
    _pageController.animateToPage(
      _currentState + 1,
      duration: Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
  }

  void finishSurvey() {
    // Navigator.pushNamed(context, "/SurveyFinished");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SurveyFinishedScreen(list: _isSelected),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: myBackGroundColor,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: PageView(
              onPageChanged: (i) {
                setState(() {
                  _currentState = i;
                });
              },
              controller: _pageController,
              children: [
                Container(
                  padding: EdgeInsets.all(defaultPadding / 2),
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(defaultPadding),
                        child: Text(
                          "고객님의 연령대를\n선택해 주세요.",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(defaultPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ChoiceChip(
                              padding: EdgeInsets.all(defaultPadding),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              label: Text("10대 ~ 20대에요."),
                              selected: _isSelected[0] == 1,
                              onSelected: (bool selected) {
                                setState(() {
                                  _isSelected[0] = 1;
                                  nextPage();
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            ChoiceChip(
                              padding: EdgeInsets.all(defaultPadding),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              label: Text("30대에요."),
                              selected: _isSelected[0] == 2,
                              onSelected: (bool selected) {
                                setState(() {
                                  _isSelected[0] = 2;
                                  nextPage();
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            ChoiceChip(
                              padding: EdgeInsets.all(defaultPadding),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              label: Text("40대에요."),
                              selected: _isSelected[0] == 3,
                              onSelected: (bool selected) {
                                setState(() {
                                  _isSelected[0] = 3;
                                  nextPage();
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            ChoiceChip(
                              padding: EdgeInsets.all(defaultPadding),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              label: Text("50대에요."),
                              selected: _isSelected[0] == 4,
                              onSelected: (bool selected) {
                                setState(() {
                                  _isSelected[0] = 4;
                                  nextPage();
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            ChoiceChip(
                              padding: EdgeInsets.all(defaultPadding),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              label: Text("60대 이상이에요."),
                              selected: _isSelected[0] == 5,
                              onSelected: (bool selected) {
                                setState(() {
                                  _isSelected[0] = 5;
                                  nextPage();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(defaultPadding / 2),
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(defaultPadding),
                        child: Text(
                          "투자할 때 생각하시는\n위험은 어느 정도이신가요?",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(defaultPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ChoiceChip(
                              padding: EdgeInsets.all(defaultPadding),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              label: Text("위험한 자산은 싫어요."),
                              selected: _isSelected[1] == 1,
                              onSelected: (bool selected) {
                                setState(() {
                                  _isSelected[1] = 1;
                                  nextPage();
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            ChoiceChip(
                              padding: EdgeInsets.all(defaultPadding),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              label: Text("최대한 낮은 위험도를 원해요."),
                              selected: _isSelected[1] == 2,
                              onSelected: (bool selected) {
                                setState(() {
                                  _isSelected[1] = 2;
                                  nextPage();
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            ChoiceChip(
                              padding: EdgeInsets.all(defaultPadding),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              label: Text("적당한 모험은 좋아요."),
                              selected: _isSelected[1] == 3,
                              onSelected: (bool selected) {
                                setState(() {
                                  _isSelected[1] = 3;
                                  nextPage();
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            ChoiceChip(
                              padding: EdgeInsets.all(defaultPadding),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              label: Text("모험을 즐기는 편이에요."),
                              selected: _isSelected[1] == 4,
                              onSelected: (bool selected) {
                                setState(() {
                                  _isSelected[1] = 4;
                                  nextPage();
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            ChoiceChip(
                              padding: EdgeInsets.all(defaultPadding),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              label: Text("인생은 한방! 모험가 기질이에요."),
                              selected: _isSelected[1] == 5,
                              onSelected: (bool selected) {
                                setState(() {
                                  _isSelected[1] = 5;
                                  nextPage();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(defaultPadding / 2),
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(defaultPadding),
                        child: Text(
                          "투자 시 발생하는 손실을\n얼마나 견디실 수 있나요?",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(defaultPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ChoiceChip(
                              padding: EdgeInsets.all(defaultPadding),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              label: Text("단 한 푼도 안돼요."),
                              selected: _isSelected[2] == 1,
                              onSelected: (bool selected) {
                                setState(() {
                                  _isSelected[2] = 1;
                                  finishSurvey();
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            ChoiceChip(
                              padding: EdgeInsets.all(defaultPadding),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              label: Text("5% 이내는 괜찮아요."),
                              selected: _isSelected[2] == 2,
                              onSelected: (bool selected) {
                                setState(() {
                                  _isSelected[2] = 2;
                                  finishSurvey();
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            ChoiceChip(
                              padding: EdgeInsets.all(defaultPadding),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              label: Text("10%까지도 괜찮아요."),
                              selected: _isSelected[2] == 3,
                              onSelected: (bool selected) {
                                setState(() {
                                  _isSelected[2] = 3;
                                  finishSurvey();
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            ChoiceChip(
                              padding: EdgeInsets.all(defaultPadding),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              label: Text("25%도 버틸 수 있어요."),
                              selected: _isSelected[2] == 4,
                              onSelected: (bool selected) {
                                setState(() {
                                  _isSelected[2] = 4;
                                  finishSurvey();
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            ChoiceChip(
                              padding: EdgeInsets.all(defaultPadding),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              label: Text("하이 리스크 하이 리턴!"),
                              selected: _isSelected[2] == 5,
                              onSelected: (bool selected) {
                                setState(() {
                                  _isSelected[2] = 5;
                                  finishSurvey();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: defaultPadding * 2,
            ),
            padding: EdgeInsets.all(defaultPadding),
            alignment: Alignment.bottomCenter,
            child: AnimatedSmoothIndicator(
              activeIndex: _currentState,
              count: _isSelected.length,
              effect: ExpandingDotsEffect(
                dotColor: lightlightgrey,
                activeDotColor: myPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
