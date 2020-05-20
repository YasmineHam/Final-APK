import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geoloc/ui/Image_pic.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../ui/Palette.dart';
import '../ui/image_pic4.dart';
import '../ui/size_screen.dart';

import 'Affich_Code.dart';
import '../messages/Boite_rec.dart';
import '../ui/Photo.dart';
import '../ui/SearchBar.dart';
import '../noyau/Personne.dart';
import '../PagePrincipale.dart';
import 'Param_groupe.dart';
class Groupes_page extends StatefulWidget {
  Personne user ;
  Groupes_page(this.user);
  @override
  _Groupes_pageState createState() => _Groupes_pageState();
}

class _Groupes_pageState extends State<Groupes_page> {
  List<String> suggestions = [
    "Apple",
    "Armidillo",
    "Actual",
    "Actuary",
    "America",


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe0e5ec) ,
      appBar:PreferredSize(
      preferredSize: Size.fromHeight(
      displayHeight(context) * 0.082,
      ),
      child:  AppBar(
        backgroundColor: Palette.background,
    elevation: 0.0,

    title: Text(
          "Groupes",
          style: TextStyle(fontWeight:FontWeight.bold ,fontSize: 30,fontFamily: 'Gilroy',color: Palette.violet),


    textAlign: TextAlign.center,),
        centerTitle: true,
        actions: <Widget>[
          Container(
            child:Icon(Icons.group ,size: 30,color: Palette.violet ),
            margin:EdgeInsets.only(right: 160),
          )

        ],
    iconTheme: IconThemeData(color: Palette.violet,size: 40),

    /*leading: IconButton(
          alignment: Alignment.topLeft,
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
          color: Color(0xffe0e5ec),
          onPressed: () {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PagePrincipale(widget.user)),
            );
            print("retour");
          },
        ),*/
      ),

      ),

      body:ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: 40,),
          //SearchBar(widget.user ,suggestions),///////////////////////////////////////////////////////////////////////////////////////////////////////////
          SizedBox(height: 40,),
          Container(
            padding:new EdgeInsets.only(left: 25) ,
            height: 600,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.white.withOpacity(0.5),

            ),

            child: ListView.builder(

              itemCount: widget.user.listeGroupes.length,
              itemBuilder: (BuildContext context ,int index) {
                return new Row(
                  children: <Widget>[
                    SizedBox(height: 90,),
                    //Photo(imageUrl: "photos/salima.jpg"),
                    Image_pic4(widget.user.listeGroupes[index].id, false),
                    Expanded(
                      child: Text(
                        ((widget.user.listeGroupes[index].id)!= null)? widget.user.listeGroupes[index].id : "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),

                        textAlign: TextAlign.center,),
                    ),
                    Expanded(child: IconButton(icon: Icon(
                      Icons.photo, size: 28, color: Color(0xff10b0ec),),
                        onPressed:(){ Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>Image_pic(widget.user.listeGroupes[index].id, false, widget.user), ));
                        }
                    )),
                    Expanded(child: IconButton(icon: Icon(Icons.vpn_key,size: 28,color: Color(0xff10b0ec),),
                        onPressed: () {
                          ///////////////////////////////// la page qui donne le code/////////////////////////////
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Affich_Code(widget.user.listeGroupes[index],widget.user)));
                        }),
                    ),
                    Expanded(child: IconButton(icon: Icon(Icons.settings,size: 28,color: Color(0xff10b0ec),), onPressed:
                        (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>Param_groupe(widget.user, widget.user.listeGroupes[index]) ));
                    }),
                    ),

                  ],
                );
              },
            ),
          ),

        ],
      ),

    );
  }
}
