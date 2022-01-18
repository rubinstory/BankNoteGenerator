import 'package:flutter/material.dart';
import 'package:my_first_app/constants.dart';

import 'components/body.dart';

class TransactionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myPrimaryColor,
      ),
      body: Body(),
    );
  }
}
