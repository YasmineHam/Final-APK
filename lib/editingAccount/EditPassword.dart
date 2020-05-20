import 'package:flutter/material.dart';
import 'ParametresCompte.dart';
import '../ui/Palette.dart';
import '../noyau/Personne.dart';
import '../groupes/crud.dart';

class editPassword extends StatefulWidget {
  Personne personne;

  editPassword(this.personne);
  @override
  _editPasswordState createState() => _editPasswordState();
}

class _editPasswordState extends State<editPassword> {
  String _newpassword, _confirmpassword;
  final editPasswordKey = GlobalKey<FormState>();
  bddMethods crudObj = bddMethods();

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
                if (editPasswordKey.currentState.validate())
                {
                  crudObj.updatePassword(context, 'abir', _newpassword);
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ParametresCompte(widget.personne)));
                }

              },
            ),
          ],
          title: Text(
            "Changer le mot de passe",
            style: TextStyle(
              fontFamily: 'Gilroy',
              color: Color(0xff6220ed),
              fontSize: 25,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
            ),
            textAlign: TextAlign.start,
          ),

          /*leading: IconButton(
            alignment: Alignment.topLeft,
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 40,
            ),
            color: Color(0xff4b00e9),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ParametresCompte(widget.personne)),
              );
              print("retour");
            },
          ),*/
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
          /*Center(
            child: Text("Récupération",
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  color: Color(0xff4b00e9),
                  fontSize: 35,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                )),
          ),
          */
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 15,
          ),
          Form(
            key: editPasswordKey,
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
                      /*onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(focus);
                      },*/
                      // focusNode: focus,
                      validator: (value) {
                        if ((value.isEmpty) ||(value.compareTo(widget.personne.compte.passWord) != 0)) {
                          return "Mot de passe incorrect !";
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.lock),
                        hintText: " Ancien mot de passe",
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
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      /*onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(focus);
                      },*/
                      // focusNode: focus,
                      validator: (value) {
                        if ((value.isEmpty) ||(value.length < 6)){
                          return "Le mot de passe doit contenir au moins 6 caractères";
                        } else {
                          print(value);
                          _newpassword = value;
                          return null;
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
                     // focusNode: focus,
                      validator:(value) {
                        if ((value.isEmpty)||(value!= _newpassword))  {
                          return "Le mot de passe est incorrect";
                        } else {
                          print("Mot de passe est $value");
                          _confirmpassword = value;

                          return null;
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
        ],
      ),
    );
  }
}
