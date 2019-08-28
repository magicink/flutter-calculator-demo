import 'package:flutter/material.dart';
import 'package:hot_lava/Display.dart';
import 'package:hot_lava/KeyPad.dart';

class Calculator extends StatefulWidget {
  Calculator({Key key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double buttonSize = size.width / 4;
    double displayHeight = size.height - (buttonSize * 5) - buttonSize;

    return Scaffold(
      backgroundColor: Color.fromARGB(196, 32, 64, 96),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Display(
            value: _output,
            height: displayHeight,
          ),
          KeyPad()
        ],
      ),
    );
  }
}
