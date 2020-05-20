import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../ui/image_pic2.dart';

import 'Ajout_master.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'CreerVoyage.dart';
import 'crud.dart';
import 'Ajout_contact.dart';
import '../geoloc/ChoixDestination.dart';
import '../ui/Palette.dart';
import '../ui/Photo.dart';
import '../ui/SearchBar.dart';
import '../noyau/Personne.dart';
import '../noyau/Groupe.dart';
import '../ui/size_screen.dart';
import '../ui/Palette.dart';
import '../PagePrincipale.dart';
import '../ui/size_screen.dart';

class Param_groupe extends StatefulWidget {
  Groupe g;

  Personne p;

  Param_groupe(this.p, this.g);

  @override
  Param_State createState() => Param_State();
}

class Param_State extends State<Param_groupe> {
  /// pour les membres d'un groupe normal
  static const _popItem1 = <String>[
    "Visualiser l'historique",
    "Quitter le groupe"
  ];

  /// pour les admins d'un normal
  static const _popItem2 = <String>[
    "Ajouter des personnes",
    "Supprimer le groupe",
    "Visualiser l'historique",
    "Quitter le groupe"
  ];

  /// pour les masters d'un groupe master
  static const _popItem3 = <String>[
    "Ajouter des personnes",
    "Supprimer le groupe",
    "Ajouter des masters",
    "Quitter le groupe"
  ];

  /// pour les membres normaux d'un groupe master rien
  static const _popItem4 = <String>[""];

  static List<PopupMenuItem<String>> pop1 = _popItem1
      .map((String val) => PopupMenuItem<String>(
            value: val,
            child: Text(val),
          ))
      .toList();
  static List<PopupMenuItem<String>> pop2 = _popItem2
      .map((String val) => PopupMenuItem<String>(
            value: val,
            child: Text(val),
          ))
      .toList();
  static List<PopupMenuItem<String>> pop3 = _popItem3
      .map((String val) => PopupMenuItem<String>(
            value: val,
            child: Text(val),
          ))
      .toList();
  static List<PopupMenuItem<String>> pop4 = _popItem4
      .map((String val) => PopupMenuItem<String>(
            value: val,
            child: Text(val),
          ))
      .toList();

  String value;
  bool _visibilite = false;

  List<Personne> li = new List<Personne>();

  void showToast() {
    if (widget.g.adm.compte.email.hashCode == widget.p.compte.email.hashCode)
      _visibilite = true;
    else
      _visibilite = false;
  }

  bddMethods crudObj = bddMethods();

