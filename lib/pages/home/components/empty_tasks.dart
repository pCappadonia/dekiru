import 'package:flutter/material.dart';

class EmptyTask extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Non hai aggiunto nessuna abitudine, inizia adesso!',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Image.asset('assets/images/waiting.gif', scale: 1.5),
      ],
    );
  }
}
