import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../ui/size_screen.dart';

import '../ui/Photo.dart';
import '../ui/SearchBar.dart';
import '../noyau/Personne.dart';
import '../noyau/Groupe.dart';
import 'Groupes_page.dart';
import '../ui/Palette.dart';
import '../PagePrincipale.dart';
import 'crud.dart';
class Invitation_groupe extends StatefulWidget {
  final String title ='Invitation Groupe';
  Personne p ;
  String group_id;
  int cpt;

  Invitation_groupe(this.p,this.group_id);
  @override
  _Invitation_groupeState createState() => _Invitation_groupeState();
}

class _Invitation_groupeState extends State<Invitation_groupe> {
  static const _popItem = <String>["Accepter", "decliner"];

  static List<PopupMenuItem<String>> pop = _popItem
      .map((String val) => PopupMenuItem<String>(
    value: val,
    child: Text(val),
  ))
      .toList();
  String value;

/*

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _getToken() {
    _firebaseMessaging.getToken().then((token) {
      print("Device Token: $token");
    });
  }
  List<Message> messagesList= new List<Message>();



  _configureFirebaseListeners() {
    _firebaseMessaging.configure(
      onMessage:
//          (Map<String, dynamic> message) async {
//        print('onMessage: $message');
//        _setMessage(message);
//      },
            (Map<String, dynamic> message) async {
        print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
        print('onMessage: $message');
        final notification = message['notification'];
        final data = message['data'];
        widget.group_id= data['group'];
        //_setMessage(message);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text( 'new message arived'),
                content: Text('i want ${message['data']['push_key']} for ${message['data']['key1']}'),
                actions: <Widget>[

                  FlatButton(
                    child: Text('Visulaiser la notification'),
                    onPressed: () {
                      print("hhhhhhhhhhhhhhhhhhheeeeeeeeeeeeeeeyyyyyyyyyyyyyyyyyyyyyyyyy");
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        _setMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        _setMessage(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }

  _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    widget.group_id= data['group'];
    String mMessage = data['key1'];
    print("Title: $title, body: $body, message: $mMessage");
    setState(() {
      Message msg = Message(title, body, mMessage);
      messagesList.add(msg);
    });
  }

  @override
  Future<void> initState ()  {
    super.initState();
    messagesList= List<Message>();
    // _getToken();
    _configureFirebaseListeners();
    print('coucouuuuuuu');
  }
*/

  bddMethods crudObj = bddMethods();

  @override
  Widget build(BuildContext context) {
    Firestore.instance.collection('users').document(widget.p.compte.email).collection('invitations').getDocuments().then((res) {
      widget.cpt=res.documentChanges.length;
    });
    print("lololololololololololololol");
    print (widget.cpt);

    return Scaffold(
      backgroundColor: Palette.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          displayHeight(context) * 0.082,
        ),
        child: AppBar(
          backgroundColor: Palette.background,
          centerTitle: true,
          titleSpacing: 0,
          elevation: 0.0,
          title: Text(
            "Invitation groupes",
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 25,
              color: Palette.violet,
            ),
            textAlign: TextAlign.left,
          ),
          iconTheme: IconThemeData(color: Palette.violet, size: 30),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount:1,// widget.cpt,////////////////////////////////////////////////////////////////////////////////////////////////////
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(top: 20),
            height: displayHeight(context)*0.3,
            width: displayWidth(context)*0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(33),
              ),
              color: Color(0xffffffff).withOpacity(0.5),
            ),

            child: new Column(

              children: <Widget>[
                Container(


                  child: ListTile(
                    title: Text((widget.group_id==null)? "hello":widget.group_id,
                      style: TextStyle
                        (
                        fontFamily: 'Gilroy-ExtraBold',
                        fontSize: 18,

                        color: Palette.bleu,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    trailing: PopupMenuButton(
                      onSelected: (String val) async {
                        value = val;
                        switch(value){
                          case "Accepter":
                            ///subscribe to topic////////////////////////////////////////////////////////////
                            FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
                            Firestore.instance.collection('groups').document(widget.group_id).collection('membres').document(widget.p.compte.email)
                                .setData({
                              'Email du membre':(widget.p.compte.email),
                            });
                            Firestore.instance.collection('users').document(widget.p.compte.email).collection("liste de groupe").document(widget.group_id)
                                .setData({
                              'Groupe':(widget.group_id),
                            });
                            Groupe grp = await crudObj.RecupGroup(context, widget.group_id);
                            grp.listMembres.add(widget.p);
                            widget.p.listeGroupes.add(grp);
                            firebaseMessaging.subscribeToTopic(widget.group_id);
                            break;
                          case "Decliner":
                            Firestore.instance.collection('users').document(widget.p.compte.email).collection("invitations").document(widget.group_id)
                                .delete();

                        }
                      },
                      itemBuilder:(BuildContext context) => pop,
                        icon: Icon(Icons.more_vert,size: 30,color: Color(0xFF4f00f2))
                    ),
                  ),
                  margin: EdgeInsets.only(left: 0),
                ),
/*                Container(
                  height: 150,
                  width: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.p.listeGroupes[index].listMembres.length,
                    itemBuilder: (BuildContext context, int index2) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(

                        ),

                        child: Column(
                          children: <Widget>[

//                            Photo(imageUrl: widget.p.listeGroupes[index]
//                                .listMembres[index2].photo),
                            Text(widget.p.listeGroupes[index].listMembres[index2]
                                .compte.userName,

                              style: TextStyle
                                (
                                fontFamily: 'Gilroy-ExtraBold',
                                fontSize: 12,
                                color: Color(0xffef883e),

                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text("Tel :",
                              style: TextStyle
                                (
                                fontFamily: 'Gilroy-Light',
                                fontSize: 12,
                                color: Color(0xff6D7587),
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(widget.p.listeGroupes[index].listMembres[index2]
                                .compte.numTel,
                              style: TextStyle
                                (
                                fontFamily: 'Gilroy-Light',
                                fontSize: 12,
                                color: Color(0xff6D7587),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),*/

              ],
            ),
          );
        },
      ),
    );
  }

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      body: ListView.builder(
//        itemCount: null == messagesList ? 0 : messagesList.length,
//        itemBuilder: (BuildContext context, int index) {
//          print('coucouuuuuuu');
//          print(messagesList.length);
//          return Card(
//            child: Padding(
//              padding: EdgeInsets.all(10.0),
//              child: Text(
//                (messagesList[index].message==null)?"":messagesList[index].message,
//                style: TextStyle(
//                  fontSize: 16.0,
//                  color: Colors.black,
//                ),
//              ),
//            ),
//          );
//        },
//      ),
//    );
//  }


}
class Message {
  String title;
  String body;
  String message;
  Message(title, body, message) {
    this.title = title;
    this.body = body;
    this.message = message;
  }
}




















