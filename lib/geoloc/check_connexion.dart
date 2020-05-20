import 'dart:core';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:share/share.dart';
import 'dart:io';
import '../noyau/Personne.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../ui/blinking/blinkingButton.dart';
import 'sms.dart';
import '../noyau/Personne.dart';
import "../groupes/crud.dart";
import 'dart:async';
import 'package:flutter/cupertino.dart';



class connex  {
  static Personne  per ;

  connex();
  Future<bool>  bol =  bddMethods().checkExist(per.compte.email);


  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.


    return updateConnectionStatus(result);
  }


  @override
  void dispose() {
    _connectivitySubscription.cancel();

  }
  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        String wifiName, wifiBSSID, wifiIP;

        try {
          if (Platform.isIOS) {
            LocationAuthorizationStatus status =
            await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
              await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiName = await _connectivity.getWifiName();
            } else {
              wifiName = await _connectivity.getWifiName();
            }
          } else {
            wifiName = await _connectivity.getWifiName();
          }
        } on PlatformException catch (e) {
          print(e.toString());
          wifiName = "Failed to get Wifi Name";
        }

        try {
          if (Platform.isIOS) {
            LocationAuthorizationStatus status =
            await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
              await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiBSSID = await _connectivity.getWifiBSSID();
            } else {
              wifiBSSID = await _connectivity.getWifiBSSID();
            }
          } else {
            wifiBSSID = await _connectivity.getWifiBSSID();
          }
        } on PlatformException catch (e) {
          print(e.toString());
          wifiBSSID = "Failed to get Wifi BSSID";
        }

        try {
          wifiIP = await _connectivity.getWifiIP();
        } on PlatformException catch (e) {
          print(e.toString());
          wifiIP = "Failed to get Wifi IP";
        }
        if (per!=null) {
          Firestore.instance.collection("users").document(per.compte.email).collection("connexion").document("connexion").setData(
              {
                'etat': 'Connecté a un wifi',
                'Nom': '$wifiName',

              }
          );
        }
        break;
      case ConnectivityResult.mobile:
        break;
      case ConnectivityResult.none:
        if (per!=null) {
          //* ici on envoie l'alerte sms le texte ça va etre per.compte.username à perdu le réseau, son dernier emplacement est à : per.position
          share();

        }


        break;
      default:

        break;
    }
  }
  void share(){
    //final RenderBox box = context.findRenderObject();
    final String text = "${per.compte.userName} a perdu le réseau, voici les coordonnées "
        "de sa dernière position : ${per.position.latitude}- ${per.position.longitude}";
    Share.share(text);
    //sharePositionOrigin: box.localToGlobal(Offset.zero)& box.size);
  }

}

