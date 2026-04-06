import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pool_solution/domain/entities/pool_entity.dart';
import 'package:pool_solution/routes/routes.dart';

class CalcListScreen extends StatelessWidget {
  final PoolEntity pool;
  const CalcListScreen({super.key, required this.pool});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculators'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ElevatedButton(onPressed: (){
            context.pushNamed(Routes.calcPh, extra: pool);
          }, child: Text("ph"))
        ],
      ),
    );
  }
}
