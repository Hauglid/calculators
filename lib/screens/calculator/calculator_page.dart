import 'package:flutter/material.dart';

class Calculator extends StatelessWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<Widget>(
      builder: (_) => Calculator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Calculator'),
        ),
        body: Center(
          child: Text('Calculator'),
        ));
  }
}
