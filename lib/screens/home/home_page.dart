import 'package:calculators/screens/bmi/bmi_page.dart';
import 'package:calculators/screens/calculator/calculator_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
      ),
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        children: [
          Card(
            child: InkWell(
              onTap: () => Navigator.of(context).push(BmiPage.route()),
              child: const Center(
                child: Text(
                  'BMI',
                ),
              ),
            ),
          ),
          Card(
            child: InkWell(
              onTap: () => Navigator.of(context).push(Calculator.route()),
              child: const Center(
                child: Text(
                  'Calculator',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
