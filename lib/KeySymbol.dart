enum KeyType { FUNCTION, OPERATOR, INTEGER }

class KeySymbol {
  const KeySymbol(this.value);

  final String value;

  static List<KeySymbol> _functions = [
    Keys.clear,
    Keys.sign,
    Keys.percent,
    Keys.decimal
  ];
  static List<KeySymbol> _operators = [
    Keys.divide,
    Keys.multiply,
    Keys.subtract,
    Keys.add,
    Keys.equals
  ];

  @override
  String toString() => value;

  bool get isFunction => _functions.contains(this);

  bool get isOperator => _operators.contains(this);

  bool get isInteger => !isOperator && !isFunction;

  KeyType get type => isFunction
      ? KeyType.FUNCTION
      : isOperator ? KeyType.OPERATOR : KeyType.INTEGER;
}

abstract class Keys {
  static KeySymbol clear = const KeySymbol('C');
  static KeySymbol sign = const KeySymbol('±');
  static KeySymbol percent = const KeySymbol('%');
  static KeySymbol divide = const KeySymbol('÷');
  static KeySymbol multiply = const KeySymbol('x');
  static KeySymbol subtract = const KeySymbol('-');
  static KeySymbol add = const KeySymbol('+');
  static KeySymbol equals = const KeySymbol('=');
  static KeySymbol decimal = const KeySymbol('.');

  static KeySymbol zero = const KeySymbol('0');
  static KeySymbol one = const KeySymbol('1');
  static KeySymbol two = const KeySymbol('2');
  static KeySymbol three = const KeySymbol('3');
  static KeySymbol four = const KeySymbol('4');
  static KeySymbol five = const KeySymbol('5');
  static KeySymbol six = const KeySymbol('6');
  static KeySymbol seven = const KeySymbol('7');
  static KeySymbol eight = const KeySymbol('8');
  static KeySymbol nine = const KeySymbol('9');
}
