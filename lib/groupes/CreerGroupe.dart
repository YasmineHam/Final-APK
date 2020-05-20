

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import '../PagePrincipale.dart';
import '../noyau/Admin.dart';
import '../noyau/Arret.dart';
import '../noyau/Groupe.dart';
import '../noyau/Messages.dart';
import '../ui/Palette.dart';
import '../noyau/Personne.dart';
import '../ui/customWidgets/MyTextField.dart';
import '../ui/customWidgets/MyButton.dart';
import 'Ajout_contact.dart';

/*
const admin = require('firebase-admin');

require(String s) {
}
const db = admin.firestore();*/


class CreerGroupe extends StatefulWidget {
  Personne p ;
  CreerGroupe(this.p);
  @override
  _CreerGroupeState createState() => _CreerGroupeState();
}

class _CreerGroupeState extends State<CreerGroupe> {

  @override
  final _formKeyins = GlobalKey<FormState>();
  final focus = FocusNode();
  Groupe gr = new Groupe();
  Groupe grp = new Groupe();
  String id;
  FieldPath fp;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        backgroundColor: Palette.violet,
        centerTitle: true,


        title: Text("Creation groupes",
          style: TextStyle
            (
            fontFamily: 'Gilroy-ExtraBold',
            fontSize: 20,
            color: Color(0xffffffff),
          ),
          textAlign: TextAlign.left,
        ),
      ),
      body:Form(
        key: this._formKeyins,
        child:
        Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text("Nom du groupe:",
              style: TextStyle(
                fontFamily: 'Gilroy',
                color: Palette.sousTitre,
                fontSize: 18,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: new EdgeInsets.symmetric(horizontal: 20.0),
              width: 400,
              height: 50,
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
              child: TextFormField(
                validator: (value) {
                  print('couuuuuuuuuuuuuuuuuucouuuuuuuuuuuuuuuuuuuuuuu');
                  if (value.isEmpty || value.length < 3) {
                    return "Veuillez introduire l'id du groupe ou bien votre id a moins de 3 caractères";
                  } else {
                    print(value);
                    id = value;
                    grp.setId(id);
                    print('couuuuuuuuuuuuuuuuuucouuuuuuuuuuuuuuuuuuuuuuu');
                    print (id);
                    return null;
                  }
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.person, color: Colors.grey[600]),
                  hintText: "Veuillez introduire le nom du groupe",
                  //labelText: "username",
                ),
                textInputAction: TextInputAction.next,
                autofocus: true,
                onFieldSubmitted: (v) {
                  FocusScope.of(context).requestFocus(focus);
                },
                //keyboardType: TextInputType,
                style: new TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Color(0xff6d7587),
                    letterSpacing: 1),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MyButton(onPressed: () async {

              if (_formKeyins.currentState.validate()) {
                //gr = widget.p.creerGroupe(id);

                print(widget.p);
                var line2='la photo';
                /// generate the code
                String cd =randomString(8);
                print(cd);
                Admin adm = new Admin(userName: widget.p.compte.getUserName(),passWord: widget.p.compte.getPassWord(),numTel: widget.p.compte.getNumTel(),
                    email: widget.p.getCompte().getEmail()
                    ,groupeActif: widget.p.groupeActif
                    ,vitesse: widget.p.vitesse,position: widget.p.position,distance: widget.p.distance);
                print(adm);
                Groupe grp =new Groupe(p: adm,id: id,photo: line2,code: cd,master: true);


                grp.listMembres.add(widget.p);
                grp.listMasters.add(widget.p);
                widget.p.listeGroupes.add(grp);
                // widget.p.addListeGroupes(grp);
                widget.p.setGroupeActif(grp);
                print (grp);
                print("coucouuuu");
                print(grp.getCode());
                create(context,grp);
                await Firestore.instance.collection("groups")
                    .document(grp.getId())
                    .updateData({
                  "master":true,
                });
                FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
                firebaseMessaging.subscribeToTopic(id);
               // Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PagePrincipale(widget.p))
                  //Param_groupe(widget.p,widget.g)),
                );
                /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  Ajout_contact(widget.p, widget.p.groupeActif.listMembres ,
                      "liste des masters", 0)),
              //ici c'est la page ou on va ajouter les masters au groupe
              //(widget.p.groupeActif.listMembres == null) ? 0 : widget.p
            );*/}
            }, text: "Groupe master"),
            SizedBox(height: 20),

            MyButton(onPressed: () async {
              if (_formKeyins.currentState.validate()) {
                print(widget.p);
                var line2='la photo';
                /// generate the code
                String cd =randomString(8);
                print(cd);
                Admin adm = new Admin(userName: widget.p.compte.getUserName(),passWord: widget.p.compte.getPassWord(),numTel: widget.p.compte.getNumTel(),
                    email: widget.p.compte.email
                    ,groupeActif: widget.p.groupeActif
                    ,vitesse: widget.p.vitesse,position: widget.p.position,distance: widget.p.distance);
                print(adm);
                Groupe grp =new Groupe(p: adm,id: id,photo: line2,code: cd,master: false);


                grp.listMembres.add(widget.p);
                widget.p.listeGroupes.add(grp);
                // widget.p.addListeGroupes(grp);
                widget.p.setGroupeActif(grp);
                print (grp);
                print("coucouuuu");
                print(grp.getCode());
                create(context,grp);
                await Firestore.instance.collection("groups")
                    .document(grp.getId())
                    .updateData({
                  "master":false,
                });
                FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
                firebaseMessaging.subscribeToTopic(id);
                //Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PagePrincipale(widget.p))
                  //Param_groupe(widget.p,widget.g)),
                );


                /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  Ajout_contact(grp,widget.p,widget.p.groupeActif.listMembres ,
                      "liste des membres", 1)),
              //* ici c'est la page ou on ajoute les membres au groupe
            );*/

             */
              }

            }, text: "Groupe normal")

          ],

        ),
      ),
    );
  }



  static Future<bool> checkExist(String docID) async {
    bool exists = false;
    try {
      await Firestore.instance.collection("groups").document(docID).get().then((
          doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  ///***************************Showing a dialog****************************///

  Future<bool> addDialog(BuildContext context, String msg) async {
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

                Icon(
                  Icons.error,
                  color: Colors.redAccent,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('Ok'),
                  textColor: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pop();
                  }
              ),
            ],

          );
        });
  }

  ///***********************************************************************///
  void ShowToast(message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
      fontSize: 16.0,);
  }

  ///**************************************************************///
  @override
  Future<void> addMembres(Groupe grp,String attribut) async {

    var it = grp.getMembres().iterator;
    while ( it.moveNext())
    {
      var other = it.current;
      Firestore.instance.collection('groups').document(attribut).collection('membres').document(other.getCompte().getEmail(

      ))
          .setData({
        'Email du membre':(other.getCompte().getEmail()),
      });
      /*DocumentReference usersReference;
       Firestore.instance.collection('users').document(other.getCompte().getUserName()).get()
          .then((DocumentSnapshot data){  usersReference =data.reference; //this return the DocumentReference })
         print(data.reference.toString());
      });

      Map<String, DocumentReference> userData = {
        'usersReference': usersReference,
      };
      Firestore.instance.collection('groups').document(attribut).collection('membres').add(userData).then((doc) {
        doc.setData({
          'usersReference': usersReference,
        });
      });*/

    }
  }

  ///**************************************************************///
  @override
  Future<void> addMasters(Groupe grp,String attribut) async {

    var it = grp.listMasters.iterator;
    while ( it.moveNext())
    {
      var other = it.current;
      Firestore.instance.collection('groups').document(attribut).collection('masters').document(other.getCompte().getEmail(

      ))
          .setData({
        'Email du membre':(other.getCompte().getEmail()),
      });
      /*DocumentReference usersReference;
       Firestore.instance.collection('users').document(other.getCompte().getUserName()).get()
          .then((DocumentSnapshot data){  usersReference =data.reference; //this return the DocumentReference })
         print(data.reference.toString());
      });

      Map<String, DocumentReference> userData = {
        'usersReference': usersReference,
      };
      Firestore.instance.collection('groups').document(attribut).collection('membres').add(userData).then((doc) {
        doc.setData({
          'usersReference': usersReference,
        });
      });*/

    }
  }


  ///**************************************************************///
  @override
  Future<void> addMessages(Groupe grp,String attribut) async {



    var it = grp.listMessages.keys.toList().iterator;
    while ( it.moveNext())
    {
      var other = it.current;
      var usersReference;
      Firestore.instance.collection('users').document(other.getCompte().getUserName()).get()
          .then((DocumentSnapshot data){  usersReference =data.reference; //this return the DocumentReference })
      });
      Map<String, DocumentReference> userData = {
        'usersReference': usersReference,
      };
      Firestore.instance.collection('groups').document(attribut).collection('messages').add(userData).then((doc) {
        doc.setData(userData);
      });
      Firestore.instance.collection('groups').document(attribut).collection('messages').document(other.getCompte().getUserName())
          .setData({
        'Email du membre':(other.getCompte().getEmail()),
        'Ses messages' : grp.listMessages.values.toList().toString(),

      });

      var itt = grp.listMessages.values.toList().iterator;
      while (it.moveNext())
      {
        var otherr = itt.current;
        Firestore.instance.collection('groups').document(attribut).collection('messages').document(other.getCompte().getUserName())
            .collection('Liste des messages').document('ses messages').setData({

          'Date d''envoi' : Timestamp.now(),
          'Descriptif du message' : otherr.getDescriptif(),

        });
      }


    }
  }

  ///**************************************************************///
  @override
  Future<void> addDemandes(Groupe grp,String attribut) async {



    var it = grp.getDemandes().iterator;
    while ( it.moveNext())
    {
      var other = it.current;
      Firestore.instance.collection('groups').document(attribut).collection('demandes').document(other.getCompte().getUserName())
          .setData({
        'Email du membre':(other.getCompte().getEmail()),
      });
    }
  }


  ///*****************ajout d'un administrateur dans la collection admins
  @override
  Future<void> addAdmin(String groupname,String username,Admin ad,String attribut, userData) async {

    Firestore.instance.collection('groups').document(groupname)
        .collection('users').document(username).collection('comptes').document(attribut)
        .setData(userData)
        .catchError((e) {
      print(e);
    });
    Firestore.instance.collection('groups').document(groupname)
        .collection('users').document(username)
        .setData({
      'distance': ad.getDistance(),
      'groupeActif': ad.getGroupActif(),
      'position': ad.getPosition(),
      'vitesse': ad.getVitesse(),
    })
        .catchError((e) {
      print(e);
    });
  }


  ///*********************Methode de verification***************///

  void create(context,Groupe group) async {
    print('heyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
    print(group.getId());
    bool exist = await checkExist(
        group.getId()); //verifie si le username existe déjà
    if (exist) {
      addDialog(context, 'Ce groupe existe déjà !');
    }
    else {
      //bool existe = await checkExist(group.getAdmin().getCompte().getUserName()); //verifie si le username existe déjà
      //if (existe) {
      // addDialog(context, 'Identifiant déjà utilisé !');}

      // else {

      print("yyyyyyyyyyyoooooooohhhhhhhoooooooooooo");
      print(group.getAdmin().getCompte().getEmail());

      //Ajout de l'admin à la base de données
      addAdmin(group.getId(), group.getAdmin().getCompte().getEmail(),
          group.getAdmin(), group.getAdmin().getCompte().getEmail(), {
            'Username': group.getAdmin().getCompte().getUserName(),
            'Phone number': group.getAdmin().getCompte().getEmail(),
            'Email': group.getAdmin().getCompte().getEmail(),
            'Password': group.getAdmin().getCompte().getPassWord(),})
          .catchError((e) {

      });
      print(widget.p.compte.email);
      print(widget.p.groupeActif);
      Firestore.instance.collection('users')
          .document(widget.p.compte.email)
          .updateData({

        'groupeActif': widget.p.groupeActif.id,
      });

      // }
      addMembres(group, group.getId());
      addMasters(group, group.getId());
      addMessages(group, group.getId());
      addDemandes(group, group.getId());

      Firestore.instance.collection("groups")
          .document(group.getId())
          .setData({

        'code': group.getCode(),
        'destination': group.getDestination(),
        'photo': "url",
        'lastMsg': group.getlastMsg(),
        'unread': false,
        'timeLast': group.getTime(),
        // 'Liste de messages': group.getMessages(),
        // 'Arrets': group.getArret(),

      }).catchError((e) {
        ShowToast('Une erreur est survenue, veuillez réessayer');
        print(e.message);
      });
      Firestore.instance.collection('users').document(
          group.getAdmin().getCompte().getEmail())
          .collection('liste de groupe').document(group.id).setData({
        'groupReference': group.id, //usersReference
        //'Email': group.getAdmin().getCompte().getEmail(),

      });
      print('groupe ajouté');
      ShowToast("Groupe créé avec succès"); //affichage d'une
      // var doc =Firestore.instance.collection('users').document(group.getAdmin().getCompte().getEmail()).collection('liste de groupe')
      // .document(group.getId());
      String s; // pour recup l'id bizzare génére=é
      //DocumentReference usersReference;
      // Firestore.instance.collection('groups').document(group.getId()).get()
      //    .then((DocumentSnapshot data){  usersReference =data.reference; //this return the DocumentReference })
      //print(data.reference.toString());
      // });

      //Map<String, DocumentReference> userData = {
      //  'usersReference': usersReference,
      // };
      /* Firestore.instance.collection('users').document(group.getAdmin().getCompte().getEmail())
          .collection('liste de groupe').add(userData).then((doc) {

        doc.setData({

          'usersReference': usersReference,
        });
       // s=doc.documentID;
      });*/


      // s=doc.documentID;


    }
  }
  }
///***********************************************************************///



