import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../noyau/Personne.dart';
import 'package:intl/intl.dart';

class Iconnes extends StatelessWidget {

  final Icon iconne ;
  final Color couleur ;
  final String msg;
  final Personne user;

  Iconnes({@required this.iconne , @required this.couleur,@required this.user,@required this.msg});

  @override
  Widget build(BuildContext context) {
    return

      Container(
        margin: new EdgeInsets.only(top: 50),

        child: Neumorphic(
          boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(100)),
          style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            depth: 20,
            lightSource: LightSource.topLeft,
            //*  color: Colors.grey
          ),

          child:Center(
            child: IconButton(
              onPressed: ()
              {
                addMessages(this.user.groupeActif.id, this.user.compte.userName, this.msg);
                print("hello"); //* ici pour envoyer juste
                print(this.user.groupeActif.id);
              },
              icon: iconne,
              color: couleur ,

            ),
          ) ,
        ),
        height:40,
        width: 40,

      );


  }
  ///**********************************Envoyer message**********************///
  Future<void> addMessages(String grp, String username, String msg) async {
    {
      bool unread;
      String currentname = this.user.compte.userName;

      if (username== this.user.compte.userName){
        unread = false;}
      else {unread=true;}
      DateTime now = DateTime.now();
      String time = DateTime.now().toLocal().toString();
      print(time);
      String formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(now);
      String formattedDate2 = DateFormat('dd-MM-yyyy \nHH:mm').format(now);
      Firestore.instance.collection('groups').document(grp)
          .collection('messages').document(time).setData({
        'auteur': username,
        'time': formattedDate,
        'message': msg,
        'unread': unread,

      }).catchError((e) {
        print(e);
      });
      Firestore.instance.collection('groups').document(grp).updateData({
        'lastMsg': msg,
        'timeLast': formattedDate2,
        'unread': unread,

      }).catchError((e) {
        print(e);
      });
    }
  }
}