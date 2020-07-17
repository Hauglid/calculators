import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<Widget>(
      builder: (_) => Calculator(),
    );
  }

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String expression = '';
  String input = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Calculator'),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: const [Colors.blue, Color(0xFF6E6DD5)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(expression),
                      Text(
                        input,
                        style: Theme.of(context).textTheme.headline3,
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildRow([
                      _buildACButton(),
                      _buildInvertButton(),
                      _buildButton(value: '%'),
                      _buildButton(value: '/'),
                    ]),
                    _buildRow([
                      _buildButton(value: '7'),
                      _buildButton(value: '8'),
                      _buildButton(value: '9'),
                      _buildButton(value: '*'),
                    ]),
                    _buildRow([
                      _buildButton(value: '4'),
                      _buildButton(value: '5'),
                      _buildButton(value: '6'),
                      _buildButton(value: '-'),
                    ]),
                    _buildRow([
                      _buildButton(value: '1'),
                      _buildButton(value: '2'),
                      _buildButton(value: '4'),
                      _buildButton(value: '+'),
                    ]),
                    _buildRow([
                      _buildButton(value: '0', flex: 2),
                      _buildButton(value: '.'),
                      _buildEqualsButton(),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildButton({String value, int flex = 1}) {
    return Expanded(
      flex: flex,
      child: OutlineButton(
        onPressed: () {
          setState(() {
            if (value.contains(RegExp(r'[1-9]'))) {
              input = value;
            }
            expression = expression + value;
          });
        },
        child: _buildButtonText(value),
      ),
    );
  }

  Widget _buildInvertButton() {
    return Expanded(
      child: OutlineButton(
        onPressed: () {
          final Expression exp = Parser().parse(input + '*-1');
          final double eval = exp.evaluate(EvaluationType.REAL, ContextModel());
          setState(() {
            input = eval.toString();
          });
        },
        child: _buildButtonText('+/-'),
      ),
    );
  }

  Widget _buildACButton() {
    return Expanded(
      child: OutlineButton(
        onPressed: () {
          setState(() {
            expression = '';
            input = '';
          });
        },
        child: _buildButtonText('AC'),
      ),
    );
  }

  Text _buildButtonText(String textButton) => Text(
        textButton,
        style: Theme.of(context).textTheme.headline6,
      );

  Widget _buildEqualsButton() {
    return Expanded(
      child: OutlineButton(
        onPressed: () {
          final Expression exp = Parser().parse(expression);
          final double eval = exp.evaluate(EvaluationType.REAL, ContextModel());
          setState(() {
            expression = '';
            input = eval.toString();
          });
        },
        child: _buildButtonText('='),
      ),
    );
  }

  Widget _buildRow(List<Widget> buttons) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons,
      ),
    );
  }
}
