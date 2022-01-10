import 'package:flutter/material.dart';

Future<bool> modalDeleteHabit(BuildContext context, String name) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // l'utente deve premere il bottone
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Cancella'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Sei sicuro di voler cancellare $name?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Annulla'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: Text(
              'Cancella',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}
