import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../noyau/Personne.dart';
import 'message_model.dart';
import '../groupes/crud.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import '../noyau/Groupe.dart';


class BoiteReception extends StatefulWidget {
  final String codeGrp;
  final Personne user;
  final Groupe grp;

  BoiteReception({this.grp,this.codeGrp,this.user});

  @override
  _BoiteReceptionState createState() => _BoiteReceptionState();
}

class _BoiteReceptionState extends State<BoiteReception> {
   String sendMsg;
  bool unread = true;
  bool isMe;
  Firestore _firestore = Firestore.instance;
   final focus = FocusNode();


   _buildMessage(Message message, bool isMe) {
    return Container(
      margin: isMe ?
      EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
          : EdgeInsets.only(top: 8.0, bottom: 8.0, right: 80.0),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      decoration: BoxDecoration(
        color: isMe ? Colors.indigo[100] : Colors.grey [200],
        borderRadius: isMe
            ? BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0)
        )
            : BorderRadius.only(
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                message.username,
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 16.0,
                ),
              ),
              Text(
                message.dateEnvoi,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0,),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      message.text,
                      style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
            ),
                  ),

                ],
              ),


        ],
      ),
    );
  }

  _buildMessageComposer() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yy-MM-dd HH:mm a').format(now);
    return Container(
          height: 70.0,
          color: Colors.white,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 10.0),
            scrollDirection: Axis.horizontal,
            itemCount: 1,
            itemBuilder: (BuildContext contextn, int index){
              return GestureDetector(
                onTap:() => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_)=> BoiteReception(
                          grp: widget.grp,)
                    )
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Neumorphic(
                          child: Center(
                            child: IconButton(
                              onPressed: () async{
                                await addMessages(widget.grp.code, widget.user.compte.userName,
                                    'Ma batterie est faible !');},
                              icon: Icon(Icons.battery_alert,
                                  size: 35, color: Color(0xffef883e)),
                              //backgroundColor: Color(0xffff7272),

                        ),
                          ),
                        boxShape: NeumorphicBoxShape.circle(
                           // borderRadius: BorderRadius.circular(100)
                        ),
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.convex,
                          depth: 24,
                          lightSource: LightSource.topLeft,
                          color: Color(0xffffffff).withOpacity(0.5),
                          //*color: Color(0xffff7272),
                        ),
                      ),
                      ///RESEAU
                      SizedBox(height: 6.0),
                      Neumorphic(
                        child: Center(
                         child: IconButton(
                              onPressed: ()async
                              {await addMessages(widget.grp.code,widget.user.compte.userName,
                                  'J\'ai des problèmes de réseau');
                            },
                            icon: Icon(Icons.signal_cellular_off,
                                size: 25,
                                color: Color(0xffff7272)),
                            //backgroundColor: Color(0xffff7272),

                          ),
                        ),
                        boxShape: NeumorphicBoxShape.circle(
                          // borderRadius: BorderRadius.circular(100)
                        ),
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.convex,
                          depth: 24,
                          lightSource: LightSource.topLeft,
                          color: Color(0xffffffff).withOpacity(0.5),
                        ),
                      ),
                      SizedBox(height: 6.0),
                      ///Radar
                      Neumorphic(
                        child: Center(
                          child: IconButton(
                            onPressed: () async
                            {await addMessages(widget.grp.code, widget.user.getUser(),
                                'Attention radar dans les alentours !');},
                            icon: Icon(FontAwesomeIcons.broadcastTower,
                                size: 25,
                                color: Color(0xff4f00f2)),
                          ),
                        ),
                        boxShape: NeumorphicBoxShape.circle(
                          // borderRadius: BorderRadius.circular(100)
                        ),
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.convex,
                          depth: 24,
                          lightSource: LightSource.topLeft,
                          color: Color(0xffffffff).withOpacity(0.5),
                        ),
                      ),
                      SizedBox(height: 6.0),
                      ///police
                      Neumorphic(
                        child: Center(
                          child: IconButton(
                            onPressed: ()async{await addMessages(widget.grp.code,
                                widget.user.getUser(), 'Attention barage !');},
                            icon: Icon(FontAwesomeIcons.userSecret,
                                size: 25,
                                color: Color(0xff3cbbeb)),
                          ),
                        ),
                        boxShape: NeumorphicBoxShape.circle(
                          // borderRadius: BorderRadius.circular(100)
                        ),
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.convex,
                          depth: 24,
                          lightSource: LightSource.topLeft,
                          color: Color(0xffffffff).withOpacity(0.5),
                        ),
                      ),
                      SizedBox(height: 6.0),
                      ///Accident
                      Neumorphic(
                        child: Center(
                          child: IconButton(
                            onPressed: ()async{await addMessages(widget.grp.code, widget.user.getUser(),
                                'Accident dans les parages');},
                            icon: Icon(FontAwesomeIcons.carCrash,
                                size: 25,
                                color: Color(0xff6d7587)),
                          ),
                        ),
                        boxShape: NeumorphicBoxShape.circle(
                          // borderRadius: BorderRadius.circular(100)
                        ),
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.convex,
                          depth: 24,
                          lightSource: LightSource.topLeft,
                          color: Color(0xffffffff).withOpacity(0.5),
                        ),
                      ),///Travaux
                      Neumorphic(
                        child: Center(
                          child: IconButton(
                            onPressed: ()async{await addMessages(widget.grp.code, widget.user.getUser(),
                                'Attention travaux !');},
                            icon: Icon(FontAwesomeIcons. exclamationTriangle,
                                size: 25,
                                color: Colors.red),
                          ),
                        ),
                        boxShape: NeumorphicBoxShape.circle(
                          // borderRadius: BorderRadius.circular(100)
                        ),
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.convex,
                          depth: 24,
                          lightSource: LightSource.topLeft,
                          color: Color(0xffffffff).withOpacity(0.5),
                        ),
                      ),
                      ///Station de service
                      Neumorphic(
                        child: Center(
                          child: IconButton(
                            onPressed: ()async{await addMessages(widget.grp.code,
                                widget.user.getUser(), 'Station de service');},
                            icon: Icon(FontAwesomeIcons.gasPump,
                                color: Color(0xffef883e),
                                size:25),
                          ),
                        ),
                        boxShape: NeumorphicBoxShape.circle(
                          // borderRadius: BorderRadius.circular(100)
                        ),
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.convex,
                          depth: 24,
                          lightSource: LightSource.topLeft,
                          color: Color(0xffffffff).withOpacity(0.5),
                        ),
                      ),
                      SizedBox(height: 6.0),
                      ///Pause
                      Neumorphic(
                        child: Center(
                          child: IconButton(
                            onPressed: ()async{await addMessages(widget.grp.code,
                                widget.user.getUser(), 'On fait une pause ?');},

                            icon: Icon(FontAwesomeIcons.stopwatch,
                                color: Color(0xff4f00f2),
                                size:25),
                          ),
                        ),
                        boxShape: NeumorphicBoxShape.circle(
                          // borderRadius: BorderRadius.circular(100)
                        ),
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.convex,
                          depth: 24,
                          lightSource: LightSource.topLeft,
                          color: Color(0xffffffff).withOpacity(0.5),
                        ),
                      ),
                      SizedBox(height: 6.0),
                      ///RouteGlissante
                      Neumorphic(
                        child: Center(
                          child: IconButton(
                            onPressed: ()async{await addMessages(widget.grp.code, widget.user.getUser(),
                                'Attention route glissante');},
                            icon: Icon(FontAwesomeIcons.road,
                                size: 25,
                                color: Color(0xff6d7587)),
                          ),
                        ),
                        boxShape: NeumorphicBoxShape.circle(
                          // borderRadius: BorderRadius.circular(100)
                        ),
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.convex,
                          depth: 24,
                          lightSource: LightSource.topLeft,
                          color: Color(0xffffffff).withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },

          )
      );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xff4f00f2),
      appBar: AppBar(
        title: Text(widget.grp.id,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),),
        centerTitle: true,
        backgroundColor: Color(0xff4f00f2),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance.collection("groups").document(widget.grp.code)
                          .collection('messages').snapshots(), //recuperer les données du stream
                      builder: (context,snapshot){
                        if(!snapshot.hasData){
                            return Center(child:CircularProgressIndicator(
                            backgroundColor: Colors.lightBlueAccent ,
                            )
                              );
                        }
                        final messages = snapshot.data.documents.reversed;
                        if (messages.isEmpty){
                          return Center(child: Text('Aucun message à afficher.',));
                        }
                        List<Message> messagesChat = [];
                        for(var msg in messages ){
                                final auteur = msg.data['auteur'];
                                final time = msg.data['time'];
                                final message = msg.data['message'];
                                messagesChat.add(
                                  Message(
                                    username: auteur,
                                    dateEnvoi: time,
                                    text: message,
                                    unread: true,
                                  )

                                );
                            messagesChat=messagesChat.toSet().toList();
                            }
                                  return  ListView.builder(
                                    reverse: true,
                                    padding: EdgeInsets.only(top: 15.0),
                                    itemCount: messagesChat.length ,
                                    itemBuilder: (BuildContext context, int index ){
                                    final message = messagesChat[index];
                                     isMe = message.username == widget.user.getUser();
                                     return _buildMessage(message,isMe);
                                 },
                              );
                            }

                            )

                  ),

                )
            ),
          _buildMessageComposer(),
          Container(
            color: Colors.white,

              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 0.0, 0.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: TextFormField(
                          onChanged: (String val) {
                            sendMsg = val;
                            print("msg : $sendMsg");
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nouveau message'
                          ),

                          textInputAction: TextInputAction.next,
                          autofocus: true,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).requestFocus(focus);
                          },

                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      color: Color(0xff4f00f2),
                      onPressed: (){
                        if(!sendMsg.isEmpty){
                          print(widget.grp.code);
                          print("widget.grp.code");
                          addMessages(widget.grp.code, widget.user.compte.userName, sendMsg);

                        }
                      },
                    )

                  ],
                ),
              ),

            ),
        ],
      ),
    );
  }

  ///***************************Envoyer un message****************************///
  Future<void> addMessages(String grp, String username, String msg) async {
    {
      bool unread;
      String currentname = widget.user.compte.userName;

      if (username==widget.user.compte.userName){
         unread = false;}
      else {unread=true;}
      DateTime now = DateTime.now();
      String time = DateTime.now().toLocal().toString();
      print(time);
      String formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(now);
      String formattedDate2 = DateFormat('dd-MM-yyyy \nHH:mm').format(now);
      _firestore.collection('groups').document(grp)
          .collection('messages').document(time).setData({
        'auteur': username,
        'time': formattedDate,
        'message': msg,
        'unread': unread,

      }).catchError((e) {
        print(e);
      });
      _firestore.collection('groups').document(grp).updateData({
        'lastMsg': msg,
        'timeLast': formattedDate2,
        'unread': unread,

      }).catchError((e) {
        print(e);
      });
    }
   }

}