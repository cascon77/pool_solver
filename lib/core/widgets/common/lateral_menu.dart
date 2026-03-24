import 'package:flutter/material.dart';

class LateralMenu extends StatelessWidget {
  const LateralMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/jettPortada.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(

            ),
          ),

        ]
      ),
    );
  }
}
