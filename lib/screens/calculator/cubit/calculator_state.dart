part of 'calculator_cubit.dart';

@immutable
class CalculatorState {
  const CalculatorState({this.sumExpression, this.currentInput});

  final String sumExpression;
  final String currentInput;
}
