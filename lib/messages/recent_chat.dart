import 'package:flutter/material.dart';
import '../ui/image_pic4.dart';
import 'Boite_rec.dart';
import '../noyau/Groupe.dart';
import 'message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../groupes/crud.dart';
import '../noyau/Personne.dart';
import '../ui/image_pic2.dart';



class RecentChat extends StatefulWidget {
  Personne user;
  RecentChat({this.user});

  @override
  _RecentChatState createState() => _RecentChatState();
}

class _RecentChatState extends State<RecentChat> {
   bddMethods crudObj = new bddMethods();
  Firestore _firestore = Firestore.instance;
   List res = new List<String>();

   @override
  Widget build(BuildContext context) {
     return Expanded(
      child: Container(
        decoration:BoxDecoration(color: Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            )
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection("groups").snapshots(),
              builder: (context,snapshot) {
                if(!snapshot.hasData){
                  return Center(child:CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent ,
                  )
                  );
                }

                final groupes = snapshot.data.documents.reversed;
                if (groupes.isEmpty){
                  return Center(child: Text('Aucun message à afficher.',));
                }
                //widget.user.Listegroupe= {'groupe1','groupe2'}.toList();

                if (widget.user.Listegroupe.isEmpty) {
                  return Center(child: Text('Aucun message à afficher.',));
                }

                else{
                List<Groupe> Groupes = [];
                for (String codeGrp in res) {
                  print('recupere');
                  print(codeGrp);
                }
                for(var groupe in groupes ) {
                  if (widget.user.Listegroupe.contains(groupe.documentID)) {
                    print('--------------------------___--_-_-_-_-_-_-');
                   final nomGroupe = groupe.documentID;
                    final codeGroupe = groupe.data['code'];
                    final lastMsg = (groupe.data["lastMsg"] == null)
                        ? 'Aucun message à afficher.'
                        : groupe.data["lastMsg"];
                    print('lastMsg');
                    print(lastMsg);
                    final unreadMsg = groupe.data['unread'];
                    final time = (groupe.data["timeLast"] == null)
                        ? "----\n--:--"
                        : groupe.data["timeLast"];

                    Groupes.add(
                        Groupe(
                          id: nomGroupe,
                          code: codeGroupe,
                          lastMsg: lastMsg,
                          unread: unreadMsg,
                          time: time,
                        )

                    );
                  }
                  Groupes = Groupes.toSet().toList();

                  }
                  return ListView.builder(
                    itemCount: Groupes.length,
                    itemBuilder: (BuildContext context, int index) {
                      final group = Groupes[index];
                      print(
                          '----------------------------------------------------');
                      print('groups/' + group.code);
                      return GestureDetector(
                        onTap: () {
                          group.setUnread();
                          setRead(group.code);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      BoiteReception(
                                          grp: group,
                                          user: widget.user,
                                          codeGrp: group.code)
                              ));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 5.0, bottom: 5.0, right: 20.0),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          decoration: BoxDecoration(
                              color: group.getUnread()
                                  ? Color(0xFFF3E5F5)
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              )
                          ),

                          child: Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  /*CircleAvatar(radius: 35.0,
                                  backgroundImage: AssetImage(salima.photo),
                                ),*/
                                  Image_pic4(widget.user.listeGroupes[index].id, false),
                                  SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Text(
                                        group.id,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.45,
                                        child: Text(
                                          group.getlastMsg(),
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    group.getTime(),
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  group.getUnread() ? Container(
                                    width: 70.0,
                                    height: 30.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xff4f00f2),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'NOUVEAU',
                                      style: TextStyle(color: Colors.white,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ) : Text(''),
                                ],

                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }
          ),
        ) ,
      ),
    );
  }

  ///*************************************************************************//
  Future updateUnread(String grp) async {
    _firestore.collection('groups').document(grp).collection('messages')
        .document().updateData({
      'unread': true,
    }).catchError((e) {
      print(e);
    });
  }

  ///***************************Get Last message time*****************************///
  setRead(String codeGrp) async {
    String lastMsgTime;
    _firestore.collection('groups').document(codeGrp).updateData({
      'unread' : false,
    }).catchError((e){
      print(e);
    });

  }

  ///***************************Get Last message time*****************************///
  getLastMsgTime(String codeGrp) async {
    String lastMsgTime;
    var document = _firestore.collection('group').document(codeGrp);
    await document.get().then((document) {
      lastMsgTime = document['timeLast'];
      print('TIMEE');
      print(lastMsgTime);
    });
    return lastMsgTime;
  }
}

