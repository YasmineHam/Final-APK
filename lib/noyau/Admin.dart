import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

import 'Personne.dart';
import 'Compte.dart';
import 'Groupe.dart';


class Admin extends Personne{

  Admin ({String userName,String passWord,String numTel,String email,Groupe groupeActif,double vitesse,GeoPoint position,double distance  , String token})
      : super(userName: userName, passWord: passWord,numTel: numTel,email :email ,groupeActif:groupeActif,vitesse:vitesse,position:position,distance:distance ,token:token );




  void supprimerMembre(Personne p){

  }
  void supprimerGroupe(Groupe g){

  }


}