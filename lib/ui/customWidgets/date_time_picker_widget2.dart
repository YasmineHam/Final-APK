import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../groupes/CreerVoyage.dart';
import '../../noyau/Groupe.dart';
import 'package:intl/intl.dart';
import '../Palette.dart';
import 'notifcation_dialog.dart';


class DateTimePickerWidget2 extends StatefulWidget {
  Groupe g;
  DateTimePickerWidget2( this.g);
  @override
  _DateTimePickerWidget2State createState() => _DateTimePickerWidget2State();
}

class _DateTimePickerWidget2State extends State<DateTimePickerWidget2> {
  DateTime selectedDate = DateTime.now();

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  @override
  Widget build(BuildContext context) {
    CreerVoyage.heure = selectedDate.toString();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(dateFormat.format(selectedDate)),
        FlatButton(
          child: Text("Choisir la Date et L'heure de départ",style: TextStyle(
            color:  Palette.bleu,
            fontFamily: 'Gilroy',
            //color: Palette.sousTitre,
            fontSize: 20,
            fontWeight: FontWeight.w200,
            fontStyle: FontStyle.normal,

          ),),
          onPressed: () async {
            showDateTimeDialog(context, initialDate: selectedDate,
                onSelectedDate: (selectedDate) {
                  setState(() {
                    print('heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeey');
                    String heure = selectedDate.toString();
                    CreerVoyage.heure = heure;
                    print(CreerVoyage.heure);
                  });
                });
          },
        ),
      ],
    );
  }
}