import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import '../geoloc/PlacePick2.dart';
import '../geoloc/PlacePick2Main.dart';
import 'PageFavoris.dart';
import '../noyau/Personne.dart';
import '../ui/Palette.dart';
import '../noyau/Favoris.dart';

class ModifierFavori extends StatefulWidget {
  bool ajout; //si ajout est a vrai alors cette page sert a ajouter un nouveau favori sinon c'est pour modifier
  Personne personne;
  static var dest;
  int indice; //l'indice du favori
  ModifierFavori(this.personne,this.ajout,this.indice);
  @override
  _ModifierFavoriState createState() => _ModifierFavoriState();

}

class _ModifierFavoriState extends State<ModifierFavori> {
  String nom;
  String favori;
  var adresse ;
  final _formKey = GlobalKey<FormState>();
  addToFavoris() async {
    final query = favori;
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    Firestore.instance.collection('users').document(widget.personne.compte.email).collection("favoris").document(favori).setData({
      'coords': GeoPoint(first.coordinates.latitude, first.coordinates.longitude),
      'place': favori ,
      'nom': nom ,
    });
    Favoris fav = new Favoris(nom, favori) ;
    widget.personne.favoris.add(fav);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          69.13134765625,
        ),
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                (widget.ajout == true)? "Ajouter un favori": "Modifier favori",
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  color: Palette.violet,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.start,
              ),
              Icon(
                (widget.ajout == true)?
                Icons.add_location :
                Icons.edit,
                color: Palette.violet,
                size: 30,
              ),

            ],
          ),

          iconTheme: IconThemeData(
            color: Palette.violet,
            size: 40,//change your color here
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check, color: Palette.bleu, size: 40),
              iconSize: 40,
              onPressed: (){
                //Save
                adresse =  "adresse de votre favori" ;
                if (_formKey.currentState.validate())
                {

                  Favoris favoris = new Favoris(nom, adresse);
                  //print(adresse);
                  if (widget.personne.favoris == null)
                  {
                   // print('---------------------------------------------');
                    widget.personne.favoris = new List<Favoris>();
                  }
                  widget.personne.favoris.add(favoris);
                  favori = PlacePick2.pickResult.formattedAddress;
                  //nom = favoris.name;
                  addToFavoris();
                }
                Navigator.push(context,  MaterialPageRoute(builder: (context) => PageFavoris(widget.personne)));
              },
            ),

          ],
          centerTitle: true,
          titleSpacing: 0,
          elevation: 0.0,
          // This removes the shadow fro m all App Bars.
          backgroundColor: Palette.background,
        ),
      ),
      backgroundColor: Color(0xffe0e5ec),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox (
                height: 20,
              ),
              Container(
                margin: new EdgeInsets.symmetric(horizontal: 20.0),
                width: 400,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffe0e5ec),
                  borderRadius: BorderRadius.zero,
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
                child: TextFormField(
                  validator: (value){
                    if (value.isEmpty)
                    {
                      return "Veuillez introduire un nom";
                    }
                    nom = value;
                    return null;
                  },
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  initialValue: (widget.ajout)? null: widget.personne.favoris[widget.indice].name ,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    //contentPadding: EdgeInsets.all(20),
                    hintText: (widget.ajout)? "Nom pour votre favori": null,

                  ),
                  style: new TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: Palette.sousTitre,
                      decoration: null,
                      letterSpacing: 1),
                ),

              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: new EdgeInsets.symmetric(horizontal: 20.0),
                width: 400,
                //* height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffe0e5ec),
                  borderRadius: BorderRadius.zero,
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
                  child: Text(
                    (PlacePick2.pickResult == null)? "Adresse pour votre favori": PlacePick2.pickResult.name,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        color: Palette.violet,
                        decoration: null,
                        letterSpacing: 1),
                    textAlign: TextAlign.start,
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()){
                     // print(nom);
                      PlacePick2.option = 2;
                      PlacePick2(widget.personne);
                      //adresse = PlacePick2.pickResult.name;
                      Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>PlacePick2Main(widget.personne)),
                                );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
