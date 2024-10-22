import 'package:flutter/material.dart';

import 'calculator_screen.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";

  // Button building function with red text color
  Widget _buildButton(String text, Color buttonColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              // Logic for button press will be implemented later.
              output += text;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            padding: EdgeInsets.all(20.0),
          ),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white), // Red text color
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // Display area
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Text(
              output,
              style: TextStyle(color: Colors.white, fontSize: 48),
            ),
          ),
          Divider(color: Colors.white),
          // Button area
          Column(
            children: [
              Row(
                children: [
                  _buildButton("7", Colors.grey[800]!),
                  _buildButton("8", Colors.grey[800]!),
                  _buildButton("9", Colors.grey[800]!),
                  _buildButton("/", Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton("4", Colors.grey[800]!),
                  _buildButton("5", Colors.grey[800]!),
                  _buildButton("6", Colors.grey[800]!),
                  _buildButton("*", Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton("1", Colors.grey[800]!),
                  _buildButton("2", Colors.grey[800]!),
                  _buildButton("3", Colors.grey[800]!),
                  _buildButton("-", Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton("0", Colors.grey[800]!),
                  _buildButton(".", Colors.grey[800]!),
                  _buildButton("=", Colors.orange),
                  _buildButton("+", Colors.orange),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
