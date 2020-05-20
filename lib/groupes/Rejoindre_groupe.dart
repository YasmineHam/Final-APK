import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../ui/SearchBar3.dart';
import '../ui/size_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'CodePin.dart';
import '../noyau/Groupe.dart';
import '../PagePrincipale.dart';
import '../noyau/Personne.dart';
import '../ui/SearchBar.dart';
import '../ui/Photo.dart';
import '../ui/Palette.dart';
import '../ui/customWidgets/MyButton.dart';
import 'Param_groupe.dart';

class Rejoindre_groupe extends StatefulWidget {
  Personne personne;

  Groupe groupe;
  List<Groupe> list = new List<Groupe>();

  int page;

  static List<Groupe> select;

  String titre;

  Rejoindre_groupe(this.personne, this.list, this.titre);

  @override
  _Rejoindre_groupeState createState() => _Rejoindre_groupeState();
}

class _Rejoindre_groupeState extends State<Rejoindre_groupe> {
  List<String> suggestions = [
    "sofia_o_grp",
  ];
  List<Groupe> lis = new List<Groupe>();

  void selection() {
    Rejoindre_groupe.select = lis;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(displayHeight(context) * 0.082),
        child: AppBar(
          backgroundColor: Palette.background,
          title: Text(
            widget.titre,
            style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 26,
                color: Palette.violet),
          ),
          centerTitle: true,
          elevation: 0.0,
          iconTheme: IconThemeData(opacity: 1,size: 39,color: Palette.violet),
        ),
      ),
      body: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            SearchBar3( widget.personne, suggestions, widget.titre ),
            //SearchBar(widget.personne, suggestions),///////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////
            SizedBox(
              height: displayHeight(context)*0.05,
            ),
            Container(
              padding: new EdgeInsets.only(left: 25),
              height: displayHeight(context)*0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white.withOpacity(0.5),
              ),

                  child:  StreamBuilder<QuerySnapshot> (
                  stream: Firestore.instance.collection('groups').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      )
                      );
                    }
                    final suggests = snapshot.data.documents.reversed;
                    if (suggests.isEmpty) {
                      return Center(
                        child: Text('Aucune suggestion à afficher.'),
                      );
                    }
                    List<String> sugges = [];
                    for (var suggestion in suggests) {
                      if (!suggestions.contains(suggestion.documentID)) {
                        suggestions.add(suggestion.documentID);
                      }
                    }
                    return ListView.builder(
                      ////////////////////////////////////////////////////////////////////
                      itemCount: widget.list.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(
                            "leeeeeeeeeeeeeeeee nooommmmbrrrrreeeeeeeeeeeeeeeeeee");
                        print(widget.list.length);
                        return Row(
                          children: <Widget>[
                            SizedBox(
                              height: 90,
                            ),
                            Photo(imageUrl: "photos/salima.jpg"),
                            Expanded(
                              child: Text(
                                (widget.list[index].id == null)
                                    ? ""
                                    : widget.list[index].id,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                                child: IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      size: 28,
                                      color: Color(0xff10b0ec),
                                    ),
                                    onPressed: () {
                                      if (!lis.contains(widget.list[index])) {
                                        lis.add(widget
                                            .list[index]);
                                        if (!widget.personne.listeGroupes.contains(widget.list[index]))
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => CodePin(widget.list[index],widget.personne)),
                                            );
                                          }
                                        else
                                          {
                                            ShowToast('vous faites déjà partie de ce groupe');
                                          }
                                      }

                                    })),
                          ],
                        );
                      },
                    );
                  }
            ),
            ),
          ]),
    );
  }
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
