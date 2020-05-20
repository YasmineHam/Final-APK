import 'package:flutter/material.dart';
import '../accueil/Accueil.dart';
import 'CustomLoginForm1.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Recuperation1 extends StatelessWidget {
  @override
  final focus = FocusNode();
  String _email ;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    final _formKey1 = GlobalKey<FormState>();
    return Scaffold(

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          69.13134765625,
        ),
        child: AppBar(
          title: Text(
            "Retour",
            style: TextStyle(
              fontFamily: 'Gilroy',
              color: Color(0xff6220ed),
              fontSize: 25,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
            ),
            textAlign: TextAlign.start,
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
                MaterialPageRoute(builder: (context) => CustomLoginForm1()),
              );
              print("retour");
            },
          ),
          centerTitle: false,
          titleSpacing: 0,
          elevation: 0.0,
          // This removes the shadow from all App Bars.
          backgroundColor: Color(0xffe0e5ec),
        ),
      ),
      backgroundColor: Color(0xffe0e5ec),
      body: Column(
        children: <Widget>[
          Center(
            child: Text("Récupération",
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  color: Color(0xff4b00e9),
                  fontSize: 35,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text("Veuillez confirmer votre email",

              style: TextStyle(
                fontFamily: 'Gilroy',
                color: Color(0xff6d7587),
                fontSize: 20,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Form(
            key: _formKey1,
            child: Center(
              child: Container(
                margin: new EdgeInsets.symmetric(horizontal: 20.0),
                width: 400,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffe0e5ec),
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),//noir : 0.1 c'est opacity
                      offset: Offset(-6, -2),
                      blurRadius: 6.2,
                      spreadRadius: 3,
                    ),
                    BoxShadow(

                      color: Color.fromRGBO(250, 250, 250, 0.9),//blanc
                      offset: Offset(6, 2),
                      blurRadius: 6.2,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: TextFormField(
                  // textInputAction: TextInputAction.next,
                  //autofocus: true,
                  /*onFieldSubmitted: (v) {
                    FocusScope.of(context).requestFocus(focus);
                  },*/
                  // focusNode: focus,
                  validator: (value){
                    Pattern pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = new RegExp(pattern);
                    if (!regex.hasMatch(value))
                      return 'Veuillez introduire un Email valide';
                    else{
                      print("value : $value");
                      _email = value;
                      print("email : $_email");
                      return null ;
                    }
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.email),
                    hintText: " Email",
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
          ),
          SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text("Suivant",
                style: TextStyle(
                  color: Color(0xff4b00e9),
                  fontSize: 25,
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,


                ),

              ),
              IconButton(
                icon :const Icon(Icons.arrow_forward_ios,
                  size: 35,
                ),
                color: Color(0xff4b00e9),
                onPressed: (){
                  if (_formKey1.currentState.validate()) {
                    print("entery");
                    resetPassword(context, _email);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Accueil()),
                    );

                    //Scaffold.of().showSnackBar(this.snackBar);
                  }

                }
                ,
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),

        ],
      ),
    );
  }
  ///*****************************Password reset****************************///
  Future<void> resetPassword(context,String email) async {

    await _firebaseAuth.sendPasswordResetEmail(email: email).whenComplete((){
      addDialog(context,'\tL\'e-mail de réinitialisation de mot de passe vous a été envoyé.\n'
          '\tVeuillez vérifiez votre boite mail.');
    }).catchError((e) {
      print(e);
    });

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
///***********************************************************************///
}
