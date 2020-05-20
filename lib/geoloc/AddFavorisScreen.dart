import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder/geocoder.dart';
import '../ui/Palette.dart';
import '../noyau/Personne.dart';
import '../noyau/Favoris.dart';


class AddFavorisScreen extends StatelessWidget {
  String favoris;
  Personne p;
  String nom;

  AddFavorisScreen(this.p, this.nom);

//***************************add a marker to favoris on firestore***************************************//  
  addToFavoris() async {
    final query = favoris;
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    Firestore.instance.collection('users').document(p.compte.email).collection("favoris").document(first.featureName).setData({
      'coords': GeoPoint(first.coordinates.latitude, first.coordinates.longitude),
      'place': first.featureName ,
      'nom': nom ,
    });
    Favoris fav = new Favoris(nom, first.featureName) ;
    p.favoris.add(fav);
  }

  ///********************************************************************************************************/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff5813ea),
          title:Text(
            'Ajout lieu aux favoris',
            style: TextStyle(fontWeight:FontWeight.bold ,fontSize: 18),

            textAlign: TextAlign.center,),

          centerTitle: true,
          actions: <Widget>[
            Container(
              child:Icon(Icons.add ,size: 30, ),
              margin:EdgeInsets.only(right: 100),
            )

          ],


        ),
        body: Container(
            child: SingleChildScrollView(
              child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Entrer l''adresse'),
                      keyboardType: TextInputType.text,
                      onChanged: (String val) {
                        favoris = val;
                      },
                    ),
                    RaisedButton(
                      onPressed: () async {
                        addToFavoris();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      textColor: Colors.white,
                      child: Text('Add it',
                        style: TextStyle(fontSize: 18),
                      ),
                      color: Colors.purple,
                    )
                  ]
              ),
            )
        )
    );
  }

}