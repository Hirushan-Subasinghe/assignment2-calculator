//IM/2021/101 - Hirushan Subasinghe

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String display = '0';
  String expression = '';
  String previousExpression = '';
  List<String> history = [];
  bool resultDisplayed = false;

  final Set<String> _operators = {'/', '*', '+', '-', '.'};

  void _input(String value) {
    setState(() {
      if (value == 'C') {
        display = '0';
        expression = '';
        previousExpression = '';
      } else if (value == 'D') {
        if (expression.isNotEmpty) {
          expression = expression.substring(0, expression.length - 1);
          display = expression.isEmpty ? '0' : expression;
        }
      } else if (value == '=') {
        try {
          String finalExpression = expression.replaceAll('√', 'sqrt');
          if (finalExpression.contains('/0')) {
            display = "Can't divide by zero";
          } else {
            Parser parser = Parser();
            Expression exp = parser.parse(finalExpression);
            ContextModel contextModel = ContextModel();
            double result = exp.evaluate(EvaluationType.REAL, contextModel);

            previousExpression = expression;
            display = result.toString();
            history.add('$expression = $display');

            expression = display; // Update the expression to the result
            resultDisplayed = true;
          }
        } catch (e) {
          display = 'Error';
        }
      } else {
        if (resultDisplayed && !_operators.contains(value)) {
          // If result was displayed and next input is not an operator, reset the expression
          expression = value;
          resultDisplayed = false;
        } else if (resultDisplayed && _operators.contains(value)) {
          // If result was displayed and next input is an operator, append to the result
          resultDisplayed = false;
          expression += value;
        } else {
          if (value == '√') {
            expression += 'sqrt(';
          } else if (_operators.contains(value)) {
            if (expression.isEmpty && value == '-') {
              expression = value;
            } else if (_operators.contains(expression[expression.length - 1])) {
              return; // Avoid consecutive operators
            } else {
              expression += value;
            }
          } else if (value == ')') {
            // Ensure there's an open bracket before adding a close bracket
            if (expression.contains('(')) {
              expression += value;
            }
          } else {
            if (expression == '0' && value != '.') {
              expression = value; // Replace the initial 0
            } else {
              expression += value;
            }
          }
        }
        display = expression;
      }
    });
  }

  void _showHistory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('History'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: history.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(history[index]),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  history.clear(); // Clear the history and update UI
                });
                Navigator.of(context).pop();
              },
              child: Text(
                'Clear History',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildButton(String label, {Color color = Colors.black54}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ElevatedButton(
          onPressed: () => _input(label),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(12.0), // Adjust the radius here
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Text(
              label,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String label,
      {Color color = Colors.black54}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: AspectRatio(
          aspectRatio: 1.3,
          child: ElevatedButton(
            onPressed: () => _input(label),
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: Icon(
              icon,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: _showHistory,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true, // Ensures the most recent content is visible
                child: Text(
                  previousExpression,
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true, // Ensures the most recent content is visible
                child: Text(
                  display,
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12.0),
              color: Colors.grey.shade100,
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildButton('7'),
                      _buildButton('8'),
                      _buildButton('9'),
                      _buildButton('/', color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('4'),
                      _buildButton('5'),
                      _buildButton('6'),
                      _buildButton('*', color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('1'),
                      _buildButton('2'),
                      _buildButton('3'),
                      _buildButton('-', color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('0'),
                      _buildButton('('),
                      _buildButton(')'),
                      _buildButton('+', color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('.', color: Colors.orange),
                      _buildIconButton(Icons.backspace, 'D',
                          color: Colors.orange),
                      _buildButton('√', color: Colors.orange),
                      _buildButton('%', color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('C', color: Colors.red),
                      _buildButton('=', color: Colors.orange),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
