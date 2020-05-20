
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'Arret.dart';
import 'package:random_string/random_string.dart';
import 'Admin.dart';
import 'Messages.dart';
import 'dart:io';
import 'Compte.dart';
import 'Groupe.dart';
import 'Message.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'Favoris.dart';


class Personne {

  Compte _compte;
  List<String> _lieuxVisites;
  List<Groupe> _listeGroupes;
  List<String> _listegroupe;

  String get connex => _connex;

  set connex(String value) {
    _connex = value;
  }

  Groupe _groupeActif;
  double _vitesse;
  List<Favoris> _favoris;
  String _connex;
  String _battery;


  List<Favoris> get favoris => _favoris;
  set favoris(List<Favoris> value) {
    _favoris = value;
  }
  List<String> get Listegroupe => _listegroupe;
  set Listegroupe(List<String> value) {
    _listegroupe = value;
  }

  bool get locationShare => _locationShare;


  String get battery => _battery;

  set battery(String value) {
    _battery = value;
  }

  set locationShare(bool value) {
    _locationShare = value;
  }

  GeoPoint _position;

  Compte get compte => _compte;
  bool _locationShare ;


  List<String> _lieuxRecherches;




  List<String> get lieuxRecherches => _lieuxRecherches;

  set lieuxRecherches(List<String> value) {
    _lieuxRecherches = value;
  }

  void setUser (String s)
  {
    _compte.setuserName(s);
  }
  Groupe getGroupActif ()
  {
    return _groupeActif;
  }

  set compte(Compte value) {
    _compte = value;
  }

  double _distance;
  String _photo ;
  Personne ({String userName,String passWord,String numTel,Groupe groupeActif,double vitesse,GeoPoint position,double distance,List<String> lieuxVisites,List<Groupe> listeGroupes ,
    String email , String token})
  {
    this._compte= new Compte (userName: userName,passWord: passWord,email: email , numTel:numTel);
    this._groupeActif=groupeActif;
    this._position=position;
    this._vitesse=vitesse;
    this._lieuxVisites= new List<String>();
    this._listeGroupes= new List<Groupe>();

  }


  @override
  String toString()
  {
    String s;
    s = 'username : ${_compte.getUserName()} phone number : ${_compte.getemail()} liste des groupe : ${_listeGroupes}';
    return s;
  }

  void setPosition (GeoPoint p)
  {
    _position=p;
  }
  void setDistance (double d)
  {
    _distance=d;
  }

  void setVitesse (double v)
  {
    _vitesse=v;
  }
  void setGroupeActif (Groupe g)
  {
    _groupeActif=g;
  }

  void setLieuxVisites (List<String> l)
  {
    _lieuxVisites=l;
  }

  double get distance => _distance;

  set distance(double value) {
    _distance = value;
  }

  void setListeGroupes (List<Groupe> g)
  {
    _listeGroupes=g;
  }




  void afficher ()
  {
    print(this);
  }

  String getUser()
  {
    return _compte.getUserName();
  }


  double getVitesse()
  {
    return _vitesse;
  }

  double getDistance()
  {
    return _distance;
  }

  GeoPoint getPosition()
  {
    return _position;
  }
  void setCompte (Compte cmpt)
  {
    _compte=cmpt;
  }
  Compte getCompte ()
  {
    return _compte;
  }


  void rejoindreGroupe(String code, List<Groupe> groupes)
  {
    Groupe grpp;
    bool stop = false;
    var it = groupes.iterator;
    while (it.moveNext() && stop == false)
    {
      if ( it.current.getCode()== code)
      {
        grpp  =it.current;
        stop = true;
      }
    }

    if (!groupes.contains(grpp)) print('le groupe que vous essayez de rejoindre n''existe pas, veuillez réessayer avec un autre code' );
    else
    {
      print(grpp);
      _listeGroupes.add(grpp);
      grpp.ajouterDemande(this);
      print('votre demande a été envoyée');
      // grpp.confirmerDemande(this);
    }
  }

  void selectionnerGroupe(Groupe groupe, List<Groupe> groupes){
    if (!groupes.contains(groupe)) print('le groupe que vous essayez de séléctionner n''existe plus' );
    else _groupeActif = groupe;
  }

