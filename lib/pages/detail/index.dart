import 'package:flutter/material.dart';
import 'package:dekiru/constants/app.dart';
import 'package:dekiru/models/habit.dart';
import 'package:dekiru/pages/detail/components/chart/monthly_chart.dart';
import 'package:dekiru/pages/detail/modal/delete.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import '_header.dart';
import 'components/calendar/calendar.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    Habit habit = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          child: Screenshot(
            controller: _screenshotController,
            child: ListView(
              padding: EdgeInsets.all(30),
              children: <Widget>[
                _header(context, habit),
                SizedBox(height: 20),
                if (habit.time != null) _alarm(habit),
                SizedBox(height: 15),
                _calendar(context, habit),
                _shareButton(context, habit),
                SizedBox(height: 15),
                _chart(context, habit),
                _deleteButton(context, habit)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context, Habit habit) {
    return Header(habit, onChange: (name) {
      Provider.of<HabitModel>(context, listen: false).update(habit);
    });
  }

  Widget _alarm(Habit habit) {
    List<String> dayString =
        habit.daylist.map((e) => dayShortName[e - 1]).toList();

    return Row(
      children: [
        Icon(
          Icons.alarm,
          size: 14,
        ),
        SizedBox(width: 5),
        Text(
          MaterialLocalizations.of(context)
              .formatTimeOfDay(habit.time, alwaysUse24HourFormat: false),
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(width: 5),
        Icon(
          Icons.replay,
          size: 14,
        ),
        SizedBox(width: 5),
        Text(
          dayString.length == 7 ? 'Ogni giorno' : dayString.join(', '),
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _calendar(BuildContext context, Habit habit) {
    return Calendar(
      habit: habit,
      onToggleDate: (date) {
        Feedback.forTap(context);
        setState(() {
          Provider.of<HabitModel>(context, listen: false)
              .toggleDate(habit, date);
        });
      },
    );
  }

  Widget _chart(BuildContext context, Habit habit) {
    return Container(
      child: MonthlyChart(habit),
      height: 350,
    );
  }

  void _takeScreenshot() async {
    final imageFile = await _screenshotController.capture();
    Share.shareFiles([imageFile.path],
        text:
            "Ecco i giorni in cui sono riuscito a rispettare la mia nuova abitudine!");
  }

  Widget _deleteButton(BuildContext context, Habit habit) {
    return FlatButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.red,
      onPressed: () {
        modalDeleteHabit(context, habit.name).then((value) {
          if (value) {
            Navigator.pop(context);
            setState(() {
              Provider.of<HabitModel>(context, listen: false).remove(habit);
            });
          }
        });
      },
      padding: EdgeInsets.all(10),
      icon: Icon(
        Icons.delete,
        color: Colors.white,
      ),
      label: Text(
        'Elimina',
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }

  Widget _shareButton(BuildContext context, Habit habit) {
    return FlatButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.green,
      onPressed: _takeScreenshot,
      padding: EdgeInsets.all(10),
      icon: Icon(
        Icons.share,
        color: Colors.white,
      ),
      label: Text(
        'Condividi i tuoi risultati!',
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }
}
