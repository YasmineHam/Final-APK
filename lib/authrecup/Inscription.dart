import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../accueil/Accueil.dart';
import '../PagePrincipale.dart';
import '../noyau/Personne.dart';
import '../groupes/crud.dart';
import '../ui/Palette.dart';
import '../ui/size_screen.dart';
import '../ui/size_screen.dart';
import '../ui/size_screen.dart';


class Inscription extends StatefulWidget {
  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  bool _passwordVisible1 = false;
  bool _passwordVisible = false;


  @override
  final _formKeyins = GlobalKey<FormState>();
  final focus = FocusNode();
  bddMethods crudObj = bddMethods();
  String n;
  String userName;
  String password, password2;
  String email;
  String phoneNum;
  Personne per = new Personne();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          displayHeight(context) * 0.082,
        ),
        child: AppBar(
          title: Text(
            "Retour",
            style: TextStyle(
              fontFamily: 'Gilroy-ExtraBold.ttf',
              color: Color(0xff6220ed),
              fontSize: 25,
              //fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
            ),
            textAlign: TextAlign.start,
          ),
          leading: IconButton(
            alignment: Alignment.topLeft,
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 35,
            ),
            color: Color(0xff4b00e9),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Accueil()),
              );
              // print("retour");
            },
          ),
          centerTitle: false,
          titleSpacing: 0,
          elevation: 0.0,
          // This removes the shadow from all App Bars.
          backgroundColor: Color(0xffe0e5ec),
        ),
      ),
      backgroundColor: Palette.background,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: this._formKeyins,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: <Widget>[
                Center(
                  child: Text("Inscription",
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        color: Color(0xff4b00e9),
                        fontSize: 35,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                      )),
                ),

                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    margin: new EdgeInsets.symmetric(horizontal: 20.0),
                    width: displayWidth(context)*0.82,
                    height: displayHeight(context)*0.065,
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
                        if (value.isEmpty) {
                          return "Veuillez introduire le nom d'utilisateur";
                        } else {
                          print(value);
                          userName = value;
                          per.compte.userName = userName;
                          print("userName : $userName");
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.person,color: Colors.grey[600]),
                        hintText: "Nom d'utilisateur",
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
                          fontSize: 18,
                          color: Color(0xff6d7587),
                          letterSpacing: 1),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    margin: new EdgeInsets.symmetric(horizontal: 20.0),
                    width: displayWidth(context)*0.82,
                    height: displayHeight(context)*0.065,
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
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(focus);
                      },
                      // focusNode: focus,
                      validator: (value){
                        Pattern pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regex = new RegExp(pattern);
                        if (!regex.hasMatch(value))
                          return 'Veuillez introduire un Email valide';
                        else{
                          print("value : $value");
                          email = value;
                          per.compte.email = email;
                          print("email : $email");
                          return null ;
                        }

                        /*{
                        if ((value.isEmpty) ||(value.length < 10)){
                          return "Veuillez introduire un numéro de téléphone valide";
                        } else {
                          print("value : $value");
                          phoneNum = value.toString();
                          print("phoneNum : $phoneNum");
                          return null ;
                        }*/
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.email),
                        hintText: " Email ",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      style: new TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Color(0xff6d7587),
                          letterSpacing: 1),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    margin: new EdgeInsets.symmetric(horizontal: 20.0),
                    width: displayWidth(context)*0.82,
                    height: displayHeight(context)*0.065,
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
                        if ((value.isEmpty)||(value.length<6))  {
                          n = value.toString();
                          return "Le mot de passe doit contenir au moins 6 caractères";
                        } else {
                          print("Mot de passe et $value");
                          password = value;
                          per.compte.passWord = value;
                          print("pass $password");

                          return null;
                        }
                      },
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      onFieldSubmitted: (v){
                        FocusScope.of(context).requestFocus(focus);
                      },
                      obscureText: !_passwordVisible,
                      //   focusNode: focus,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            }),
                        border: InputBorder.none,
                        icon: Icon(Icons.lock),

                        hintText: " Mot de passe ",
                      ),

                      style: new TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Color(0xff6d7587),
                          letterSpacing: 1),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    margin: new EdgeInsets.symmetric(horizontal: 20.0),
                    width: displayWidth(context)*0.82,
                    height: displayHeight(context)*0.065,
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

                      // textInputAction: TextInputAction.next,
                      //autofocus: true,
                      /*onFieldSubmitted: (v){
                        FocusScope.of(context).requestFocus(focus);
                      },*/

                      validator: (value) {
                        if ((value.isEmpty)||(value!=password))  {
                          n = value.toString();
                          return "Le mot de passe est incorrect";
                        } else {
                          print("Mot de passe est $value");
                          password2 = value;
                          print("pass $password2");
                          return null;
                        }
                      },
                      obscureText: !_passwordVisible1,
                      focusNode: focus,

                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible1
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible1 = !_passwordVisible1;
                                });
                              }),
                          border: InputBorder.none,
                          icon: Icon(Icons.lock),
                          hintText: "Confirmer mot de passe"
                        //hintText: " numero de rl ",
                      ),

                      style: new TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Color(0xff6d7587),
                          letterSpacing: 1),
                    ),
                  ),
                ),
                SizedBox(
                  height: displayHeight(context)*0.05,
                ),
                Center(
                  child: FlatButton(

                    padding: EdgeInsets.all(0.5),
                    onPressed: () async {
                      if (_formKeyins.currentState.validate())
                      {
                        //*  MyApp.list.add(p);
                        signUp(context);

//                        FirebaseAuth.instance.currentUser().then((firebaseUser){
//                          if(firebaseUser != null) {
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(builder: (context) =>
//                                  PagePrincipale(per)),
//                            );
//                          }
//                        });

                      }
                      //print(MyApp.list);print(p);
                    },
                    child: Container(
                      child: Center(
                          child: new Text("Confirmer",
                              style: TextStyle(
                                fontFamily: 'Gilroy-ExtraBold.ttf',
                                color: Color(0xff5813ea),
                                fontSize: 25,
                                //fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              ))),
                      width: displayWidth(context)* 0.52,
                      height: displayHeight(context)*0.09,
                      decoration: new BoxDecoration(
                        color: Color(0XFFE0E5EC).withOpacity(1),
                        borderRadius: BorderRadius.circular(47),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0XFFA6ABBD).withOpacity(1),
                              offset: Offset(10, 10),
                              blurRadius: 13,
                              spreadRadius: 0),
                          BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              offset: Offset(-10, -10),
                              blurRadius: 13,
                              spreadRadius: 0),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///****************************methods**********************************///
  static Future<bool> checkExist(String docID) async {
    bool exists = false;
    try {
      await Firestore.instance.collection("users").document(docID).get().then((doc) {
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
  ///*********************Methodes de connexion et verification***************///
  void signUp(context) async{
    bool exist = await checkExist(email); //verifie si le username existe déjà
    if (exist) {
      addDialog(context, 'Email déjà utilisé !');
    }
    else {
      final Firestore _db = Firestore.instance;
      final FirebaseMessaging _fcm = FirebaseMessaging();
      FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password).then((SignedInUser) {
        print('ajouté');
        //Ajout de l'utilisateur à la base de données
        crudObj.addUser(email, 'compte', {
          'Username': userName,
          'Email': email,}).catchError((e) {

        });
        ShowToast("Inscription avec succès"); //affichage d'une
      }).catchError((e) {
        if (e is PlatformException) {
          print(e.message);
        }
        else {
          ShowToast('Une erreur est survenue, veuillez réessayer');
          print(e.message);
        }
      });
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      user.sendEmailVerification().then((sent){
        addDialog(context, 'Un email de validation vous a été envoyé ');
      }).catchError((e) {
        print("An error occured while trying to send email verification");
        print(e.message);
      });

      // Get the token for this device
      String fcmToken = await _fcm.getToken();

      // Save it to Firestore
      if (fcmToken != null) {
        var tokens = _db
            .collection('users')
            .document(email)
            .collection('tokens')
            .document(fcmToken);

        await tokens.setData({
          'token': fcmToken,
          'createdAt': FieldValue.serverTimestamp(), // optional
          'platform': Platform.operatingSystem // optional
        });
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            PagePrincipale(per)),
      );


    }


  }//SingUp
  ///***********************************************************************///
  void ShowToast(message){
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
                  Icons.info,
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


}