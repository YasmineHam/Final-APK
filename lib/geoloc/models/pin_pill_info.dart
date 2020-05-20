import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../noyau/Personne.dart';

class PinInformation {
  String pinPath;
  String avatarPath;
  GeoPoint location;
  String locationName;
  Color labelColor;
  double distance ;
  double vitesse ;
  Personne personne ;
  String connexion ;

  PinInformation({this.pinPath, this.avatarPath, this.location, this.locationName, this.labelColor , this.distance,this.vitesse , this.personne ,this.connexion});
}