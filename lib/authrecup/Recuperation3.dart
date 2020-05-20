import 'package:flutter/material.dart';
import 'Recuperation2.dart';
import 'Recuperation1.dart';
import 'Recuperation2.dart';


class Recuperation3 extends StatelessWidget {
  @override
  final focus = FocusNode();
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
                MaterialPageRoute(builder: (context) => Recuperation2()),
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
            height: 15,
          ),
          /*Center(
            child: Text("Un code vous à été envoyé vers votre téléphone ",

              style: TextStyle(
                fontFamily: 'Gilroy',
                color: Color(0xff6d7587),
                fontSize: 20,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ),*/
          SizedBox(
            height: 15,
          ),
          Form(
            key: _formKey1,
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
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
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(focus);
                      },
                      // focusNode: focus,
                      validator: (value) {
                        if ((value.isEmpty) ||(value.length != 6)){
                          return "Au moins 6 caractères";
                        } else {
                          print("All is good");
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.lock),
                        hintText: " Nouveau mot de passe",
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
                      // textInputAction: TextInputAction.next,
                      //autofocus: true,
                      /*onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(focus);
                      },*/
                      focusNode: focus,
                      validator: (value) {
                        if ((value.isEmpty) ||(value.length < 6)){
                          return "Veuillez introduire le code";
                        } else {
                          print("All is good");
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.lock),
                        hintText: " Confirmer mot de passe",
                      ),
                      style: new TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Color(0xff6d7587),
                          letterSpacing: 1),
                    ),
                  ),
                ),

              ],
            ),
          ),
          SizedBox(
            height: 5,
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

                    //Scaffold.of().showSnackBar(this.snackBar);
                  }

                }
                ,
              ),
            ],
          )
        ],
      ),
    );
  }
}