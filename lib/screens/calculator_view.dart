import 'package:calculator/util/calculator.dart';
import 'package:flutter/material.dart';

class CalculatorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final calculator = Calculator();
  String output = "0";
  String operation = "";
  final resultStyle = TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold);
  final operationStyle = TextStyle(
      fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black26);

  buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      calculator.clear();
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "X") {
      calculator.num1 = double.parse(output);
      calculator.op = buttonText;
      calculator.clearResultBuffer();
    } else if (buttonText == ".") {
      if (calculator.resultBuffer.contains('.')) {
        print("Already conatains a decimal point");
        return;
      } else {
        calculator.addToResultBuffer('.');
      }
    } else if (buttonText == "=") {
      calculator.num2 = double.parse(output);
      calculator.calculate();
      operation = calculator.toString();
      calculator.clearOperation();
      calculator.clearResultBuffer();
    } else {
      calculator.addToResultBuffer(buttonText);
    }

    setState(() {
      if (calculator.resultBuffer.isEmpty) {
        output = fixDecimalOutput(calculator.result);
      } else {
        output = calculator.resultBuffer;
      }
    });
  }

  String fixDecimalOutput(double decimalNum) {
    if (decimalNum == decimalNum.floor()) {
      return decimalNum.floor().toString();
    } else {
      return decimalNum.toStringAsFixed(2);
    }
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlineButton(
        padding: EdgeInsets.all(24.0),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  Container buildTypingArea(String text, TextStyle textStyle) {
    return Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
        child: Text(text, style: textStyle));
  }

  Container buildResultArea() => Container();

  Column buildButtons() {
    return Column(children: [
      Row(children: [
        buildButton('7'),
        buildButton('8'),
        buildButton("9"),
        buildButton("/")
      ]),
      Row(children: [
        buildButton('4'),
        buildButton('5'),
        buildButton('6'),
        buildButton('X')
      ]),
      Row(children: [
        buildButton('1'),
        buildButton('2'),
        buildButton('3'),
        buildButton('-')
      ]),
      Row(children: [
        buildButton('.'),
        buildButton('0'),
        buildButton('00'),
        buildButton('+')
      ]),
      Row(children: [
        buildButton('CLEAR'),
        buildButton('='),
      ])
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Container(
            child: Column(
          children: [
            buildTypingArea(output, resultStyle),
            Expanded(
              child: Divider(),
            ),
            Visibility(
              visible: true,
              child: buildTypingArea(operation, operationStyle),
            ),
            buildButtons()
          ],
        )));
  }
}
