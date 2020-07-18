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
                      _buildNumberButton(value: '%'),
                      _buildNumberButton(value: '/'),
                    ]),
                    _buildRow([
                      _buildNumberButton(value: '7'),
                      _buildNumberButton(value: '8'),
                      _buildNumberButton(value: '9'),
                      _buildNumberButton(value: '*'),
                    ]),
                    _buildRow([
                      _buildNumberButton(value: '4'),
                      _buildNumberButton(value: '5'),
                      _buildNumberButton(value: '6'),
                      _buildNumberButton(value: '-'),
                    ]),
                    _buildRow([
                      _buildNumberButton(value: '1'),
                      _buildNumberButton(value: '2'),
                      _buildNumberButton(value: '4'),
                      _buildNumberButton(value: '+'),
                    ]),
                    _buildRow([
                      _buildNumberButton(value: '0', flex: 2),
                      _buildNumberButton(value: '.'),
                      _buildEqualsButton(),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildNumberButton({String value, int flex = 1}) {
    final Function onPressed = () {
      setState(() {
        if (value.contains(RegExp(r'[1-9]'))) {
          input = value;
        }
        expression = expression + value;
      });
    };
    return _buildButton(buttonText: value, onPressed: onPressed, flex: flex);
  }

  Widget _buildInvertButton() {
    final Function onPressed = () {
      final Expression exp = Parser().parse(input + '*-1');
      final double eval = exp.evaluate(EvaluationType.REAL, ContextModel());
      setState(() {
        input = eval.toString();
      });
    };

    return _buildButton(buttonText: '+/-', onPressed: onPressed);
  }

  Widget _buildACButton() {
    final Function onPressed = () {
      setState(() {
        expression = '';
        input = '';
      });
    };

    return _buildButton(buttonText: 'AC', onPressed: onPressed);
  }

  Widget _buildEqualsButton() {
    final Function onPressed = () {
      final Expression exp = Parser().parse(expression);
      final double eval = exp.evaluate(EvaluationType.REAL, ContextModel());
      setState(() {
        expression = '';
        input = eval.toString();
      });
    };

    return _buildButton(buttonText: '=', onPressed: onPressed);
  }

  Widget _buildButton({
    @required String buttonText,
    @required Function onPressed,
    int flex = 1,
  }) {
    return Expanded(
      flex: flex,
      child: OutlineButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: Theme.of(context).textTheme.headline6,
        ),
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
