import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            //output
            Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16),
              child: Text(
                "00000000000000000000",
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ), //TextStyle
                textAlign: TextAlign.end,
              ), //Text
            ), //container

            //buttons
          ],
        ),
      ),
    );
  }
}
