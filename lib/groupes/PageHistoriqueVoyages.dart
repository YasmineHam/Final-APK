import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../noyau/Groupe.dart';
//import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neumorphic/neumorphic.dart';
import '../PagePrincipale.dart';
import '../ui/Palette.dart';
class PageHistorique extends StatefulWidget {
  //final List<String> list ;
  Groupe g;

  PageHistorique(this.g);

  @override
  _PageHistoriqueState createState() => _PageHistoriqueState();
}

class _PageHistoriqueState extends State<PageHistorique> {

  var list2 = <bool>[true, false, true];
  Color _iconColor = Palette.bleu;
  static const _popItem = <String>["Definir comme destination", "Definir comme arret","Supprimer"];
  static List<PopupMenuItem<String>> pop = _popItem
      .map((String val) => PopupMenuItem<String>(
    value: val,
    child: Text(val),
  ))
      .toList();
  String value;

  Future<bool> addDialogConfirmationSuppression(BuildContext context, String msg, String doc) async {
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
                Text('Confirmation'),
                Icon(
                  Icons.question_answer,
                  color: Colors.purple,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('Supprimer'),
                  textColor: Colors.blue,
                  onPressed: () {
                    Firestore.instance.collection('groups').document(widget.g.id).collection("historique").document(doc).delete();
                    Navigator.of(context).pop();
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
                  "L'historique",
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    color: Palette.violet,
                    fontSize: 38,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.normal,
                  ),
                  textAlign: TextAlign.start,
                ),
                Icon(
                  Icons.location_on,
                  color: Palette.violet,
                  size: 40,
                ),

              ],
            ),

            leading: IconButton(
              alignment: Alignment.topLeft,
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 40,
              ),
              color: Palette.violet,
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            centerTitle: true,
            titleSpacing: 0,
            elevation: 0.0,
            // This removes the shadow from all App Bars.
            backgroundColor: Palette.background,
          ),
        ),
        backgroundColor: Color(0xffe0e5ec),
        body: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Container(
                height: 500,
                //width: MediaQuery
                //.of(context).size.width * 0.45,
                // color: Colors.red,
                child: StreamBuilder <QuerySnapshot>(
                  stream: Firestore.instance.collection('groups').document(widget.g.id).collection("historique").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Palette.violet),
                      ),
                        
                      );
                    }

                    else {
                      return ListView.builder(
                        itemBuilder: (Contex, index) {

                          DocumentSnapshot document = snapshot.data.documents[index];
                          return ListTile(
                              title: NeuCard(
                                  color: Color(0xffe0e5e),
                                  bevel: 12,
                                  width: 250,
                                  height: 100,
                                  curveType: CurveType.flat,
                                  decoration: NeumorphicDecoration(
                                      color: Color(0xffe0e5ec),
                                      borderRadius: BorderRadius.circular(8)),
                                  child:
                                  new Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(child: IconButton(icon: Icon(
                                          Icons.label_important,
                                          color: Palette.rose,
                                          size: 40,
                                        ), onPressed: () {  },
                                        )),
                                          Container(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width * 0.45,
                                                
                                            child: Text(
                                              (document.data['place']==null)?"":document.data['place'],
                                              style: TextStyle(
                                                fontFamily: 'Gilroy',
                                                color: Palette.violet,
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                fontStyle: FontStyle.normal,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Spacer(),
                                          Text(
                                            //'12-23-2022 12H30',
                                            (document.data['heure']==null)?"":document.data['heure'].toString(),
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              color: Palette.violet,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                              fontStyle: FontStyle.normal,
                                            ),
                                        ),
                                        /*Expanded(child: IconButton(icon: Icon(
                                    Icons.question_answer,
                                    color: Palette.rose,
                                    size: 40,
                                   ),
                                   onPressed: () {
                                        addDialogConfirmationSuppression(context,"Voulez vous vraiment supprimer ce lieu des favoris",document.data['place']);
                                    },
                                   )),*/
                                      ]
                                  )));
                        },
                        itemCount: snapshot.data.documents.length,

                      );
                    }
                  },
                ),
              ),
            ],
          ),

    );
  }
}