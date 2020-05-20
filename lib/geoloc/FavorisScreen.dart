
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'MapScreenDestArret.dart';

class FavorisScreen extends StatelessWidget {

  Widget getListView(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('favoris').snapshots(),
      builder: (context,snapshot){
      switch(snapshot.connectionState){
      case ConnectionState.waiting:
        return Center(child: CircularProgressIndicator()) ;
        default:
        return ListView(
        children: makeListWidget(snapshot,context),
       );
      }
    }
    );
  }

  List<Widget> makeListWidget(AsyncSnapshot snapshot, BuildContext context){
    return snapshot.data.documents.map<Widget>((document){
      return ListTile(
        title: Text(document['place']),
        trailing: Icon(Icons.more_vert),
        leading: Icon(Icons.location_on),
        onTap: () {
          addDialogDesArret(context, 'Ajouter ce lieu comme quoi?', document);
        },
        onLongPress: (){
          addDialogConfirmationSuppression(context, 'Voulez vous vraiment le supprimer des favoris', document);
        },      
      );
    }).toList();
  }
///*******************Showing a dialog desti/arret****************************///
  Future<bool> addDialogDesArret(BuildContext context, String msg, dynamic doc) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)),
        content:Text(msg),
        title: Row(
        children: const<Widget>[
        Text('Ajouter comme quoi?'),
        Icon(
        Icons.question_answer,
        color: Colors.green,
        ),
        ],
        ),
        actions: <Widget>[
        FlatButton(
          child: Text('Destination'),
          textColor: Colors.blue,
          onPressed: () {
            addDialogConfirmationDestination(context, 'Voulez vraiment ajouter ce lieu comme destination', doc);
          }
        ),
        FlatButton(
          child: Text('Arret'),
          textColor: Colors.blue,
          onPressed: () {
            addDialogConfirmationArret(context, 'Voulez vraiment ajouter ce lieu comme arret', doc);
          }
        ),
      ],
     );
    });
  }
  
///**************************Showing a dialog confirmation Destination*******************************///
  Future<bool> addDialogConfirmationDestination(BuildContext context, String msg, dynamic doc) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content:
                Text(msg),
             title: Row(
               children: const<Widget>[
                 Text('Confirmation'),
                 Icon(
                    Icons.question_answer,
                    color: Colors.green,
                 ),
               ],
             ),
            actions: <Widget>[
              FlatButton(
                  child: Text('Oui'),
                  textColor: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(                                                        
                    MaterialPageRoute(                                                                                                                    
                    builder: (context) => MyHomeDestArret(pos: doc['coords'], i:1, place: doc['place'])
                    ),
                    );
                  },
              ),
              FlatButton(
                  child: Text('Non'),
                  textColor: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }
              ),

            ],

          );
        });
  }
///************************Showing a dialog confirmation arret***********************************///
  Future<bool> addDialogConfirmationArret(BuildContext context, String msg, dynamic doc) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content:
                Text(msg),
             title: Row(
               children: const<Widget>[
                 Text('Confirmation'),
                 Icon(
                    Icons.question_answer,
                    color: Colors.green,
                 ),
               ],
             ),
            actions: <Widget>[
              FlatButton(
                  child: Text('Oui'),
                  textColor: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(                                                        
                    MaterialPageRoute(                                                                                                                    
                    builder: (context) => MyHomeDestArret(pos: doc['coords'], i:2, place: doc['place'])
                    ),
                    );
                  },
              ),
              FlatButton(
                  child: Text('Non'),
                  textColor: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }
              ),

            ],

          );
        });
  }
///*******************Showing a dialog confirmation suppression****************************///
  Future<bool> addDialogConfirmationSuppression(BuildContext context, String msg, dynamic doc) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content:
                Text(msg),
             title: Row(
               children: const<Widget>[
                 Text('Confirmation'),
                 Icon(
                    Icons.question_answer,
                    color: Colors.green,
                 ),
               ],
             ),
            actions: <Widget>[
              FlatButton(
                  child: Text('Supprimer'),
                  textColor: Colors.blue,
                  onPressed: () {
                       Firestore.instance.collection('favoris').document(doc.documentID).delete();
                       Navigator.of(context).pop();
                  }
              ),
              FlatButton(
                  child: Text('Annuler'),
                  textColor: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pop();
                  }
              ),

            ],

          );
        });
  }
  //**********************************************************************************/
 
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoris',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: getListView(context),
    );
  }
}
  


