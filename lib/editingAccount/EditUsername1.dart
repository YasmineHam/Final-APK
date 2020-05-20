import 'package:flutter/material.dart';

import '../ui/Palette.dart';
import '../noyau/Personne.dart';
import 'ParametresCompte.dart';

class EditPhoneNum1 extends StatefulWidget {
  Personne personne;
  String _phoneNum;
  EditPhoneNum1(this.personne,this._phoneNum);
  @override
  _EditPhoneNum1State createState() => _EditPhoneNum1State();
}

class _EditPhoneNum1State extends State<EditPhoneNum1> {
  @override
  final editphoneKey1 = GlobalKey<FormState>();
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
                if (editphoneKey1.currentState.validate())
                {
                  widget.personne.compte.email = widget._phoneNum;
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
            height: 20,
          ),
          Center(
            child: Text("Un code vous à été envoyé vers votre téléphone, Veuillez l'introduire ",

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
            key: editphoneKey1,
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
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Veuillez introduire le code";
                    } else {
                      return null ;
                    }
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.sms),
                    hintText: " Code",
                  ),
                  keyboardType: TextInputType.phone,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FlatButton(

                child: Text(
                  "Renvoyer le code ?", style: TextStyle(

                  fontFamily: 'Gilroy',
                  color: Color(0xff3cbbeb),
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,

                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
