import 'package:flutter/material.dart';

class CalcListScreen extends StatelessWidget {
  const CalcListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculators'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Calculators List Screen'),
      ),
    );
  }
}
