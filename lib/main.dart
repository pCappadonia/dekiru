import 'package:flutter/material.dart';
import 'package:dekiru/constants/app_theme.dart';
import 'package:dekiru/models/habit.dart';
import 'package:dekiru/pages/home/index.dart';
import 'package:dekiru/routes.dart';
import 'package:dekiru/pages/get_started/index.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  runApp(
    ChangeNotifierProvider(
      create: (context) => habitAdapter,
      child: DekiruApp(),
    ),
  );
}

class DekiruApp extends StatefulWidget {
  @override
  _DekiruAppState createState() => _DekiruAppState();
}

class _DekiruAppState extends State<DekiruApp> {
  Widget _body;

  @override
  void initState() {
    super.initState();
    _loadStarted();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DEKIRU: Ce la puoi fare',
      routes: Routes.routes,
      theme: themeData,
      home: Scaffold(
        backgroundColor: Colors.orange,
        body: _body,
      ),
    );
  }

  void _loadStarted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isStarted = prefs.getBool('isStarted') == null;
    setState(() {
      _body = isStarted ? GetStarted() : Home();
    });
  }
}
