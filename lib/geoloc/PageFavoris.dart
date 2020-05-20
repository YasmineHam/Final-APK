import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../groupes/CreerVoyage.dart';
import 'package:neumorphic/neumorphic.dart';
import '../PagePrincipale.dart';
import '../noyau/Personne.dart';
import '../ui/Palette.dart';

class PageFavoris extends StatefulWidget {
  //final List<String> list ;
  Personne p;

  PageFavoris(this.p);

  @override
  _PageFavorisState createState() => _PageFavorisState();
}

class _PageFavorisState extends State<PageFavoris> {

  Future<bool> addDialogConfirmationSuppression(BuildContext context, String msg, dynamic doc, int i) async {
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
                  color: Colors.green,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('Supprimer'),
                  textColor: Colors.blue,
                  onPressed: () {
                    Firestore.instance.collection('users').document(widget.p.compte.email).collection("favoris").document(doc['place']).delete();
                    //widget.p.favoris.removeAt(i);
                    Navigator.of(context).pop();
                    widget.p.favoris.removeAt(i);
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

  Future<bool> addDialogConfirmationArret(BuildContext context, String msg, dynamic document) async {
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
                  color: Colors.green,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('Confirmer'),
                  textColor: Colors.blue,
                  onPressed: () async{

                    if(widget.p.groupeActif != null){
                      await Firestore.instance.collection("groups").document(widget.p.groupeActif.id).collection('arrets').document(document['place']).setData({
                        'coords': document['coords'],
                        'place': document['place'],
                      });
                    } else {
                      await Firestore.instance.collection("users").document(widget.p.compte.email).collection('arrets').document(document['place']).setData({
                        'coords': document['coords'],
                        'place': document['place'],
                      });
                    }
                    await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>
                              PagePrincipale(widget.p),
                        )
                    );
                    //Navigator.of(context).pop();
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
                  onPressed: (){
                    Navigator.of(context).pop();
                  }
              ),
            ],

          );
        });
  }



  Future<bool> addDialogConfirmationDestination(BuildContext context, String msg, dynamic document) async {
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
                  color: Colors.green,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('Confirmer'),
                  textColor: Colors.blue,
                  onPressed: () {
                    CreerVoyage.dest = document['place'];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreerVoyage(widget.p,widget.p.groupeActif)),
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

  //var list1 = <String>['alger','ain Makhlouf','tizi ouzou'];
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
                  "Mes favoris",
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    color: Palette.violet,
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.normal,
                  ),
                  textAlign: TextAlign.start,
                ),
                Icon(
                  Icons.stars,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PagePrincipale(widget.p)),
                );
                //print("retour");
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
//        floatingActionButton:  FloatingActionButton(
//          backgroundColor: Palette.violet,
//          onPressed: () {
//            Navigator.push(
//              context,
//              MaterialPageRoute(
//                  builder: (context) => ModifierFavori(widget.p,true,0)),
//            );
//          },
//          child: Icon(Icons.add),
//
//        ),
        body: /*widget.p.favoris == null)? Center(
        child: Text(
          "Aucun endroit enregistré",
          style:TextStyle(
            fontFamily: 'Gilroy',
            color: Palette.sousTitre,
            fontSize: 30,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
          ),
        ),
      ):
      */
        Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Container(
              height: 500,
              // color: Colors.red,
              child: StreamBuilder <QuerySnapshot>(
                stream: Firestore.instance.collection('users').document(widget.p.compte.email).collection("favoris").snapshots(),
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
                    //QuerySnapshot values = snapshot.data;
                    //var document = snapshot.data;
                    //List<Widget> values = snapshot.data.documents.map<Widget>.;
                    return ListView.builder(
                      itemBuilder: (Contex, index) {
                        //snapshot.data.documents.map<Widget>((document){
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
                              child: ListTile(
                                leading: Icon(
                                  Icons.label_important,
                                  color: Palette.rose,
                                  size: 40,
                                ),
                                trailing: PopupMenuButton(
                                  onSelected: (String val) {
                                    value = val;
                                    switch (value) {
                                      case "Definir comme destination":


                                      //MapPage.dest = snapshot.data.documents.first.data['coords'];
                                        addDialogConfirmationDestination(context, 'Voulez vous vraiment le definir comme destination?', document);


                                        break;
                                      case "Definir comme arrêt":
                                        {
                                          //Arret.dest = widget.p.favoris[index].adresse;
                                          addDialogConfirmationArret(context, 'Voulez vous vraiment le definir comme arret?', document);
                                        }
                                        break;
                                      case "Supprimer":
                                        setState(() {
                                          addDialogConfirmationSuppression(context,"Voulez vous vraiment supprimer ce lieu des favoris",document, index );
                                          //widget.p.favoris.removeAt(index);

                                        }
                                        );
                                        break;

                                    }
                                  },
                                  itemBuilder: (BuildContext context) => pop,
                                  //  icon: Icon(Icons.more_vert,size: 30)
                                ),

                                title: Text(
                                  //(snapshot.data.documents.first.data['nom']==null)?"":snapshot.data.documents.first.data['nom'],
                                  //(document['nom']==null)?"":document['nom'],
                                  //document.data['nom'],
                                  (document.data['nom']==null)?"":document.data['nom'],
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    color: Palette.violet,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w300,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                subtitle: Text(
                                  //snapshot.data.documents.first.data['place'],

                                  document.data['place'],
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    color: Palette.violet,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ),
                            onLongPress: () {
                              // return PopupMenuButton();
                            }
                        );
                        //});
                        //}).toList(),
                      },
                      // },
                      itemCount: snapshot.data.documents.length,
                    );
                  }
                },
              ),
            ),
          ],
        )

    );
  }
}
