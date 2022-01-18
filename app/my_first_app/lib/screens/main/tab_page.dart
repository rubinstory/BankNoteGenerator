import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_first_app/constants.dart';
import 'package:my_first_app/screens/home/home_screen.dart';
import 'package:my_first_app/screens/notification/notification_screen.dart';
import 'package:my_first_app/screens/profile/profile_screen.dart';
import 'package:my_first_app/screens/survey/survey_screen.dart';
import 'package:my_first_app/screens/trading/detail_screen.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndex = 0;

  List _pages = [
    HomeScreen(),
    TradingScreen(),
    NotificationScreen(),
  ];

  List _pageNames = [
    "홈",
    "투자",
    "알림",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/home.svg",
                color: _selectedIndex == 0 ? Colors.black : Colors.grey,
              ),
              title: Text(""),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/chart.svg",
                color: _selectedIndex == 1 ? Colors.black : Colors.grey,
              ),
              title: Text(""),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/user-icon.svg",
                color: _selectedIndex == 2 ? Colors.black : Colors.grey,
              ),
              title: Text(""),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  AppBar BuildAppBar() {
    return AppBar(
      title: Text(
        _pageNames[_selectedIndex],
      ),
      elevation: 0,
      backgroundColor: myPrimaryColor,
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => ProfileScreen()));
            },
            icon: SvgPicture.asset("assets/icons/menu.svg")),
      ],
    );
  }
}