  @override
  Widget build(BuildContext context) {
    showToast();


    return Scaffold(

      backgroundColor: Color(0XFFE0E5EC).withOpacity(1),
      body: Container(
        margin: EdgeInsets.only(top: 15),
        child: new GridView.builder(
            itemCount: widget.g.listMembres.length - 1,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(33),
                  ),
                  color: Color(0xffffffff).withOpacity(0.5),
                ),
                child: Column(
                  children: <Widget>[
                    Visibility(
                      visible: _visibilite,
                      child: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            switch (widget.g.existMaster(
                                widget.g.listMembres[index + 1].compte.email)) {
                              case true:
                                {
                                  Firestore.instance
                                      .collection('users')
                                      .document(widget.g.listMembres[index + 1]
                                          .compte.email)
                                      .collection('liste de groupe')
                                      .document(widget.g.id)
                                      .delete()
                                      .catchError((e) {
                                    print(e.toString());
                                  });
                                  widget.g.listMembres[index + 1].listeGroupes
                                      .remove(widget.g);
                                  Firestore.instance
                                      .collection('groups')
                                      .document(widget.g.id)
                                      .collection('masters')
                                      .document(widget.g.listMembres[index + 1]
                                          .compte.email)
                                      .delete()
                                      .catchError((e) {
                                    print(e.toString());
                                  });
                                  widget.g.listMasters
                                      .remove(widget.g.listMembres[index + 1]);
                                  Firestore.instance
                                      .collection('groups')
                                      .document(widget.g.id)
                                      .collection('membres')
                                      .document(widget.g.listMembres[index + 1]
                                          .compte.email)
                                      .delete()
                                      .catchError((e) {
                                    print(e.toString());
                                  });
                                  widget.g.listMembres
                                      .remove(widget.g.listMembres[index + 1]);
                                }
                                break;
                              case false:
                                {
                                  Firestore.instance
                                      .collection('users')
                                      .document(widget.g.listMembres[index + 1]
                                          .compte.email)
                                      .collection('liste de groupe')
                                      .document(widget.g.id)
                                      .delete()
                                      .catchError((e) {
                                    print(e.toString());
                                  });
                                  widget.g.listMembres[index + 1].listeGroupes
                                      .remove(widget.g);
                                  Firestore.instance
                                      .collection('groups')
                                      .document(widget.g.id)
                                      .collection('membres')
                                      .document(widget.g.listMembres[index + 1]
                                          .compte.email)
                                      .delete()
                                      .catchError((e) {
                                    print(e.toString());
                                  });
                                  widget.g.listMembres
                                      .remove(widget.g.listMembres[index + 1]);
                                }
                            }

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Param_groupe(widget.p, widget.g)));
                          }),
                    ),
                    Image_pic2((widget.g.listMembres[index + 1])),
                    Text(
                      ((widget.g.listMembres[index + 1].compte.userName) !=
                              null)
                          ? widget.g.listMembres[index + 1].compte.userName
                          : "",
                      style: TextStyle(
                        fontFamily: 'Gilroy-ExtraBold',
                        fontSize: 12,
                        color: Color(0xffef883e),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "email :",
                      style: TextStyle(
                        fontFamily: 'Gilroy-Light',
                        fontSize: 12,
                        color: Color(0xff6D7587),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      ((widget.g.listMembres[index + 1].compte.email != null))
                          ? widget.g.listMembres[index + 1].compte.email
                          : "$index+1",
                      style: TextStyle(
                        fontFamily: 'Gilroy-Light',
                        fontSize: 12,
                        color: Color(0xff6D7587),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              );
            }),
      ),

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(displayHeight(context) * 0.082),
        child: AppBar(


          iconTheme: IconThemeData(color: Palette.violet, opacity: 1, size: 35),
          backgroundColor: Palette.background,
          /*leading:IconButton(icon: Icon(Icons.supervised_user_circle , size: 50, color: Color(0xff5813ea),)  ),*/
          title: Text(
            ((widget.g.id) != null) ? widget.g.id : "",
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 30,
              color: Palette.violet,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
         // elevation: 0.0,
          actions: <Widget>[
            PopupMenuButton<String>(
              icon: Icon(
                Icons.menu,
                color: Palette.violet,
                size: 25,
              ),
              onSelected: (String val) async {
                print(
                    "yyyyyyoooooooooooddddddddddddeeeeeeeeeeeeeeeeeeellllllllllllllllllllllll");
                print(widget.g.admin.compte.email);
                value = val;
                switch (value) {
                  case "Ajouter des personnes":
                    {
                      /// envoyer une notif invitation à cette personne
                      /* Personne pe = new Personne();

                    pe = await crudObj.RecupUser(context, 'may@gmail.com' );
                    // print(pe);
                    li.add(pe);
                    pe = await crudObj.RecupUser(context, 'nv@gmail.com' );
                    // print(pe);
                    li.add(pe);
*/
                      //  print(li);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Ajout_contact(widget.g,
                                widget.p, li, "liste des membres", 0)),
                      );
                    }

                    break;
                  case "Ajouter des masters":
                    {
                      /// envoyer une notif invitation à cette personne

                      print('MasteeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeR');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Ajout_master(widget.g,
                                widget.p, li, "liste des masters", 0)),
                      );
                    }

                    break;
                  case "Supprimer le groupe":
                    crudObj.deleteData(widget.g.getId());
                    widget.p.listeGroupes.remove(widget.g);
                    crudObj.deleteDatauser(
                        widget.p.getCompte().getEmail(), widget.g.id);
                    //////////////////////////////////////////////
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PagePrincipale(widget.p)),
                    );

                    break;
                  case "Visualiser l'historique":
                    {
                      /// pour lilya c'est ici que tu devras appeler la page historique
                    }
                    break;
                  case "Quitter le groupe":
                    {
                      switch (widget.g.existMaster(widget.p.compte.email)) {
                        case true:
                          {
                            Firestore.instance
                                .collection('users')
                                .document(widget.p.compte.email)
                                .collection('liste de groupe')
                                .document(widget.g.id)
                                .delete()
                                .catchError((e) {
                              print(e.toString());
                            });
                            widget.p.listeGroupes.remove(widget.g);
                            Firestore.instance
                                .collection('groups')
                                .document(widget.g.id)
                                .collection('masters')
                                .document(widget.p.compte.email)
                                .delete()
                                .catchError((e) {
                              print(e.toString());
                            });
                            widget.g.listMasters.remove(widget.p);
                            Firestore.instance
                                .collection('groups')
                                .document(widget.g.id)
                                .collection('membres')
                                .document(widget.p.compte.email)
                                .delete()
                                .catchError((e) {
                              print(e.toString());
                            });
                            widget.g.listMembres.remove(widget.p);
                          }
                          break;
                        case false:
                          {
                            Firestore.instance
                                .collection('users')
                                .document(widget.p.compte.email)
                                .collection('liste de groupe')
                                .document(widget.g.id)
                                .delete()
                                .catchError((e) {
                              print(e.toString());
                            });
                            widget.p.listeGroupes.remove(widget.g);
                            Firestore.instance
                                .collection('groups')
                                .document(widget.g.id)
                                .collection('membres')
                                .document(widget.p.compte.email)
                                .delete()
                                .catchError((e) {
                              print(e.toString());
                            });
                            widget.g.listMembres.remove(widget.p);
                          }
                      }
                    }
                }
              },
              itemBuilder: (BuildContext context) => (widget.g.master)
                  ? ((widget.g.existMaster(widget.p.compte.email))
                      ? pop3
                      : pop4)
                  : ((widget.g.admin.compte.email == widget.p.compte.email)
                      ? pop2
                      : pop1),
            ),
          ],
        ),
      ),
    );
  }
}
/*
class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Ajouter des personnes', icon: Icons.group_add),
  const Choice(title: 'Ajouter un voyage', icon: Icons.add_location),
  const Choice(title: 'Supprimer le groupe', icon: Icons.delete_forever),
];
*/
