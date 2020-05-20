import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import '../groupes/Ajout_master.dart';
import '../groupes/Rejoindre_groupe.dart';
import '../noyau/Groupe.dart';
import 'size_screen.dart';
import '../noyau/Personne.dart';
import 'Palette.dart';
import '../groupes/crud.dart';

class SearchBar3 extends StatefulWidget {
  List <String> suggest ;
  Personne p ;
  int  page ;
  String titre;
  List<Groupe> list =[];
  static List<String> recup= [];
  List<String> added =[];
  List<String> get add => added;
  SearchBar3( this.p , this.suggest, this.titre );

  @override
  State<StatefulWidget> createState() {
    return _SearchBar3State();
  }
}

class _SearchBar3State extends State<SearchBar3> {



  String currentText = "";
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  void check ()
  {
    print(widget.added);
  }
  String resu ()
  {
    return widget.added[0];
  }
  bddMethods crudObj = bddMethods();
  @override
  Widget build(BuildContext context) {
    return Container(
      /* width: 50,
      height: 58,
      */

      child: Row
        (
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[



          Container(
            margin: new EdgeInsets.only(top:50),
            width: displayWidth(context)*0.7,
            height: displayWidth(context)*0.1,


            child: Neumorphic(
              boxShape: NeumorphicBoxShape.roundRect( borderRadius:
                  BorderRadius.circular(30)),//roundRect(borderRadius: BorderRadius.circular(30)),
              style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                depth: -10,
                //* lightSource: LightSource.bottomRight,
                //*  color: Colors.grey
              ),
              child:Container(

                margin: EdgeInsets.only(left:20 ,top:10),

                child: SimpleAutoCompleteTextField(
                  style: TextStyle(
                    color: Palette.gris ,
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 20,
                  ),

                  key: key,
                  decoration: new InputDecoration(

                    border: InputBorder.none,
                    hintText: "Rechercher",

                  ),
                  controller: TextEditingController(text: ""),
                  suggestions: widget.suggest,
                  textChanged: (text) => currentText = text,
                  clearOnSubmit: false,
                  textSubmitted: (
                      text) => setState(() {

                    if (text != "") {
                      widget.added.add(text);
                      SearchBar3.recup.add(text);


                    }

                  }),
                ),
              ),

            ),
          ),


          SizedBox(width: 20,),
          Container(
            margin: new EdgeInsets.only(top:50),
            child: Neumorphic(
              child: Center(
                child: IconButton(icon:Icon(Icons.search , size : 24, color: Color(0xFFffffff)
                ),
                  onPressed: () async {
                    check();
                    //return SearchBar.recup;
                    Groupe pe = new Groupe();
                    for (var recu in SearchBar3.recup)
                    {
                      pe = await crudObj.RecupGroup(context, recu );
                      widget.list.add(pe);
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Rejoindre_groupe(widget.p, widget.list, widget.titre)),
                    );
                  },

                ),
              ),
              boxShape:
              NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(30)),
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                depth: 25,
                lightSource: LightSource.topLeft,


              ),
            ),
            height:38,
            width: 38,
          ),





        ],

      ),

    );







  }

}
///**************************************************************************///
