import 'package:flutter/material.dart';

class Villain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(4.0),
      child: Image.asset(
          'images/ghost2.png'
      ),
        );
  }
}