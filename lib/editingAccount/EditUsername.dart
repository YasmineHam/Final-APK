import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../groupes/crud.dart';
import '../ui/Palette.dart';
import '../noyau/Personne.dart';
import 'ParametresCompte.dart';

class EditUsername extends StatefulWidget {
  Personne personne;
  EditUsername(this.personne);

  @override
  _EditUsernameState createState() => _EditUsernameState();
}

class _EditUsernameState extends State<EditUsername> {
  final _editphoneKey = GlobalKey<FormState>();
  String _newUserName;
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
              onPressed: () async{
                if (_editphoneKey.currentState.validate())
                {
                  print('username==');
                  crudObj.updateUsername(context,_newUserName, widget.personne.compte.email);
                  widget.personne.compte.userName = _newUserName;
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ParametresCompte(widget.personne)));
                }

              },
            ),
          ],
          title: Text(
            "Modifier votre nom d\'utilisateur",
            style: TextStyle(
              fontFamily: 'Gilroy',
              color: Color(0xff6220ed),
              fontSize: 20,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
            ),
            textAlign: TextAlign.center,
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
          centerTitle: true,
          titleSpacing: 0,
          elevation: 0.0,
          // This removes the shadow from all App Bars.
          backgroundColor: Color(0xffe0e5ec),
        ),
      ),
      backgroundColor: Color(0xffe0e5ec),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 15,
          ),
          Form(
            key: _editphoneKey,
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
                        if (value.isEmpty) {
                          return "Veuillez entrer votre nouveau nom";
                        } else {
                          _newUserName = value;
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.person),
                        hintText: "Nouveau nom d\'utilisateur",
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
                        if (value.compareTo(widget.personne.compte.passWord ) != 0){
                          return "Mot de passe incorrect ";
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.lock),
                        hintText: "Entrez votre mot de passe",
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
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );;
  }
}
