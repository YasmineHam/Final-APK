import 'package:flutter/cupertino.dart';
import 'Personne.dart';

class Message {
  Personne _auteur;
  DateTime _dateEnvoi ;
  Icon _icone;
  String _descriptif;

  Personne get auteur => _auteur;
  DateTime get dateEnvoi => _dateEnvoi ;
  Icon get icone => _icone;
  String get descriptif => _descriptif;
  set auteur (Personne auteur)
  {
    _auteur=auteur;
  }
  set dateEnvoi (DateTime dateEnvoi)
  {
    _dateEnvoi=dateEnvoi;
  }
  set icone (Icon icone)
  {
    _icone=icone;
  }
  set descriptif (String descriptif)
  {
    _descriptif=descriptif;
  }
  String getDescriptif ()
  {
    return _descriptif;
  }

  Message ({Personne auteur, DateTime dateEnvoi, Icon icone, String descriptif}) {
    _auteur=auteur;
    _dateEnvoi=dateEnvoi;
    _icone=_icone;
    _descriptif=descriptif;

  }




}