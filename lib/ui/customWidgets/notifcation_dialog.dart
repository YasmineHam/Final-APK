import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Palette.dart';
import '../customWidgets/MyButton.dart';

Future<TimeOfDay> _selectTime(BuildContext context,
    {@required DateTime initialDate}) {
  final now = DateTime.now();

  return showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: initialDate.hour, minute: initialDate.minute),
  );
}

Future<DateTime> _selectDateTime(BuildContext context,
    {@required DateTime initialDate}) {
  final now = DateTime.now();
  final newestDate = initialDate.isAfter(now) ? initialDate : now;

  return showDatePicker(
    context: context,
    initialDate: newestDate.add(Duration(seconds: 1)),
    firstDate: now,
    lastDate: DateTime(2100),
  );
}

Dialog showDateTimeDialog(
  BuildContext context, {
  @required ValueChanged<DateTime> onSelectedDate,
  @required DateTime initialDate,
}) {
  final dialog = Dialog(
    child: DateTimeDialog(
        onSelectedDate: onSelectedDate, initialDate: initialDate),
  );

  showDialog(context: context, builder: (BuildContext context) => dialog);
}

class DateTimeDialog extends StatefulWidget {
  final ValueChanged<DateTime> onSelectedDate;
  final DateTime initialDate;

  const DateTimeDialog({
    @required this.onSelectedDate,
    @required this.initialDate,
    Key key,
  }) : super(key: key);
  @override
  _DateTimeDialogState createState() => _DateTimeDialogState();
}

class _DateTimeDialogState extends State<DateTimeDialog> {
  DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Time',
               style: TextStyle(
                 fontFamily: 'Gilroy', color: Palette.sousTitre, fontSize: 25, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,
        )
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  padding: EdgeInsets.all(0.5),
                  child: Container(
                    child: Center(
                        child: new Text(DateFormat('yyyy-MM-dd').format(selectedDate),
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              color: Color(0xff5813ea),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            ))),
                    width: 100,
                    height: 50,
                    decoration: new BoxDecoration(
                      color: Color(0XFFE0E5EC).withOpacity(1),
                      borderRadius: BorderRadius.circular(47),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0XFFA6ABBD).withOpacity(1),
                            offset: Offset(10, 10),
                            blurRadius: 13,
                            spreadRadius: 0),
                        BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            offset: Offset(-10, -10),
                            blurRadius: 13,
                            spreadRadius: 0),
                      ],
                    ),
                  ),
                 // child : Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
                  onPressed: () async {
                    final date = await _selectDateTime(context,
                        initialDate: selectedDate);
                    if (date == null) return;

                    setState(() {
                      selectedDate = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        selectedDate.hour,
                        selectedDate.minute,
                      );
                    });

                    widget.onSelectedDate(selectedDate);
                  },
                ),
                const SizedBox(width: 8),
                FlatButton(
                  padding: EdgeInsets.all(0.5),
                  child: Container(
                    child: Center(
                        child: new Text(DateFormat('HH:mm').format(selectedDate),
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              color: Color(0xff5813ea),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            ))),
                    width: 100,
                    height: 50,
                    decoration: new BoxDecoration(
                      color: Color(0XFFE0E5EC).withOpacity(1),
                      borderRadius: BorderRadius.circular(47),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0XFFA6ABBD).withOpacity(1),
                            offset: Offset(10, 10),
                            blurRadius: 13,
                            spreadRadius: 0),
                        BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            offset: Offset(-10, -10),
                            blurRadius: 13,
                            spreadRadius: 0),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    final time =
                        await _selectTime(context, initialDate: selectedDate);
                    if (time == null) return;

                    setState(() {
                      selectedDate = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        time.hour,
                        time.minute,
                      );
                    });

                    widget.onSelectedDate(selectedDate);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            MyButton(
              hauteur: 50,
              longeur: 150,
              text: "Enregistrer",
              onPressed: ()
              {
                Navigator.of(context).pop();
              },
            ),
            /*OutlineButton(
              child: Text('Enregistrer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
              highlightColor: Colors.orange,
            ),*/
          ],
        ),
      );
}
