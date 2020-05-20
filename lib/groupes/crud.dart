import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';


import '../noyau/Admin.dart';
import '../noyau/Groupe.dart';
import '../noyau/Personne.dart';

class bddMethods {
  String test;

  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    }
    else {
      return false;
    }
  }

  //ajout d'un utilisateur dans la collection users
  Future<void> addUser(String username, String attribut, userData) async {
    if (isLoggedIn()) {
      Firestore.instance.collection('users').document(username)
          .collection(attribut).document(attribut)
          .setData(userData)
          .catchError((e) {
        print(e);
      });
      Firestore.instance.collection('users').document(username)
          .setData({
        'distance': 0.0,
        'groupeActif': "",
        'position': GeoPoint(0.0,0.0),
        'vitesse': 0.0,
      })
          .catchError((e) {
        print(e);
      });
    }
    else {
      print("Vous devez vous connecter d'abord");
    }
  }


  Future<void> removeData(userData) async {
    if (isLoggedIn()) {
      Firestore.instance.collection("users").document(userData)
          .delete()
          .catchError((e) {
        print(e);
      });
    }
    else {
      print("Vous devez vous connecter d'abord");
    }
  }

  //Recuperer des données de la BDD
  //on passe en paramètres le nom de la collection et le nom du document qui est le ID de l'utilisateur
  Widget GetFromeCollection(String collection, String username,
      String attribut) {
    return StreamBuilder(
      stream: Firestore.instance.collection(collection)
          .document(username).collection(attribut).document(attribut)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text('Loading data ...');
        return Column(
          children: <Widget>[
            Text('\nEmail: ' + snapshot.data['Email']),
            Text('Nom d"utilisateur : ' + snapshot.data['Username']),

          ],
        );
      },
    );
  }

  Future updateEmail(context, String username, String email) async {
    if (isLoggedIn()) {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      user.updateEmail(email).catchError((e) {
        print(e);
      });
      Firestore.instance.collection('users').document(username)
          .collection('compte').document('compte').updateData({
        'Email': email,
      }).catchError((e) {
        print(e);
      });

      FirebaseAuth.instance.signOut();
      addDialog(
          context, 'Votre Email a été modifié, veuillez l\'utiliser lors de '
          'votre prochaine connexion');
    }
  }

  ///*************************************************************************//
  Future updatePassword(context, String username, String password) async {
    if (isLoggedIn()) {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      user.updatePassword(password).catchError((e) {
        print(e);
      });
      Firestore.instance.collection('users').document(username)
          .collection('compte').document('compte').updateData({
        'Password': password,
      }).catchError((e) {
        print(e);
      });
      print(password);
      addDialog(context, 'Votre mot de passe a été modifié');
    }
  }

  ///**************************************************************************///
  Future updateUsername(context, String username, String email) async {
    if (isLoggedIn()) {
      Firestore.instance.collection('users').document(email)
          .collection('compte').document('compte').updateData({
        'Username': username,
      }).then((action) {
        addDialog(context, 'Votre Nom d\'utilisateur a été modifié');
      }).catchError((e) {
        print(e);
      });
    }
  }



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
                  Icons.check_circle,
                  color: Colors.green,
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

  ///*************************************************************************

  Future<bool> checkExist(String docID) async {
    bool exists = true;
    try {
      await Firestore.instance.collection("users").document(docID).get().then((
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

  ///recup d'un utilisateur de la bdd et sa création s'il existe
  ///

  RecupUser(context, String id) async {
    Personne per = new Personne();

    /*bool exist = await checkExist(id); //verifie si le username existe déjà
    if (!exist) {
      addDialog(context, 'l''utilisateur que vous voulez ajouter n''existe pas dans la base de données');
    }
    else {*/
    var doc = Firestore.instance.collection('users').document(id);
    print("coooooooooccccccouuuuuuuuu");
    print(id);
    await doc.get().then((document) {
      print("oh lalalallala ${document.data}");
      //p.groupeActif =( document.data["groupeActif"]== null) ? document.data["groupeActif"] :"" ;
      // p.vitesse =( document.data["vitesse"]== null) ? 0 :document.data["vitesse"] ;
      //per.position = (document.data["position"] == null) ? "" : document.data["position"];
      //p.distance = ( document.data["distance"]== null) ? 0 :document.data["distance"] ;
      return per;
    });
    var docc = Firestore.instance.collection('users').document(id).collection(
        'compte').document('compte');
    await docc.get().then((document) {
      print("oh lalalallala ${document.data}");
      per.setUser(
          (document.data["Username"] == null) ? "" : document.data["Username"]);
      print(per.compte.userName);
      per.compte.numTel =
      (document.data["Phone number"] == null) ? "" : document
          .data["Phone number"];
      per.compte.email =
      (document.data["Email"] == null) ? "" : document.data["Email"];
      per.compte.passWord =
      (document.data["Password"] == null) ? "" : document.data["Password"];
      return per;
    });


    print(per.compte.userName);
    return per;
  }


  ///recup d'un groupe de la bdd et sa création s'il existe
  ///

  RecupGroup(context, String id) async {

    /*bool exist = await checkExist(id); //verifie si le username existe déjà
    if (!exist) {
      addDialog(context, 'l''utilisateur que vous voulez ajouter n''existe pas dans la base de données');
    }
    else {*/

    Groupe grp = new Groupe();
    await Firestore.instance.collection('groups').document(id).get().then((
        document) {
      print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb ${document.data}");
      print(id);
      grp.id = (document.documentID);
      grp.code = (document.data["code"] == null) ? "" : document.data["code"];
      grp.destination = (document.data["destination"] == null) ? "" : document
          .data["destination"];
      grp.photo =
      (document.data["photo"] == null) ? "" : document.data["photo"];
      Admin adm = new Admin();
      Firestore.instance.collection('groups').document(id)
          .collection("users")
          .getDocuments()
          .then((querySnapshot) {
        querySnapshot.documents.forEach((resultat) {
          print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa ${resultat.data}");
          // adm.groupeActif =( resultat.data["groupeActif"]== null) ? resultat.data["groupeActif"] :"" ;
          // adm.vitesse =( resultat.data["vitesse"]== null) ? 0 :resultat.data["vitesse"] ;
         // adm.position = (resultat.data["position"] == null) ? "" : resultat.data["position"];
          // adm.distance =( resultat.data["distance"]== null) ? 0 :resultat.data["distance"] ;

          Firestore.instance.collection('groups').document(id).collection(
              "users").document(resultat.documentID).collection('comptes')
              .getDocuments().then((querySnapshot) {
            querySnapshot.documents.forEach((result) {
              adm.compte.email =
              (result.data["Email"] == null) ? "" : result.data["Email"];
              adm.compte.userName =
              (result.data["Username"] == null) ? "" : result.data["Username"];
              adm.compte.numTel =
              (result.data["Phone number"] == null) ? "" : result
                  .data["Phone number"];
              adm.compte.passWord =
              (result.data["Password"] == null) ? "" : result.data["Password"];
            });
          });
        });
        Firestore.instance.collection("groups").document(id).collection(
            "membres").getDocuments()
            .then((querySnapshot) {
          querySnapshot.documents.forEach((resu) {
            print(
                "yyyyyyyyyyyyaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaayyyyyyyyyyyy ${resu
                    .data}");
            Personne membre = new Personne();
            Firestore.instance.collection("users").document(
                resu.data["Email du membre"]).get().then((documen) {
              print(
                  "jjjjjjeeeeeeeeeee ssssssssuuuuiiiissss laaaaaaaaaaaaaaaaaaaa ${documen
                      .data}");
              // membre.groupeActif =( documen.data["groupeActif"]== null) ? documen.data["groupeActif"] :"" ;
              // membre.vitesse =( documen.data["vitesse"]== null) ? 0 :documen.data["vitesse"] ;
             // membre.position = (documen.data["position"] == null) ? "" : documen.data["position"];
              // membre.distance =( documen.data["distance"]== null) ? 0 :documen.data["distance"] ;

              Firestore.instance.collection("users").document(
                  resu.data["Email du membre"]).collection('compte').document(
                  "compte").get().then((document) {
                membre.setUser(
                    (document.data["Username"] == null) ? "" : document
                        .data["Username"]);
                membre.compte.numTel =
                (document.data["Phone number"] == null) ? "" : document
                    .data["Phone number"];
                membre.compte.email =
                (document.data["Email"] == null) ? "" : document.data["Email"];
                membre.compte.passWord =
                (document.data["Password"] == null) ? "" : document
                    .data["Email"];
              });
            });

            grp.listMembres.add(membre);
          });
        });

        grp.setAdmin(adm);
        adm.listeGroupes.add(grp);
      });
      return grp;
    });


    return grp;
  }

  ///*********************************************************************************
  void deleteData(String id) {
    try {
      Firestore.instance
          .collection('groups')
          .document(id)
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }

  ///*********************************************************************************
  void deleteDatauser(String id, String idd) {
    try {
      Firestore.instance
          .collection('users')
          .document(id).collection('liste de groupe').document(idd).delete();
    } catch (e) {
      print(e.toString());
    }
  }

/*
  getIdgroup () {
    Firestore.instance..collection('users')
        .document(id).collection('liste de groupe')
  }*/

  getListGrp(String email) async {
    List res = new List<String>();
    String p;
    await Firestore.instance.collection("users").document(email).collection(
        "liste de groupe").getDocuments().then(
            (querySnapshot) {
          querySnapshot.documents.forEach((result) {
            print(result.data);
            print('documentID:');
            print(result.documentID);
            res.add(result.documentID);
            //Groupe grp = new Groupe();
          });
        });
    print(
        'recup grouuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuupês');
//    for (String codeGrp in res) {
//      print('recupere');
//      print(codeGrp);
//    }
//    if (res.contains('groupe1')) {
//      print('CONTAAAAAAAAAAAAAINS');
//    }
//    else{print('dont containt');}
    return res;

  }
}