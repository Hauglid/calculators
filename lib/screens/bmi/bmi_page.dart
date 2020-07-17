import 'package:flutter/material.dart';

class BmiPage extends StatelessWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<Widget>(
      builder: (_) => BmiPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('BMI'),
        ),
        body: const Center(
          child: Text('BMI'),
        ));
  }
}
