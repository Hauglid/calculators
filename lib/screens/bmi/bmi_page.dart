import 'package:calculators/screens/bmi/widgets/bmi_content_card.dart';
import 'package:calculators/screens/bmi/widgets/gender_selector.dart';
import 'package:calculators/screens/bmi/widgets/weight_selector.dart';
import 'package:flutter/material.dart';

// https://dribbble.com/shots/4445853-BMI-Calculator-app
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
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BmiContentCard(
                    title: 'Gender',
                    child: GenderSelector(),
                  ),
                  BmiContentCard(
                    title: 'Weight',
                    unit: 'kg',
                    child: WeightSelector(),
                  ),
                ],
              ),
            ),
            const BmiContentCard(
              title: 'Height',
              unit: 'cm',
              child: Text('contentbody'),
            ),
          ],
        ));
  }
}
