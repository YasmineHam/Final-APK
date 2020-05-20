import 'package:flutter/material.dart';
import '../customWidgets/style.dart';

// ignore: must_be_immutable
class MyTextFieldEditting extends StatelessWidget{

  //final Widget child;
  final Icon icon;
  double largeur = 400;
  double hauteur = 50;
  final String defaultText;
  final  inputType;
  bool focusMe = false;
  double  textsize = 17;


  MyTextFieldEditting({@required this.icon, this.inputType,this.defaultText, this.focusMe,this.hauteur,this.largeur,this.textsize});

  Widget build(BuildContext context) {
    return Center(child: Container(
      margin: new EdgeInsets.symmetric(horizontal: 20.0),
      width: this.largeur,
      height: this.hauteur,

      decoration: myBoxDecoration,
      child: TextFormField(
        textInputAction: TextInputAction.next,
        autofocus: this.focusMe,
        /*onFieldSubmitted: (v) {
                    FocusScope.of(context).requestFocus(focus);
                  },*/
        // focusNode: focu,
        validator: (value) {

          if (value.isEmpty) {
            return "Veuillez introduire le code";
          } else return null;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: this.icon,
          hintText: this.defaultText,
        ),
        keyboardType: this.inputType,
        style: new TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: textsize,

            color: Color(0xff6d7587),
            letterSpacing: 1
        ),
        textAlign: TextAlign.center,
      ),
    ),
    );

  }


}