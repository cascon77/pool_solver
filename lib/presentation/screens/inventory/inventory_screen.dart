import 'package:flutter/material.dart';
import 'package:pool_solution/domain/entities/pool_entity.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key, required PoolEntity pool});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Inventory Screen'),
      ),
    );
  }
}
