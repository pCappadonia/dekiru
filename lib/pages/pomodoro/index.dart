import 'dart:async';
import 'package:flutter/material.dart';

int initialMinutes = 24;
int initialSeconds = 60;
String time = '25:00';
var duration = const Duration(seconds: 1);
var watch = Stopwatch();

class Pomodoro extends StatefulWidget {
  @override
  PomodoroState createState() => PomodoroState();
}

class PomodoroState extends State<Pomodoro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Timer Pomodoro'),
      ),
      body: _buildPomodoroTimer(),
    );
  }

  void _startStopwatch() {
    if (_isPlaying()) {
      watch.stop();
    } else {
      watch.start();
      _startTimer();
    }
  }

  void _restart() {
    watch.stop();
    watch.reset();
    setState(() {
      time = '25:00';
    });
  }

  bool _isPlaying() {
    return watch.isRunning;
  }

  Widget _buildPomodoroTimer() {
    return Center(
        child: Column(
      children: <Widget>[
        stopwatch(),
        Expanded(
          flex: 1,
          child: Icon(
            Icons.alarm,
            size: 200.00,
          ),
        ),
        Row(children: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _restart,
            iconSize: 60,
          ),
          IconButton(
            icon: _isPlaying() ? Icon(Icons.pause) : Icon(Icons.play_arrow),
            onPressed: _startStopwatch,
            iconSize: 60,
          )
        ], mainAxisAlignment: MainAxisAlignment.center),
      ],
    ));
  }

  void _startTimer() {
    Timer(duration, _keepRunning);
  }

  void _keepRunning() {
    if (watch.isRunning) {
      _startTimer();
    }

    setState(() {
      int currentMinute = int.parse(watch.elapsed.inMinutes.toString());
      int currentSeconds = int.parse((watch.elapsed.inSeconds % 60).toString());
      int timerMinutes = initialMinutes - currentMinute;
      int timerSeconds = initialSeconds - currentSeconds;

      if (timerSeconds < 60 && timerSeconds >= 0) {
        time = timerMinutes.toString().padLeft(2, '0') +
            ':' +
            timerSeconds.toString().padLeft(2, '0');

        if (time == '00:00') {}
      }
      if (timerMinutes < 0) {
        time = '00:00';
        watch.stop();
      }
    });
  }

  Widget stopwatch() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      child: Text(
        time,
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}
