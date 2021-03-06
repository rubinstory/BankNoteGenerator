import 'package:flutter/material.dart';
import 'package:my_first_app/constants.dart';
import 'package:my_first_app/screens/home/home_screen.dart';
import 'package:my_first_app/screens/login/components/authentication.dart';
import 'package:my_first_app/screens/login/login_screen.dart';
import 'package:my_first_app/screens/main/tab_page.dart';
import 'package:my_first_app/screens/survey/survey_finished_screen.dart';
import 'package:my_first_app/screens/survey/survey_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GOOSE',
        theme: ThemeData(
          primaryColor: myPrimaryColor,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: myTextColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: TabPage(),
        home: LoginScreen(),
        initialRoute: "/",
        routes: {
          "/Home": (BuildContext context) => TabPage(),
          "/Survey": (BuildContext context) => SurveyScreen(),
          // "/SurveyFinished": (BuildContext context) => SurveyFinishedScreen(),
        });
  }
}