//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Palette.background,
//      appBar: AppBar(
//        backgroundColor: Palette.violet,
//        centerTitle: true,
//
//        title: Text("Invitation groupes",
//          style: TextStyle
//            (
//            fontFamily: 'Gilroy-ExtraBold',
//            fontSize: 20,
//            color: Color(0xffffffff),
//          ),
//          textAlign: TextAlign.left,
//        ),
//
//      ),
//      body: ListView.builder(
//        scrollDirection: Axis.vertical,
//        itemCount: widget.p.listeGroupes.length,
//        itemBuilder: (BuildContext context, int index) {
//          return Container(
//            margin: EdgeInsets.only(top: 20),
//            height:220 ,
//            width: 200,
//            decoration: BoxDecoration(
//              borderRadius: BorderRadius.all(Radius.circular(33),
//              ),
//              color: Color(0xffffffff).withOpacity(0.5),
//            ),
//
//            child: new Column(
//
//              children: <Widget>[
//                Container(
//
//
//                  child: ListTile(
//                    title: Text(widget.p.listeGroupes[index].id,
//                      style: TextStyle
//                        (
//                        fontFamily: 'Gilroy-ExtraBold',
//                        fontSize: 25,
//
//                        color: Palette.bleu,
//                      ),
//                      textAlign: TextAlign.center,
//                    ),
//                    trailing: PopupMenuButton(
//                      onSelected: (String val){
//                        value = val;
//                        switch(value){
//                          case "Accepter":
//                          /**
//                           * Ici on appelle la methode qui defini l'endroit selectionné comme destination.
//                           */
//                            print("destionation");
//                            break;
//                          case "Decliner":
//
//
//                        }
//                      },
//                      itemBuilder:(BuildContext context) => pop,
//                      //  icon: Icon(Icons.more_vert,size: 30)
//                    ),
//                  ),
//                  margin: EdgeInsets.only(left: 0),
//                ),
//                Container(
//                  height: 150,
//                  width: 200,
//                  child: ListView.builder(
//                    scrollDirection: Axis.horizontal,
//                    itemCount: widget.p.listeGroupes[index].listMembres.length,
//                    itemBuilder: (BuildContext context, int index2) {
//                      return Container(
//                        margin: EdgeInsets.all(10),
//                        padding: EdgeInsets.only(top: 5),
//                        decoration: BoxDecoration(
//
//                        ),
//
//                        child: Column(
//                          children: <Widget>[
//
////                            Photo(imageUrl: widget.p.listeGroupes[index]
////                                .listMembres[index2].photo),
//                            Text(widget.p.listeGroupes[index].listMembres[index2]
//                                .compte.userName,
//
//                              style: TextStyle
//                                (
//                                fontFamily: 'Gilroy-ExtraBold',
//                                fontSize: 12,
//                                color: Color(0xffef883e),
//
//                              ),
//                              textAlign: TextAlign.center,
//                            ),
//                            Text("Tel :",
//                              style: TextStyle
//                                (
//                                fontFamily: 'Gilroy-Light',
//                                fontSize: 12,
//                                color: Color(0xff6D7587),
//                              ),
//                              textAlign: TextAlign.left,
//                            ),
//                            Text(widget.p.listeGroupes[index].listMembres[index2]
//                                .compte.numTel,
//                              style: TextStyle
//                                (
//                                fontFamily: 'Gilroy-Light',
//                                fontSize: 12,
//                                color: Color(0xff6D7587),
//                              ),
//                              textAlign: TextAlign.left,
//                            ),
//                          ],
//                        ),
//                      );
//                    },
//                  ),
//                ),
//
//              ],
//            ),
//          );
//        },
//      ),
//    );
 // }
//}
