import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../ui/Palette.dart';
import '../ui/size_screen.dart';
import '../noyau/Groupe.dart';
import '../noyau/Personne.dart';
import '../authrecup/Recuperation1.dart';
import '../ui/customWidgets/MyButton.dart';
import '../ui/customWidgets/MyTextField.dart';

class CodePin extends StatefulWidget {
  bool demandaccept=false;
  Groupe groupe;
  Personne personne;
  CodePin(this.groupe,this.personne);
  @override
  _CodePinState createState() => _CodePinState();
}

class _CodePinState extends State<CodePin> {
  final _formKeyins = GlobalKey<FormState>();
  final focus = FocusNode();
  String code_in;
  //int _code = 1111;
  String _code1 = "2";
  String _code2 = "3";
  String _code3 = "5";
  String _code4 = "7";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          displayHeight(context) * 0.082,

        ),
        child: AppBar(
          iconTheme: IconThemeData(color: Palette.violet,opacity: 1,size: 30),
          title: Text(
            "Code Groupe",
            style: TextStyle(
              fontFamily: 'Gilroy',
              color: Palette.violet,
              fontSize: 30,
              //fontWeight: FontWeight.w400,
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
      body: Form(
        key: this._formKeyins,
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Text(
                " Code ",//////////////////////////////////////////////////////////////////////////////////////////////
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  color: Color(0xff6d7587),
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 30,
              ),
              /* Container(
                height: 70,
                margin: EdgeInsets.fromLTRB(14, 15, 14, 15),
                child: Neumorphic(


                  //padding: const EdgeInsets.all(10),

                  boxShape: NeumorphicBoxShape.roundRect(
                        borderRadius: BorderRadius.circular(50),

                    ),
                    style: NeumorphicStyle(

                        shape: NeumorphicShape.concave,
                        depth: -15,
                        intensity: 0.5,

                        color: Color(0xffe0e5ec),
                        lightSource: LightSource.topLeft,
                        //color: Colors,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),


                    ),
                    //child: Text("hi"),
                ),
              ),*/
              Container(
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
                    if (value.isEmpty)  {
                      return "Veuillez introduire le code";
                    } else {
                      if (code_in != widget.groupe)
                      {
                        return "Le code vous venez d'introduire est incorrect";
                      }
                      else
                      {
                        print(value);
                        code_in=value;
                        return null;
                      }
                    }
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.lock,color: Colors.grey[600]),
                    hintText: "code",
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
              SizedBox(
                height: 50,
              ),

//              Text("  Code:",
//                style: TextStyle(
//                  fontFamily: 'Gilroy',
//                  color: Color(0xff6d7587),
//                  fontSize: 30,
//                  fontWeight: FontWeight.w300,
//                  fontStyle: FontStyle.normal,
//
//
//                ),
//              ),
              SizedBox(
                height: 30,
              ),
              /**
               *Le CODE est generÃ© automatiquement
               * Il doit Ãªtre unique !
               */
/*              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Neumorphic(
                    boxShape: NeumorphicBoxShape.circle(),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      depth: 15,
                      intensity: 0.5,
                      color: Color(0xffe0e5ec),
                      lightSource: LightSource.topLeft,
                      //color: Colors,
                    ),
                    child: FlatButton(
                      onPressed: null,
                      child: Text(
                        this._code1,
                        style: TextStyle(
                          fontFamily: "Gilroy",
                          fontSize: 50,
                          fontWeight: FontWeight.w300,
                          color: Color(0xff4f00f2),
                        ),
                      ),
                    ),


                  ),
                  Neumorphic(
                    boxShape: NeumorphicBoxShape.circle(),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      depth: 15,
                      intensity: 0.5,

                      color: Color(0xffe0e5ec),
                      lightSource: LightSource.topLeft,
                      //color: Colors,
                    ),
                    child: FlatButton(
                      onPressed: null,
                      child: Text(
                        this._code2,

                        style: TextStyle(
                          fontFamily: "Gilroy",
                          fontSize: 50,
                          fontWeight: FontWeight.w300,
                          color: Color(0xff4f00f2),
                        ),
                      ),
                    ),
                  ),
                  Neumorphic(
                    boxShape: NeumorphicBoxShape.circle(),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      depth: 10,
                      intensity: 0.5,

                      color: Color(0xffe0e5ec),
                      lightSource: LightSource.topLeft,
                      //color: Colors,
                    ),
                    child: FlatButton(
                      onPressed: null,
                      child: Text(
                        _code3,
                        style: TextStyle(
                          fontFamily: "Gilroy",
                          fontSize: 50,
                          fontWeight: FontWeight.w300,
                          color: Color(0xff4f00f2),
                        ),
                      ),
                    ),
                  ),
                  Neumorphic(
                    boxShape: NeumorphicBoxShape.circle(),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      depth: 15,
                      intensity: 0.5,

                      color: Color(0xffe0e5ec),
                      lightSource: LightSource.topLeft,
                      //color: Colors,
                    ),
                    child: FlatButton(
                      onPressed: null,
                      child: Text(
                        this._code4,
                        style: TextStyle(
                          fontFamily: "Gilroy",
                          fontSize: 50,
                          fontWeight: FontWeight.w300,
                          color: Color(0xff4f00f2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 70,
              ),*/
              Center(
                child: MyButton(
                  text: "Valider",
                  hauteur:displayHeight(context)*0.09 ,
                  longeur: displayWidth(context)* 0.52,
                  onPressed: () {

                    ShowToast("Vous venez de rejoindre le groupe");

                    widget.groupe.listMembres.add(widget.personne);
                    Firestore.instance.collection('groups').document(widget.groupe.id).collection('membres').document(widget.personne.compte.email).setData({
                      'Email du membre': widget.personne.compte.email,
                    });

                    widget.personne.listeGroupes.add(widget.groupe);
                    Firestore.instance.collection('users').document(
                        widget.personne.compte.email).collection(
                        "liste de groupe").document(widget.groupe.id)
                        .setData({
                      'Groupe': (widget.groupe.id),
                    }); //


                    /*/// envoyer la demande
                    Firestore.instance.collection('groups').document(widget.groupe.id).collection('demandes').document(widget.personne.compte.email)
                        .setData({
                      "username" : widget.personne.compte.userName,
                    });
                    widget.groupe.listDemandes.add(widget.personne);

                    if (widget.demandaccept)
                    {

                    }
*/

                  }
                ),

              ),
              /*
              Center(
                child: NeumorphicButton(
                  onClick: (){
                    print("hi");
                  },
                  style:NeumorphicStyle(
                    depth: 14,
                    color: Color(0xffe0e5ec),
                  ),
                  boxShape: NeumorphicBoxShape.roundRect(
                    borderRadius: BorderRadius.circular(50),

                  ),

                  child: Center(
                      child: new Text("Valider",
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            color: Color(0xff5813ea),
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ))),
                ),
              )*/
              SizedBox(
                height: 50,
              ),
            ],

          ),

        ),
      ),
    );
  }

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

}



