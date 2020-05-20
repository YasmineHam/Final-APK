
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import '../PagePrincipale.dart';
import '../geoloc/localisation.dart';
import '../geoloc/PlacePick2.dart';
import '../geoloc/PlacePick2Main.dart';
import '../ui/size_screen.dart';
import 'Ajout_contact.dart';
import '../ui/Palette.dart';
import '../ui/customWidgets/MyButton.dart';
import '../ui/customWidgets/MyTextField.dart';
import '../ui/customWidgets/date_time_picker_widget2.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../noyau/Personne.dart';
import '../noyau/Groupe.dart';
import 'Param_groupe.dart';

class CreerVoyage extends StatefulWidget {
  String position;
  static var dest;
  static var place;
  Personne p;
  String adresse;
  Groupe g;
  static String heure;


  CreerVoyage(this.p, this.g);

  @override
  _CreerVoyageState createState() => _CreerVoyageState();
}

class _CreerVoyageState extends State<CreerVoyage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(displayHeight(context) * 0.082),
        child: AppBar(
          titleSpacing: 0,
          elevation: 0.0,
          backgroundColor: Palette.background,
          centerTitle: true,

          title: Text(
            "Créer un voyage",
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 29,
              color: Palette.violet,
            ),
            textAlign: TextAlign.left,
          ),

          leading: IconButton(
            alignment: Alignment.topLeft,
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 30,
            ),
            color: Palette.violet,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PagePrincipale(widget.p))
                        //Param_groupe(widget.p,widget.g)),
              );
            },
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Center(
                child: Container(
                  margin: new EdgeInsets.symmetric(horizontal: 20.0),
                  width: displayWidth(context) * 0.82,
                  //height: displayHeight(context)*0.0,
                  //height : displayHeight(context)*0.09,
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
                  //password
                  child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Le titre ne doit pas etre vide";
                        } else {
                          //print("Mot de passe et $value");
                          widget.position = value;
                          //print("pass $password");

                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.local_offer),
                        border: InputBorder.none,
                        hintText: " Titre",
                      ),
                      style: new TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Color(0xff6d7587),
                          letterSpacing: 1.5)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox (
                    width: displayWidth(context) * 0.1,
                  ),
                  Text(
                    "Destination du voyage :",
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 20,
                      color: Palette.violet,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
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
                      Icon(Icons.location_on,color: Palette.sousTitre,),
                      //Text( (CreerVoyage.dest != null)? PlacePick2.pickResult.name :
                      Text( (CreerVoyage.dest != null)?  CreerVoyage.dest:
                        "Selectionner l'adresse" ,
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
                      PlacePick2.option = 1;
                      //indiquer a la classe que c'est un choix de destination et non pas favoris/arret
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>PlacePick2Main
                          (widget.p)),
                      );
                  },
                ),
              ),
             /* TextFormField(
                decoration: InputDecoration(hintText: 'Entrer l' 'adresse'),
                keyboardType: TextInputType.text,
                onChanged: (String val) {
                  widget.position = val;
                },
              ),*/
             /* RaisedButton(
                onPressed: () async {
                  addToDestinations();
                  Navigator.of(context).pop();
                },
                textColor: Colors.white,
                child: Text(
                  'Add it',
                  style: TextStyle(fontSize: 18),
                ),
                color: Colors.blue,
              ),*/
              /*Text(
                "  Heure du voyage:",
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 20,
                  color: Palette.sousTitre,
                ),
                textAlign: TextAlign.left,
              ),*/
              SizedBox(
                height: displayHeight(context)*0.03,
              ),
              DateTimePickerWidget2(widget.g),
              
              /*MyTextField(icon: Icon(Icons.location_on,)
                ,inputType: TextInputType.text,
                hauteur: 50,largeur: 400,focusMe: false,
                textsize: 20,
                defaultText: "Position",

              ),*/
              SizedBox(
                height: displayHeight(context)*0.02,
              ),
              Center(
                child: MyButton(
                  text : "Confirmer",
                  hauteur:displayHeight(context)*0.09 ,
                   longeur: displayWidth(context)* 0.52,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      addDialogAttention(context, 'Si vous avez déja planifié un voyage, ce dernier va être remplacé');
                      
                    }
                  }
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }


  //***************************add a marker to favoris on firestore***************************************//
  addToDestinations() async {
    final query = CreerVoyage.dest;
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    print('khraaaaaaaaaaaaaaa');
    if ( widget.g != null) {
      print(widget.g.id);
          print('khraaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
          print(CreerVoyage.dest);
          
       Firestore.instance
          .collection("groups")
          .document(widget.g.id)
          .collection('destinations')
          .document('Destination')
          .setData({
        'coords': GeoPoint(first.coordinates.latitude, first.coordinates.longitude),
        //GeoPoint(CreerVoyage.dest.latitude, CreerVoyage.dest.longitude),
        'place': CreerVoyage.dest,
      });
      Firestore.instance
          .collection("groups")
          .document(widget.g.id)
          .collection('historique')
          .document(CreerVoyage.dest)
          .setData({
        'coords': GeoPoint(first.coordinates.latitude, first.coordinates.longitude),
        'place': CreerVoyage.dest,
        'heure': CreerVoyage.heure,
      });
      MapPage.dest = GeoPoint(first.coordinates.latitude, first.coordinates.longitude);
    }
    else{
      /*final docs = await Firestore.instance
          .collection("groups")
          .document(widget.p.groupeActif.id)
          .collection('destinations')
          .getDocuments();*/
      await Firestore.instance
          .collection("users")
          .document(widget.p.compte.email)
          .collection('destinations')
          .document('Destination')
          .setData({
        'coords':
        GeoPoint(first.coordinates.latitude, first.coordinates.longitude),
        'place': CreerVoyage.dest,
      });
      MapPage.dest = GeoPoint(first.coordinates.latitude, first.coordinates.longitude);

    }
  }

  //****************************************************************************************
  Future<bool> addDialogAttention(BuildContext context, String msg) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content:
            Text(msg),
            title: Row(
              children: const<Widget>[
                Text('Attention'),
                Icon(
                  Icons.question_answer,
                  color: Colors.purple,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('Confirmer'),
                  textColor: Colors.blue,
                  onPressed: (){
                    print('khra');
                   addToDestinations();
                   
                   Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PagePrincipale(widget.p))
                      );
                  }
              ),
              FlatButton(
                  child: Text('Annuler'),
                  textColor: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pop();

                  }
              ),

            ],

          );
        });
  }

}


