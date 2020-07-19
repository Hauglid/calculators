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
  String sumExpression = '';
  String currentInput = '';

  bool newNumber = false;

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
                      Text(sumExpression),
                      Text(
                        currentInput,
                        style: Theme.of(context).textTheme.headline3,
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildRow([
                        _buildACButton(),
                        _buildInvertButton(),
                        _buildPercentButton(),
                        _buildNumberButton(value: '/'),
                      ]),
                      _buildRow([
                        _buildNumberButton(value: '7'),
                        _buildNumberButton(value: '8'),
                        _buildNumberButton(value: '9'),
                        _buildArithmicButton(value: '*'),
                      ]),
                      _buildRow([
                        _buildNumberButton(value: '4'),
                        _buildNumberButton(value: '5'),
                        _buildNumberButton(value: '6'),
                        _buildArithmicButton(value: '-'),
                      ]),
                      _buildRow([
                        _buildNumberButton(value: '1'),
                        _buildNumberButton(value: '2'),
                        _buildNumberButton(value: '3'),
                        _buildArithmicButton(value: '+'),
                      ]),
                      _buildRow([
                        _buildNumberButton(value: '0', flex: 2),
                        _buildDotButton(),
                        _buildEqualsButton(),
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildArithmicButton({String value}) {
    final Function onPressed = () {
      setState(() {
        if (!sumExpression
            .substring(sumExpression.length - 1)
            .contains(RegExp(r'[\+\-\*\/]'))) {
          sumExpression = sumExpression + value;
        }
      });
      newNumber = true;
    };
    return _buildButton(buttonText: value, onPressed: onPressed);
  }

  Widget _buildDotButton() {
    final Function onPressed = () {
      setState(() {
        if (currentInput == '') {
          currentInput = '0.';
          sumExpression = currentInput;
        } else if (!currentInput.contains('.')) {
          currentInput = currentInput + '.';
          sumExpression = sumExpression + '.';
        }
      });
    };
    return _buildButton(buttonText: '.', onPressed: onPressed);
  }

  Widget _buildNumberButton({String value, int flex = 1}) {
    final Function onPressed = () {
      setState(() {
        sumExpression = sumExpression + value;
        if (!newNumber) {
          currentInput = currentInput + value;
        } else {
          currentInput = value;
          newNumber = false;
        }
      });
    };
    return _buildButton(buttonText: value, onPressed: onPressed, flex: flex);
  }

  Widget _buildInvertButton() {
    final Function onPressed = () {
      final Expression exp = Parser().parse(currentInput + '*-1');
      final double eval = exp.evaluate(EvaluationType.REAL, ContextModel());
      setState(() {
        currentInput = eval.toString();
      });
    };

    return _buildButton(buttonText: '+/-', onPressed: onPressed);
  }

  Widget _buildPercentButton() {
    final Function onPressed = () {
      final Expression exp = Parser().parse(currentInput + '/100');
      final double eval = exp.evaluate(EvaluationType.REAL, ContextModel());
      setState(() {
        currentInput = eval.toString();
        sumExpression = eval.toString();
      });
    };

    return _buildButton(buttonText: '%', onPressed: onPressed);
  }

  Widget _buildACButton() {
    final Function onPressed = () {
      setState(() {
        sumExpression = '';
        currentInput = '';
      });
    };

    return _buildButton(buttonText: 'AC', onPressed: onPressed);
  }

  Widget _buildEqualsButton() {
    final Function onPressed = () {
      final Expression exp = Parser().parse(sumExpression);
      final double eval = exp.evaluate(EvaluationType.REAL, ContextModel());
      setState(() {
        sumExpression = eval.toString();
        currentInput = eval.toString();
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
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: double.infinity,
          clipBehavior: Clip.hardEdge,
          decoration: const ShapeDecoration(
            shape: StadiumBorder(
              side: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
          child: FlatButton(
            onPressed: onPressed,
            child: Text(
              buttonText,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
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
