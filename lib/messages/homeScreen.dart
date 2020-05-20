

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../ui/Palette.dart';
import '../PagePrincipale.dart';
import 'membres_groupe.dart';
import 'recent_chat.dart';
import '../noyau/Personne.dart';

class HomeScreen extends StatefulWidget {
  Personne per;
  HomeScreen({this.per});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Personne user = new Personne(userName: 'user');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.background,
        title: Text(
          'Messagerie',
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontSize: 30,
            color: Palette.violet,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
//        actions: <Widget>[
//          Container(
//            child:Icon(Icons.chat_bubble ,size: 30, ),
//            margin:EdgeInsets.only(right: 160),
//          )
//
//        ],

        leading: IconButton(
          alignment: Alignment.topLeft,
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
          color: Palette.violet,
          onPressed: () {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PagePrincipale(widget.per)),
            );
            print("retour");
          },
        ),

      ),
      body:Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                )
            ),
              child: Column(
                children: <Widget>[
                  RecentChat(user: widget.per,),
                ],
                  )
              ),
            ),
            ]
          ),
    );
  }
}
