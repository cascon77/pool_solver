import 'package:flutter/material.dart';

class ProblemCategoryListScreen extends StatelessWidget {
  const ProblemCategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Problem Categories'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Problem Category List Screen'),
      ),
    );
  }
}
