import 'package:flutter/material.dart';
import 'package:my_first_app/constants.dart';
import 'package:my_first_app/screens/home/home_screen.dart';
import 'package:my_first_app/screens/main/tab_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GOOFIE',
      theme: ThemeData(
        primaryColor: myPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: myTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TabPage(),
    );
  }
}
