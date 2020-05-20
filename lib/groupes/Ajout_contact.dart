

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'Invitation_groupe.dart';
import '../noyau/Groupe.dart';
import '../PagePrincipale.dart';
import '../noyau/Personne.dart';
import '../ui/SearchBar.dart';
import '../ui/Photo.dart';
import '../ui/Palette.dart';
import '../ui/customWidgets/MyButton.dart';
import 'Param_groupe.dart';
class Ajout_contact extends StatefulWidget {
  Personne personne ;
  bool invitaccept=false;
  Groupe groupe;
  List<Personne> list= new List<Personne>() ;
  String recup;
  int  page ;
  static List<Personne> select ;
  String titre ;
  Ajout_contact(this.groupe,this.personne ,this.list , this.titre , this.page);
  @override
  _Ajout_contactState createState() => _Ajout_contactState();
}

class _Ajout_contactState extends State<Ajout_contact> {
  List<String> suggestions = [];
  List <Personne> lis = new List<Personne> () ;
  void selection () {
    Ajout_contact.select =lis ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Palette.background ,
      appBar:AppBar(
        backgroundColor: Color(0xff5813ea),
        title: Text(widget.titre,
          style: TextStyle
            (
            fontFamily: 'Gilroy-ExtraBold',
            fontSize: 20,
            color: Color(0xffffffff),
          ),
          textAlign: TextAlign.left,
        ),


        leading: IconButton(
          alignment: Alignment.topLeft,
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
          color: Color(0xffe0e5ec),
          onPressed: () {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PagePrincipale(widget.personne)),
            );
            print("retour");
          },
        ),

      ),

      body: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: 40,),
          SearchBar(widget.groupe,widget.personne ,suggestions,widget.titre,widget.page),/////////////////////////////////////////////////////
          SizedBox(height: 40,),
          Container(
            padding:new EdgeInsets.only(left: 25) ,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.white.withOpacity(0.5),

            ),

                child:  StreamBuilder<QuerySnapshot> (
                stream: Firestore.instance.collection('users').snapshots(),
                builder: (context, snapshot)  {
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
                    if (!suggestions.contains(suggestion.documentID)){
                      suggestions.add(suggestion.documentID);
                    }
                  }


                  return ListView.builder(
                    ////////////////////////////////////////////////////////////////////
                    itemCount: widget.list.length,
                    //(widget.personne.groupeActif == null)? 0 : (widget.personne.groupeActif.listMembres == null) ? 0 : widget.personne.groupeActif.listMembres.length, //liste contacts  ,
                    itemBuilder: (BuildContext context, int index) {
                      print(
                          "leeeeeeeeeeeeeeeee nooommmmbrrrrreeeeeeeeeeeeeeeeeee");
                      print(widget.list.length);
                      return Row(
                        children: <Widget>[
                          SizedBox(height: 90,),
                          Photo(imageUrl: "photos/salima.jpg"),
                          Expanded(
                            child: Text(
                              widget.list[index].compte.userName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),

                              textAlign: TextAlign.center,),
                          ),
                          Expanded(child: IconButton(icon: Icon(
                            Icons.add, size: 28, color: Color(0xff10b0ec),),
                              onPressed: () {
                            if (!lis.contains(widget.list[index])) {
                              lis.add(widget
                                  .list[index]); //* Navigator.push(context,
                              //* MaterialPageRoute(builder: (context) => ));

                            }
                              }
                          )),

                        ],
                      );
                    },
                  );
                }
    ),
          ),
          SizedBox(height: 20,),
          MyButton(onPressed:(){
            selection();
            ///envoyer une invitation


            //if (!widget.groupe.existPer(Ajout_contact.select)){
              //widget.groupe.listMembres.addAll(Ajout_contact.select);//
              //addMembres(widget.groupe,Ajout_contact.select,widget.groupe.getId());//
              Ajout_contact.select.forEach((one) {
                one.listeGroupes.add(widget.groupe);
                Firestore.instance.collection('users').document(one.compte.email).collection("invitations").document(widget.groupe.id)
                  .setData({

                'groupe':(widget.groupe.id),
                'admin du groupe':(widget.groupe.adm.compte.email),
                'envoyée à':one.compte.email,
              }

              );
                /*Firestore.instance.collection('users').document(one.compte.email).collection("liste de groupe").document(widget.groupe.id)
                    .setData({
                  'Groupe':(widget.groupe.id),
                });//
*/
              });
              //Invitation_groupe(widget.personne);
           // }





            switch(widget.page ) {

            //* ici on a liste des masters qu'on va affecter au groupe qu'on a fait passé en param
            //*  cet appel sert à ajouter des autres memebres qui ne sont pas master au groupe
            //* la liste qu'on fait passer c'est la liste des contacts
              case 0 :Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Ajout_contact(widget.groupe,widget.personne,widget.list ,"liste des membres",1),
                    //*
                  ));
              break;
            //* on a ajouté la liste des contacts on à terminé , on accéde direct a la page param groupe
            //* on affiche d'abord une fenetre avec un code ( le code du groupe )
              case 1:Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Param_groupe(widget.personne,widget.personne.groupeActif),
                  ));
              break ;
            //* ici c'est le cas du voyage , je sais pas si on retourne directement à la page prinicpale
            //* le voyage il faut qu'on lui ajoute les personnes
              case 2:Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PagePrincipale(widget.personne)),
              );
              break ;
            }

          }, text:"confirmer")
        ],
      ),


    );
  }

  ///****************************************************************************************
  @override
  Future<void> addMembres(Groupe grp,List<Personne> liss,String attribut) async {

    var it = liss.iterator;
    while ( it.moveNext())
    {
      var other = it.current;
      Firestore.instance.collection('groups').document(attribut).collection('membres').document(other.getCompte().getEmail())
          .setData({
        'Email du membre':(other.getCompte().getEmail()),
      });
      /* DocumentReference usersReference;
      Firestore.instance.collection('users').document(other.getCompte().getUserName()).get()
          .then((DocumentSnapshot data){  usersReference =data.reference; //this return the DocumentReference })
      print(data.reference.toString());
      });

      Map<String, DocumentReference> userData = {
        'usersReference': usersReference,
      };
      Firestore.instance.collection('groups').document(attribut).collection('membres').add(userData).then((doc) {
        doc.setData({
          'usersReference': usersReference,
        });
      });*/

    }
  }

  ///*****************************************************************************

  void updateData(Groupe p) {
    try {

      Firestore.instance
          .collection('groups')
          .document(p.getId())
          .updateData({'description': 'Head First Flutter'});
    } catch (e) {
      print(e.toString());
    }
  }

}

