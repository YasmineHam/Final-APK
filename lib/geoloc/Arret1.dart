import 'package:flutter/material.dart';
import '../geoloc/PlacePick2Main.dart';
import '../ui/size_screen.dart';
import '../ui/date_time_picker_widget.dart';

import '../PagePrincipale.dart';
import '../noyau/Personne.dart';
import '../ui/Palette.dart';
import '../ui/customWidgets/MyButton.dart';

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder/geocoder.dart';
import 'MapScreenDestArret.dart';
import 'PlacePick2.dart';
import 'localisation.dart';

class Arret extends StatefulWidget {
  Personne personne;
  static var dest;

  Arret(this.personne);

  @override
  _ArretState createState() => _ArretState();
}

class _ArretState extends State<Arret> {
  String arrets;

  Future<bool> addDialogAttention(BuildContext context, String msg) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Text(msg),
            title: Row(
              children: const <Widget>[
                Text('ATTENTION'),
                Icon(
                  Icons.question_answer,
                  color: Colors.green,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('OK'),
                  textColor: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          displayHeight(context) * 0.082,
        ),
        child: AppBar(
          centerTitle: true,
          title: Text(
            "Planifier un arrêt",
            style: TextStyle(
              fontFamily: 'Gilroy',
              color: Palette.violet,
              fontSize: 30,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
            ),
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            alignment: Alignment.topLeft,
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 25,
            ),
            color: Palette.violet,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PagePrincipale(widget.personne)),
              );
              //print("retour");
            },
          ),
          titleSpacing: 0,
          elevation: 0.0,
          // This removes the shadow from all App Bars.
          backgroundColor: Palette.background,
        ),
      ),
      backgroundColor: Palette.background,
      body: Column(
        textDirection: TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.start,
        //mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Text(
            "Position d'arrêt:",
            style: TextStyle(
              fontFamily: 'Gilroy',
              color: Palette.sousTitre,
              fontSize: 20,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: new EdgeInsets.symmetric(horizontal: 20.0),
            width: displayWidth(context) * 0.82,
            //* height: 50,
            decoration: BoxDecoration(
              color: Color(0xffe0e5ec),
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  offset: Offset(-6, -2),
                  blurRadius: 6.2,
                  spreadRadius: 3,
                ),
                BoxShadow(
                  color: Color.fromRGBO(250, 250, 250, 0.9),
                  offset: Offset(6, 2),
                  blurRadius: 6.2,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: FlatButton(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: Palette.sousTitre,
                  ),
                  Text(
                    (Arret.dest != null)
                        ? PlacePick2.pickResult.name
                        : "Selectionner l'adresse",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        fontFamily: 'Gilroy-ExtraBold.ttf',
                        color: Palette.sousTitre,
                        decoration: null,
                        letterSpacing: 1),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              onPressed: () {
                PlacePick2.option = 3;
                //indiquer a la classe que c'est un arret
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>PlacePick2Main(widget.personne)),
                );

                //print("helllllooooooooo");
              },
            ),
          ),
          /* TextFormField(
            decoration: InputDecoration(hintText: 'Entrer l''adresse'),
            keyboardType: TextInputType.text,
            onChanged: (String val) {
              arrets = val;
            },
          ),*/
          SizedBox(
            height: 40,
          ),
//          Text("Heure d'arrêt:",
//            style: TextStyle(
//              fontFamily: 'Gilroy',
//              color: Palette.sousTitre,
//              fontSize: 20,
//              fontWeight: FontWeight.w300,
//              fontStyle: FontStyle.normal,
//            ),
//            textAlign: TextAlign.left,
//          ),

          // DateTimePickerWidget2(),
          /*MyTextField(icon: Icon(Icons.location_on,)
            ,inputType: TextInputType.text,
            hauteur: 50,largeur: 400,focusMe: false,
            textsize: 20,
            defaultText: "Position",

          ),*/

          Center(
            child: MyButton(
              hauteur:displayHeight(context)*0.09 ,
              longeur: displayWidth(context)* 0.52,
              onPressed: () async {
                arrets = PlacePick2.pickResult.formattedAddress;

                final query = arrets;
                var addresses =
                    await Geocoder.local.findAddressesFromQuery(query);
                var first = addresses.first;
                var place = GeoPoint(
                    first.coordinates.latitude, first.coordinates.longitude);
                if(widget.personne.groupeActif != null){
                        Firestore.instance.collection("groups").document(widget.personne.groupeActif.id).collection('arrets').document(arrets).setData({
                      //'coords': GeoPoint(document['place'].latitude, document['place'].longitude),
                      'coords': GeoPoint(place.latitude, place.longitude),
                      'place': arrets,
                    });
                    } else {
                       Firestore.instance.collection("users").document(widget.personne.compte.email).collection('arrets').document(arrets).setData({
                       'coords': GeoPoint(place.latitude, place.longitude),
                       'place': arrets,
                     });
                    }
      


                 Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => PagePrincipale(widget.personne),
                ));
              },
              text: "Confirmer",
            ),
          ),
          /* FlatButton(
           onPressed: () {
            DatePicker.showDatePicker(context,
              showTitleActions: true,
               minTime: DateTime.now(),
             maxTime: DateTime(2030, 6, 7), onChanged: (date) {
             print('change $date');
             }, onConfirm: (date) {
              print('confirm $date');
               }, currentTime: DateTime.now(), locale: LocaleType.fr);
               },
               child: Text(
              'show date time picker ',
               style: TextStyle(color: Colors.blue),
               )
               ),*/
        ],
      ),
    );
  }
}
