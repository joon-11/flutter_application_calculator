import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '간단한 계산기',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String statement = "";
  String result = "0";
  final List<String> buttons = [
    'C',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'AC',
    '0',
    '.',
    '='
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Flexible(flex: 2, child: _resultView()),
            Expanded(flex: 4, child: _buttons()),
          ],
        ),
      ),
    );
  }

  Widget _resultView() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              statement,
              style: const TextStyle(fontSize: 32),
            )),
        Container(
            padding: const EdgeInsets.all(15),
            alignment: Alignment.centerRight,
            child: Text(
              result,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  Widget _buttons() {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (BuildContext context, int index) {
        return _myButton(buttons[index]);
      },
      itemCount: buttons.length,
    );
  }

  Widget _myButton(String text) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: MaterialButton(
        onPressed: () {
          setState(() {
            clickButton(text);
          });
        },
        color: _getColor(text),
        textColor: Colors.white,
        shape: const CircleBorder(),
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  _getColor(String text) {
    if (text == "=" ||
        text == "/" ||
        text == "*" ||
        text == '-' ||
        text == '+') {
      return Colors.orangeAccent;
    }
    if (text == 'C' || text == 'AC') {
      return Colors.redAccent;
    }
    if (text == '(' || text == ')') {
      return Colors.blueGrey;
    }

    return Colors.blueAccent;
  }

  clickButton(String text) {
    if (text == 'AC') {
      statement = '';
      result = '';
      return;
    }
    if (text == 'C') {
      statement = statement.substring(0, statement.length - 1);
      return;
    }
    if (text == '=') {
      result = calculate();
      return;
    }
    statement = statement + text;
  }

  calculate() {
    try {
      var exp = Parser().parse(statement);
      var ans = exp.evaluate(EvaluationType.REAL, ContextModel());
      return ans.toString();
    } catch (e) {
      return 'ERROR';
    }
  }
}
