import 'package:flutter/material.dart';
import 'package:dekiru/constants/app.dart';
import 'date.dart';

const TextStyle title = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w700,
);

class HabitItem extends StatefulWidget {
  HabitItem({
    this.key,
    this.id,
    this.name,
    this.time,
    this.dayList,
    this.data,
    this.toggleDate,
    this.onTap,
  });

  final Key key;
  final int id;
  final String name;
  final TimeOfDay time;
  final List<int> dayList;
  final List data;
  final Function(DateTime) toggleDate;
  final Function onTap;

  _HabitItemState createState() => _HabitItemState();
}

class _HabitItemState extends State<HabitItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Wrap(children: [
        Container(
          padding: EdgeInsets.all(18),
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Color(0xff559DFF),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              _checklist(),
            ],
          ),
        )
      ]),
    );
  }

  Widget _header() {
    String day;
    if (widget.time != null) {
      List<String> dayString =
          widget.dayList.map((e) => dayShortName[e - 1]).toList();
      day = dayString.length == 7 ? 'Ogni giorno' : dayString.join(', ');
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.time != null)
            Row(
              children: [
                Icon(
                  Icons.alarm,
                  size: 15,
                ),
                SizedBox(width: 5),
                Text(
                  widget.time.format(context),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.replay,
                  size: 15,
                ),
                SizedBox(width: 5),
                Text(
                  day,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          if (widget.time != null) SizedBox(height: 10),
          Text(
            widget.name,
            style: title,
          )
        ],
      ),
    );
  }

  Widget _checklist() {
    final List<HabitDate> dateList = [];
    final DateTime currentDate = new DateTime.now();

    for (var i = 5; i >= 0; i--) {
      DateTime date = currentDate.subtract(Duration(days: i));
      String dateString = date.toString().substring(0, 10);
      dateList.add(
        HabitDate(
          date: date,
          isChecked: widget.data?.indexOf(dateString) != -1,
          onChange: () => widget.toggleDate(date),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: dateList,
    );
  }
}
