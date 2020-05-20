import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../PagePrincipale.dart';
import '../groupes/Groupes_page.dart';
import '../ui/size_screen.dart';
import 'package:share/share.dart';
import '../noyau/Groupe.dart';
import '../noyau/Personne.dart';
import '../authrecup/Recuperation1.dart';
import '../ui/customWidgets/MyButton.dart';
import '../ui/customWidgets/MyTextField.dart';
import 'GroupeToShare.dart';

class Affich_Code extends StatefulWidget {
  Groupe groupe;
  bool demandaccept=false;
  Personne personne;
  Affich_Code(this.groupe,this.personne);
  @override
  _Affich_CodeState createState() => _Affich_CodeState();
}

class _Affich_CodeState extends State<Affich_Code> {
  final _formKeyins = GlobalKey<FormState>();
  final focus = FocusNode();
  String code_in;
  //int _code = 1111;
  // String _code1 = ;
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

          title: Text(
            "Code du groupe",
            style: TextStyle(
              fontFamily: 'Gilroy',
              color: Color(0xff6220ed),
              fontSize:  30,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            ),
            //  textAlign: TextAlign.start,
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
                MaterialPageRoute(builder: (context) => PagePrincipale(widget.personne)),
              );
              print("retour");
            },
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /* SizedBox(
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
            ),*/
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
            /*TextFormField(

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
                icon: Icon(Icons.person,color: Colors.grey[600]),
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
            ),*/
            SizedBox(
              height: 50,
            ),

            Text("  Code:",
              style: TextStyle(
                fontFamily: 'Gilroy',
                color: Color(0xff6d7587),
                fontSize: 30,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal,


              ),
            ),
            SizedBox(
              height: 30,
            ),
            /**
             *Le CODE est generÃ© automatiquement
             * Il doit Ãªtre unique !
             */
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Neumorphic(
                    boxShape: NeumorphicBoxShape.roundRect(borderRadius:BorderRadius.circular(30)),
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
                        // this._code1,
                        widget.groupe.code,
                        style: TextStyle(
                          fontFamily: "Gilroy",
                          fontSize: 30,
                          fontWeight: FontWeight.w300,
                          color: Color(0xff4f00f2),
                        ),
                      ),
                    ),


                  ),
                ),
                Expanded ( child: IconButton(icon: Icon(
                  Icons.content_copy, size: 28, color: Color(0xff4f00f2),),
                  onPressed:() {
                    Clipboard.setData(ClipboardData(text: widget.groupe.code));
                    ShowToast("texte copiÃ©");
                  },

                ),
                ),
                /*ListTile(
                  title: Text(widget.groupe.id),
                  subtitle: Text(widget.groupe.code),
                  onTap: () {} ,
                ),

                  */
                Expanded ( child: IconButton(icon: Icon(
                  Icons.share, size: 28, color: Color(0xff4f00f2),),
                  onPressed:() {
                    GroupeToShare alligator = new GroupeToShare(name: widget.groupe.id,code: widget.groupe.code);
                    share(context, alligator);
                  },

                ),
                ),
                /* Neumorphic(
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
                ),*/
                /* Neumorphic(
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
                ),*/
                /*Neumorphic(
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
                ),*/
              ],
            ),
            /*SizedBox(
              height: 70,
            ),
            Center(
              child: MyButton(
                text: "Valider",
                hauteur: 60,
                longeur: 130,
                onPressed: ()
                {
                  //////////////////////////////////////////////////////////////////////////////////////////////////////

                  /// envoyer la demande
                  Firestore.instance.collection('groups').document(widget.groupe.id).collection('demandes').document(widget.personne.compte.email)
                      .setData({
                    "username" : widget.personne.compte.userName,
                  });
                  widget.groupe.listDemandes.add(widget.personne);
                  ShowToast("Demande envoyÃ© avec succÃ©s");
                  if (widget.demandaccept)
                  {

                  }


                },
              ),
            ),*/
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
          ],
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

  ///************************************************************************///
  void share(BuildContext context , GroupeToShare alligator){
    final RenderBox box = context.findRenderObject();
    final String text = "Pour rejoindre le groupe: ${alligator.name} \n Veuillez utiliser le code: ${alligator.code}";
    Share.share(text,
        sharePositionOrigin: box.localToGlobal(Offset.zero)& box.size);
  }

}

