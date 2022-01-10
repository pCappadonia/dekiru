import 'package:flutter/material.dart';
import 'package:dekiru/pages/detail/index.dart';
import 'package:dekiru/pages/get_started/index.dart';
import 'package:dekiru/pages/home/index.dart';
import 'package:dekiru/pages/steps/index.dart';
import 'package:dekiru/pages/pomodoro/index.dart';

class Routes {
  Routes._();

  //static variables
  static const String getStarted = '/getStarted';
  static const String home = '/home';
  static const String detail = '/detail';
  static const String steps = '/steps';
  static const String pomodoro = '/pomodoro';

  static final routes = <String, WidgetBuilder>{
    getStarted: (BuildContext context) => GetStarted(),
    home: (BuildContext context) => Home(),
    detail: (BuildContext context) => Detail(),
    steps: (BuildContext context) => Steps(),
    pomodoro: (BuildContext context) => Pomodoro(),
  };
}