  Groupe creerGroupe(String id){
    //print('Enter group''s ID :');
    //var line = stdin.readLineSync();
    String line=id;
    print('Add a group photo :');
    //var line2 = stdin.readLineSync();
    var line2='la photo';
    /// generate the code
    String cd =randomString(8);
    Admin adm = new Admin(userName: _compte.getUserName(),passWord: _compte.getPassWord(),numTel: _compte.getNumTel(),groupeActif: _groupeActif
        ,vitesse: _vitesse,position: _position,distance: _distance);
    Groupe grp =new Groupe(p: adm,id: line,photo: line2,code: cd);
    print (grp);
    //(grp==null)?0:
    _listeGroupes.add(grp);
    return grp;
  }

  void quitterGroupe(Groupe groupe)
  {
    groupe.supprimerMembre(this);
    _listeGroupes.remove(groupe);
  }

  void selectionnerPersonne(Personne p)// selectionner une personne pour afficher ses details en temps reel
  {
    print(p.getUser());
    print(p.getPosition());
    print(p.getVitesse());
    print(p.getDistance());
  }

  Message envoyerMessage(Icon icone)
  {
    DateTime dateEnvoi= new DateTime.now();
    String descriptif = icone.toStringShort();
    Message message= new Message(auteur: this,dateEnvoi: dateEnvoi,icone: icone, descriptif: descriptif);
    return message;
  }

  /*void consulterMessages(Groupe grp)
  {
    Personne p;
    Message m;
    var msgs = grp.getMessages();
    msgs.forEach((p,m)=> print ('${p} a envoyé le message suivant : ${m.getDescriptif()}'));
  }*/
  void afficherHistorique(Groupe grp)
  //afficher l'hisorique des groupes
  {
    String s;
    DateTime d;
    var hist = grp.historique;
    hist.forEach((s,d)=> print('le lieu ${s} a été visité le ${d}'));
  }
  String rechercherLieu()
  {
    print('Rechercher...');
    var line = stdin.readLineSync();
    print(' vous avez selectionné la position ${line}');
    return line;
  }
  void planArret(Groupe grp) //Planifier un arret
  {
    String pos =rechercherLieu();
    var date = new DateTime.utc(2020,03,22,00,0,0);
    Arret arr = new Arret(position: pos,date: date);
    grp.ajouterArret(arr);
  }
  bool Accepter (Personne autre)
  {
    print('Voulez vous accepter cette personne ? ');
    print(' 1. oui ');
    print(' 2. non ');
    var verif = false;
    bool verdict;
    while (!verif)
    {
      var confirm = stdin.readLineSync();
      var num = int.parse(confirm);
      if ( num == 1 || num == 2) verif = true;
    }
    if ( num == 1 )
    {
      verdict= true;
    } else
    {
      verdict = false;
    }
    return verdict;
  }
  bool Refuser (Personne autre)
  {
    print('Voulez vous refuser cette personne ? ');
    print(' 1. oui ');
    print(' 2. non ');
    var verif = false;
    bool verdict;
    while (!verif)
    {
      var confirm = stdin.readLineSync();
      var num = int.parse(confirm);
      if ( num == 1 || num == 2) verif = true;
    }
    if ( num == 1 )
    {
      verdict= true;
    }
    else
    {
      verdict = false;
    }
    return verdict;
  }

  List<String> get lieuxVisites => _lieuxVisites;

  set lieuxVisites(List<String> value) {
    _lieuxVisites = value;
  }

  List<Groupe> get listeGroupes => _listeGroupes;

  set listeGroupes(List<Groupe> value) {
    _listeGroupes = value;
  }

  Groupe get groupeActif => _groupeActif;

  set groupeActif(Groupe value) {
    _groupeActif = value;
  }

  double get vitesse => _vitesse;

  set vitesse(double value) {
    _vitesse = value;
  }

  GeoPoint get position => _position;

  String get photo => _photo;

  set photo(String value) {
    _photo = value;
  }

  set position(GeoPoint value) {
    _position = value;
  }

}