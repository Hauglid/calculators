import 'package:calculators/screens/calculator/cubit/calculator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

class Calculator extends StatelessWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<Widget>(
      builder: (_) => Calculator(),
    );
  }

  final _cubit = CalculatorCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Calculator'),
        ),
        body: Container(
          decoration: _getBoxDecoration(),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CubitBuilder(
                      cubit: _cubit,
                      builder: (context, state) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(state.sumExpression),
                            Text(
                              state.currentInput,
                              style: Theme.of(context).textTheme.headline3,
                              textAlign: TextAlign.right,
                            ),
                          ],
                        );
                      },
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
          ),
        ));
  }

  BoxDecoration _getBoxDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.blue, Color(0xFF6E6DD5)],
      ),
    );
  }

  Widget _buildArithmicButton({String value}) {
    return _buildButton(buttonText: value, onPressed: () => _cubit.addArithmeticSign(value));
  }

  Widget _buildDotButton() {
    return _buildButton(buttonText: '.', onPressed: _cubit.addDecimalDot);
  }

  Widget _buildNumberButton({String value, int flex = 1}) {
    return _buildButton(buttonText: value, onPressed: () => _cubit.addNumber(value), flex: flex);
  }

  Widget _buildInvertButton() {
    return _buildButton(buttonText: '+/-', onPressed: _cubit.invertInput);
  }

  Widget _buildPercentButton() {
    return _buildButton(buttonText: '%', onPressed: _cubit.calculatePercent);
  }

  Widget _buildACButton() {
    return _buildButton(buttonText: 'AC', onPressed: _cubit.clean);
  }

  Widget _buildEqualsButton() {
    return _buildButton(buttonText: '=', onPressed: _cubit.calculate);
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
          decoration: ShapeDecoration(
            color: Colors.grey.shade700.withOpacity(0.3),
            shape: StadiumBorder(
              side: BorderSide(
                color: Colors.grey.shade700,
              ),
            ),
          ),
          child: TextButton(
            onPressed: onPressed,
            child: Text(
              buttonText,
              style: const TextStyle(color: Colors.black, fontSize: 16),
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
