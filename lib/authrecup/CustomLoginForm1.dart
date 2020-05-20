import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:geodesy/geodesy.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../noyau/Admin.dart';
import '../noyau/Groupe.dart';
import '../noyau/Personne.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../ui/size_screen.dart';
import 'Recuperation1.dart';
import '../accueil/Accueil.dart';
import '../PagePrincipale.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../groupes/crud.dart';

class CustomLoginForm1 extends StatefulWidget {
  @override
  _CustomLoginFormState1 createState() => _CustomLoginFormState1();
}

class _CustomLoginFormState1 extends State<CustomLoginForm1> {
  bool _passwordVisible = false;
  Personne per = new Personne();
  final _formKey = GlobalKey<FormState>();
  String email, password, userName;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bddMethods crudObj = bddMethods();

  final snackBar = SnackBar(
      content: Text('Yay! A SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ));

  @override
  Widget build(BuildContext context)

  // all our app widgets
  {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          displayHeight(context) * 0.082,
        ),
        child: AppBar(
          title: Text(
            "S'inscrire",
            style: TextStyle(
              fontFamily: 'Gilroy-ExtraBold.ttf',
              color: Color(0xff6220ed),
              fontSize: 25,
              // fontWeight: FontWeight.w300,
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
              print("retour");
            },
          ),
          centerTitle: false,
          titleSpacing: 0,
          elevation: 0.0,
          // This removes the shadow from all App Bars.
          backgroundColor: Color(0xffe0e5ec),
          //backgroundColor: Colors.red,
        ),
      ),
      backgroundColor: Color(0xffe0e5ec),
      body: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text("Connexion",
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          color: Color(0xff4b00e9),
                          fontSize: 35,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal,
                        )),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.08,
                  ),

                  Center(
                    child: Container(
                      margin: new EdgeInsets.symmetric(horizontal: 20.0),
                      width: displayWidth(context) * 0.82,
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
                          Pattern pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(value))
                            return 'Veuillez introduire un Email valide';
                          else {
                            print("value : $value");
                            email = value;
                            per.compte.numTel = email;
                            print("email : $email");
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.email),
                          hintText: " Email ",
                          //hintText: " numero de rl ",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            color: Color(0xff6d7587),
                            letterSpacing: 1.5),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.04,
                  ),
                  Center(
                    child: Container(
                      margin: new EdgeInsets.symmetric(horizontal: 20.0),
                      width: displayWidth(context) * 0.82,
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
                          if ((value.isEmpty) || (value.length < 6)) {
                            return "Le mot de passe doit contenir au moins 6 caractères";
                          } else {
                            print("Mot de passe et $value");
                            per.compte.passWord = value;
                            password = value;
                            print("pass $password");

                            return null;
                          }
                        },
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
                            letterSpacing: 1.5),
                        obscureText: !_passwordVisible,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: displayHeight(context)* 0.05,
                  ),
                  Column(
                    children: <Widget>[
                      //Bouton confirmer

                      Center(
                        child: FlatButton(
                          padding: EdgeInsets.all(0.5),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              await signIn(email);
//                              FirebaseAuth.instance.currentUser().then((firebaseUser){
//                                if(firebaseUser != null) {
//                                  Navigator.push(
//                                    context,
//                                    MaterialPageRoute(builder: (context) =>
//                                        PagePrincipale(per)),
//                                  );
//                                }
//                              });
                              //Scaffold.of().showSnackBar(this.snackBar);
                            }
                          },
                          child: Container(
                            child: Center(
                                child: new Text("Confirmer",
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-ExtraBold.ttf',
                                      color: Color(0xff5813ea),
                                      fontSize: 25,
                                      //fontWeight: FontWeight.w300,
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
                                    blurRadius: 20,
                                    spreadRadius: 0),
                                BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    offset: Offset(-10, -10),
                                    blurRadius: 20,
                                    spreadRadius: 0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FlatButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Recuperation1()),
                            );
                          },
                          child: Text("Mot de passe oublié",
                              style: TextStyle(
                                fontFamily: 'Gilroy-ExtraBold.ttf',
                                color: Color(0xff3cbbeb),
                                fontSize: 20,
                                // fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.normal,
                              )))
                    ],
                  ),

                  ///Bouton de connexion avec google
                  Center(
                    child: _signInButton(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///***********************************************************************///

  Future<FirebaseUser> _signInGoogle(BuildContext context) async {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text('Sign in'),
    ));
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    AuthResult user = await _firebaseAuth.signInWithCredential(credential);
    FirebaseUser userDetails = user.user;
    //ajout de l'utilisateur à la base de données
    userName = userDetails.displayName;
    email = userDetails.email;
    crudObj.addUser(email, 'compte', {
      'Username': userName,
      'Email': email,
    });
    per.compte.email = userDetails.email;
    per.compte.userName= userDetails.displayName;
    return userDetails;
  }

  ///*********************************************************************************
  ///*********************************************************************///
  signIn(String e) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((signedInUser) async{
      print('connecté');
      ShowToast("Connexion avec succès"); //affichage d'une icône

      //Ajout de l'utilisateur à la base de données

    per.Listegroupe= await crudObj.getListGrp(email);


    await Firestore.instance.collection('users').document(email).collection('compte').document('compte').get().then((document) async{
      per.compte.userName=( document.data["Username"]== null) ? "":document.data["Username"]  ;
      per.compte.numTel =( document.data["Phone number"]== null) ? "" :document.data["Phone number"] ;
      per.compte.email =( document.data["Email"]== null) ? "" :document.data["Email"] ;
      per.photo = (document.data['Photo']==null) ? "https://firebasestorage.googleapis.com/v0/b/testnotif-5c70d.appspot.com/o/users%2Fgotrackprofil.png?alt=media&token=77131013-4b51-4cf3-8561-48c98a4b6d08" :document.data['Photo'];
      return per;
    }).catchError((e){print(e);});



    await Firestore.instance.collection("users").document(email).collection("liste de groupe").getDocuments().then (
            (querySnapshot ) async {

          querySnapshot.documents.forEach((result) async {
            print(result.data);
            Groupe grp = new Groupe();
            await Firestore.instance.collection('groups').document(result.documentID).get().then((document) async  {
              grp.id = (document.documentID);
              grp.code=( document.data["code"]== null) ? "" :document.data["code"] ;
              grp.master=( document.data["master"]== null) ? false :document.data["master"] ;
              grp.timeLast = (document.data["timeLast"]== null) ? "-----" :document.data["timeLast"] ;
              grp.lastMessage = (document.data["lastMsg"]== null) ? "Aucun message à afficher" :document.data["lastMsg"] ;
              grp.unread = (document.data["unread"]== null) ? false :document.data["unread"] ;

              //* grp.destination=( document.data["destination"]== null) ? LatLng(0.0,0.0) :document.data["destination"] ;
              //* grp.photo=( document.data["photo"]== null) ? "" :document.data["photo"] ;
              Admin adm = new Admin();
              await Firestore.instance.collection('groups').document(result.documentID).collection('users').getDocuments().then((querySnapshot) async {
                querySnapshot.documents.forEach((docum) async {
                  await  Firestore.instance.collection('users').document(docum.documentID).collection("compte").document('compte')
                      .get().then((document) async  {
                    adm.compte.userName=( document.data["Username"]== null) ? "":document.data["Username"] ;
                    adm.compte.numTel =( document.data["Phone number"]== null) ? "" :document.data["Phone number"] ;
                    adm.compte.email =( document.data["Email"]== null) ? "" :document.data["Email"] ;

                  });
                  grp.setAdmin(adm);
                });
              });
            }).catchError((e){print(e);});
            await Firestore.instance.collection("groups").document(result.documentID).collection("membres").getDocuments()
                .then((querySnapshot )  {
              querySnapshot.documents.forEach((resu) async {

                Personne membre = new Personne();


                //* membre.groupeActif=g;
                // membre.vitesse =( documen.data["vitesse"]== null) ? 0 :documen.data["vitesse"] ;
                //*  membre.position =( documen.data["position"]== null) ? GeoPoint(0.0, 0.0) :documen.data["position"] ;

                await  Firestore.instance.collection("users").document(resu.documentID).collection('compte').document('compte')
                    .get().then((document) async  {
                  membre.compte.userName=( document.data["Username"]== null) ? "":document.data["Username"] ;
                  membre.compte.email =( document.data["Email"]== null) ? "" :document.data["Email"] ;

                 // membre.groupeActif = ( document.data["groupeActif"]== null) ? "" :document.data["groupeActif"] ;

                  membre.photo = (document.data['Photo']== null) ? "https://firebasestorage.googleapis.com/v0/b/geoloc-c278e.appspot.com/o/users%2Fgotrackprofil.png?alt=media&token=6bdfbdeb-531c-470a-a4f6-7ce216f22281":document.data['Photo'];
                });

                grp.listMembres.add(membre);
                print(membre.toString());

              });
            });
            await Firestore.instance.collection("groups").document(result.documentID).collection("masters").getDocuments()
                .then((querySnapshot )  {
              querySnapshot.documents.forEach((resu) async {

                Personne master = new Personne();
                await Firestore.instance.collection("users").document(resu.documentID).get().then((documen)  async {
                  //Groupe g= new Groupe();
                  //*  g.id =( documen.data["groupeActif"]== null) ? documen.data["groupeActif"] :"" ;
                  //* membre.groupeActif=g;
                  // membre.vitesse =( documen.data["vitesse"]== null) ? 0 :documen.data["vitesse"] ;
                  //*  membre.position =( documen.data["position"]== null) ? GeoPoint(0.0, 0.0) :documen.data["position"] ;

                  await  Firestore.instance.collection("users").document(resu.documentID).collection('compte').document('compte')
                      .get().then((document)  async {
                    master.compte.userName=( document.data["Username"]== null) ? "":document.data["Username"] ;
                    master.compte.numTel =( document.data["Phone number"]== null) ? "" :document.data["Phone number"] ;
                    master.compte.email =( document.data["Email"]== null) ? "" :document.data["Email"] ;
                    //* master.compte.passWord =( document.data["Password"]== null) ? "" :document.data["Email"] ;
                    master.photo = (document.data['Photo'] == null) ? "https://firebasestorage.googleapis.com/v0/b/testnotif-5c70d.appspot.com/o/users%2Fgotrackprofil.png?alt=media&token=77131013-4b51-4cf3-8561-48c98a4b6d08" : document.data["Photo"];

                  });
                }).catchError((e){print(e);});

                grp.listMasters.add(master);
                print(master.toString());
              });
            });
            per.listeGroupes.add(grp);
            print(grp.toString());
            return per;
          });
          return per;
        });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            PagePrincipale(per)),
      );
        }).catchError((e) {
      ShowToast('Veuillez réessayer');
      print(e);
    });
    //* return per;
    print('---------------**---------------------------------------------');

    print('---------------****---------------------------------------------');
    print(per.photo);
    return per ;



  }//SignInnIn

  ///***********************************************************************///
  void ShowToast(message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
      fontSize: 16.0,
    );
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
            content: Text(msg),
            title: Row(
              children: const <Widget>[
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
                  }),
            ],
          );
        });
  }

  ///****************Boutton de connexion avec google*********************///
  Widget _signInButton(context) {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        print('-----------------------------------------------------');
        _signInGoogle(context).then((FirebaseUser user) {
          print(user.email);
          print('-----------------------------------------------------');
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return PagePrincipale(per);
          }));
        }).catchError((e) {
          print(e);
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("photos/google_logo.png"), height: 33.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Se connecter avec Google',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
