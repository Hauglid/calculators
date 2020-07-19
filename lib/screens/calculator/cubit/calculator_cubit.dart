import 'package:cubit/cubit.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:meta/meta.dart';

part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit()
      : super(const CalculatorState(currentInput: '', sumExpression: ''));
  String sumExpression = '';
  String currentInput = '';
  bool _newNumber = false;

  void addNumber(String number) {
    if (_newNumber) {
      currentInput = number;
      _newNumber = false;
    } else {
      currentInput = currentInput + number;
    }
    sumExpression = sumExpression + number;
    _emitNewState();
  }

  void invertInput() {
    final Expression exp = Parser().parse(currentInput + '*-1');
    final double eval = exp.evaluate(EvaluationType.REAL, ContextModel());
    currentInput = eval.toString();
    _emitNewState();
  }

  void addDecimalDot() {
    if (currentInput == '') {
      currentInput = '0.';
      sumExpression = currentInput;
    } else if (!currentInput.contains('.')) {
      currentInput = currentInput + '.';
      sumExpression = sumExpression + '.';
    }
    _emitNewState();
  }

  void addArithmeticSign(String value) {
    sumExpression = sumExpression + value;
    currentInput = value;
    _newNumber = true;

    _emitNewState();
  }

  void calculatePercent() {
    final Expression exp = Parser().parse(currentInput + '/100');
    final double eval = exp.evaluate(EvaluationType.REAL, ContextModel());
    currentInput = eval.toString();
    _emitNewState();
  }

  void calculate() {
    final Expression exp = Parser().parse(sumExpression);
    final double eval = exp.evaluate(EvaluationType.REAL, ContextModel());
    // sumExpression = eval.toString();
    currentInput = eval.toString();

    _emitNewState();
  }

  void clean() {
    currentInput = '';
    sumExpression = '';
    _emitNewState();
  }

  void _emitNewState() {
    emit(CalculatorState(
        sumExpression: sumExpression, currentInput: currentInput));
  }
}
