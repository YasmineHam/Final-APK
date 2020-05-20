import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import '../PagePrincipale.dart';
import '../ui/Palette.dart';
import '../noyau/Personne.dart';
import '../editingAccount/EditPassword.dart';
import '../editingAccount/EditUsername.dart';


class ParametresCompte extends StatefulWidget {
  Personne personne;
  ParametresCompte(this.personne);

  @override
  _ParametresCompteState createState() => _ParametresCompteState();
}

class _ParametresCompteState extends State<ParametresCompte> {
  final editformKey = GlobalKey<FormState>();
  double _hauteur = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          69.13134765625,
        ),
        child: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check, color: Palette.bleu, size: 40),
              iconSize: 40,
              onPressed: (){
                if (editformKey.currentState.validate())
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PagePrincipale(widget.personne)));
                }

              },
            ),

          ],
          title: Text(
            "Profil",
            style: TextStyle(
              fontFamily: 'Gilroy',
              color: Palette.violet,
              fontSize: 30,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            ),
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            alignment: Alignment.topLeft,
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 40,
            ),
            color: Color(0xff4b00e9),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PagePrincipale(widget.personne)),
              );
              print("retour");
            },
          ),
          centerTitle: true,
          titleSpacing: 0,
          elevation: 2.0,
          // This removes the shadow from all App Bars.
          backgroundColor: Color(0xffe0e5ec),
        ),
      ),
      backgroundColor: Palette.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
            builder: (context) => Form(
              key: editformKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      child: Center(
                        child: Column(
                          children: <Widget>[
//                            NeuCard(
//                              curveType: CurveType.convex,
//                              bevel: 12,
//                              color: Palette.background,
//                              height: 200,
//                              width: 370,
//                              child: Column(
//                                children: <Widget>[
//                                  SizedBox(
//                                    height: 150,
//                                    child: Center(
//                                      child: Text(
//                                          "Ici On met la photo de profil"),
//                                    ),
//                                  ),
//                                  FlatButton(
//                                    child: Text(
//                                      "changer la photo de profil",
//                                      style: TextStyle(
//                                        color: Palette.bleu,
//                                        fontFamily: "Gilroy",
//                                        fontSize: 15,
//                                        fontWeight: FontWeight.w400,
//                                        letterSpacing: -1,
//                                      ),
//                                    ),
//                                    onPressed: () {},
//                                  ),
//                                ],
//                              ),
//                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    NeuCard(
                      curveType: CurveType.convex,
                      bevel: 12,
                      color: Palette.background,
                      height: 400,
                      width: 370,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "Nom d'utilisateur:",
                              style: TextStyle(
                                  fontSize: 20,
                                  letterSpacing: -1,
                                  color: Palette.sousTitre,
                                  fontFamily: "Gilroy",
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.start,

                            ),
                            leading: Icon(Icons.email),
                            subtitle: Text(
                              widget.personne.compte.email,
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: "Gilroy",
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Mot de passe",
                              style: TextStyle(
                                  fontSize: 20,
                                  letterSpacing: -1,
                                  color: Palette.sousTitre,
                                  fontFamily: "Gilroy",
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.start,

                            ),
                            leading: Icon(Icons.lock),
                            /* subtitle: Text(
                                  widget.personne.compte.numTel,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: "Gilroy",
                                    color: Colors.black,
                                  ),
                                ),*/
                            trailing: IconButton(icon: Icon(Icons.edit), onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>editPassword(widget.personne) ));

                            },color: Palette.sousTitre,),
                          ),
                          ListTile(
                            title: Text(
                              "Nom d'utilisateur:",
                              style: TextStyle(
                                  fontSize: 20,
                                  letterSpacing: -1,
                                  color: Palette.sousTitre,
                                  fontFamily: "Gilroy",
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.start,

                            ),
                            leading: Icon(Icons.person),
                            subtitle: Text(
                              widget.personne.compte.userName,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Gilroy",
                                color: Colors.black,
                              ),
                            ),
                            trailing: IconButton(icon: Icon(Icons.edit), onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EditUsername(widget.personne)));
                            },color: Palette.sousTitre,),
                          ),
                          /* TextFormField(

                                initialValue: widget.personne.compte.userName,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.person
                                  ),
                                  labelText: "Nom d'utilisateur:",
                                  labelStyle: TextStyle(
                                      fontSize: 25,
                                      color: Palette.sousTitre,
                                      fontFamily: "Gilroy",
                                      fontWeight: FontWeight.w400),
                                  //border: InputBorder.none,
                                ),

                                validator: (value){
                                  if(value == ""){
                                    return "Nom d'utilisateur deja utilisé";
                                    //Il n'est pas deja pris
                                  }
                                  else {
                                    widget.personne.compte.userName = value;
                                   return null;
                                  }
                                },
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: "Gilroy",
                                ),
                              ),*/
                          SizedBox(
                            height: _hauteur,
                          ),
//                          TextFormField(
//                            initialValue: "email@exemple.com",
//                            decoration: InputDecoration(
//                              labelText: "Email:",
//                              enabled: true,
//                              icon: Icon(Icons.email),
//                              labelStyle: TextStyle(
//                                  fontSize: 25,
//                                  color: Palette.sousTitre,
//                                  fontFamily: "Gilroy",
//                                  fontWeight: FontWeight.w400),
//                              //border: InputBorder.none,
//                            ),
//
//                            //enabled: false,
//                            keyboardType: TextInputType.text,
//                            style: TextStyle(
//                              fontSize: 25,
//                              fontFamily: "Gilroy",
//                            ),
//                          ),
                          SizedBox(
                            height: _hauteur,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
//                              FlatButton(
//                                child: Text(
//                                  "Supprimer le compte",
//                                  textAlign: TextAlign.start, style :TextStyle(
//                                    fontSize: 18,
//                                    color: Palette.sousTitre,
//                                    fontFamily: "Gilroy",
//                                    fontWeight: FontWeight.w400
//                                ),
//                                ),
//                                onPressed: (){
//                                },
//                              ),
                            ],
                          )
                        ],

                      ),
                    ),

                  ],
                ),

              ),
            )
        ),
      ),
    );
  }
}
