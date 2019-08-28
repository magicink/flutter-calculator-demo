import 'package:flutter/material.dart';
import 'package:hot_lava/KeyController.dart';
import 'package:hot_lava/KeySymbol.dart';

class CalculatorKey extends StatelessWidget {
  CalculatorKey({this.symbol});

  final KeySymbol symbol;

  Color get color {
    switch (symbol.type) {
      case KeyType.FUNCTION:
        return Color.fromARGB(255, 96, 96, 96);
      case KeyType.OPERATOR:
        return Color.fromARGB(255, 32, 96, 128);
      case KeyType.INTEGER:
      default:
        return Color.fromARGB(255, 128, 128, 128);
    }
  }

  static dynamic _fire(CalculatorKey key) => KeyController.fire(KeyEvent(key));

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / 4;
    TextStyle style =
        Theme.of(context).textTheme.display1.copyWith(color: Colors.white);

    return Container(
      width: (symbol == Keys.zero) ? size * 2 : size,
      padding: EdgeInsets.all(2),
      height: size,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: color,
        child: Text(symbol.value, style: style),
        onPressed: () => _fire(this),
      ),
    );
  }
}
