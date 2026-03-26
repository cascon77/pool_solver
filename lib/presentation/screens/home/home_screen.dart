import 'package:flutter/material.dart';
import 'package:pool_solution/core/widgets/common/common.dart';
import 'package:pool_solution/l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      drawer: LateralMenu(),
      appBar: AppBar(title: Center(child: Text(l10n.appTitle))),
      body: Center(child: Text(l10n.homeProblems)),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
