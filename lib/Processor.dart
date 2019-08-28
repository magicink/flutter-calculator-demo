import 'dart:async';
import 'dart:developer';
import 'package:hot_lava/CalculatorKey.dart';
import 'package:hot_lava/KeyController.dart';
import 'package:hot_lava/KeySymbol.dart';

abstract class Processor {
  static KeySymbol _operator;
  static String _a = '0';
  static String _b = '0';
  static String _result;

  static StreamController _controller = StreamController();

  static Stream get _stream => _controller.stream;

  static StreamSubscription listen(Function handler) => _stream.listen(handler);

  static String get _equation {
    return _a
      + (_operator != null ? ' ${_operator.value}' : '')
      + (_b != '0' ? ' $_b' : '');
  }

  static String get _output => _result == null ? _equation : _result;

  static void _fire(String data) => _controller.add(_output);

  static void refresh() => _fire(_output);

  static void dispose() => _controller.close();

  static process(dynamic event) {
    CalculatorKey key = (event as KeyEvent).key;
    switch (key.symbol.type) {
      case KeyType.FUNCTION:
        handleFunction(key);
        break;
      case KeyType.OPERATOR:
        handleOperator(key);
        break;
      case KeyType.INTEGER:
        handleInteger(key);
        break;
    }
  }

  static String calcPercent(String x) => (double.parse(x) / 100).toString();

  static void _calculate() {
    if (_operator == null || _b == '0') { return; }

    Map<KeySymbol, dynamic> table = {
      Keys.divide: (a, b) => (a / b),
      Keys.multiply: (a, b) => (a * b),
      Keys.subtract: (a, b) => (a - b),
      Keys.add: (a, b) => (a + b)
    };

    double result = table[_operator](double.parse(_a), double.parse(_b));
    String str = result.toString();

    while ((str.contains('.') && str.endsWith('0')) || str.endsWith('.')) {
      str = str.substring(0, str.length - 1);
    }

    _result = str;
    refresh();
  }

  static void _decimal() {
    if (_b != '0' && !_b.contains('.')) { _b = '$_b.'; }
    else if (_a != '0' && !_a.contains('.')) { _a = '$_a.'; }
  }

  static void _percent() {
    if (_b != '0' && !_b.contains('.')) { _b = calcPercent(_b); }
    else if (_a != '0' && !_a.contains('.')) { _a = calcPercent(_a); }
  }

  static void _sign() {
    if (_b != '0') { _b = (_b.contains('-') ? _b.substring(1) : '-$_b'); }
    else if (_a != '0') { _a = (_a.contains('-') ? _a.substring(1) : '-$_a'); }
  }

  static void _clear() {
    _a = _b = '0';
    _operator = _result = null;
  }

  static void _condense() {
    _a = _result;
    _b = '0';
    _result = _operator = null;
  }

  static void handleFunction(CalculatorKey key) {
    if (_a == '0') return;
    if (_result != null) _condense();
    Map<KeySymbol, dynamic> table = {
      Keys.clear: () => _clear(),
      Keys.sign: () => _sign(),
      Keys.percent: () => _percent(),
      Keys.decimal: () => _decimal()
    };
    table[key.symbol]();
    refresh();
  }

  static void handleOperator(CalculatorKey key) {
    if (_a == '0') { return; }
    if (key.symbol == Keys.equals) { return _calculate(); }
    if (_result != null) { _condense(); }

    _operator = key.symbol;
    refresh();
  }

  static void handleInteger(CalculatorKey key) {
    String val = key.symbol.value;
    if (_operator == null) { _a = (_a == '0') ? val : _a + val; }
    else { _b = (_b == '0') ? val : _b + val; }
    refresh();
  }
}
