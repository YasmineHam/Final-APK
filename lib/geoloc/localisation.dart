import 'dart:io';
import 'dart:math';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import '../PagePrincipale.dart';
import 'components/map_pin_pill.dart';
import 'models/pin_pill_info.dart';
import '../noyau/Personne.dart';
import '../noyau/Groupe.dart';
import '../ui/BitmapImage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart' as pack3;
import 'package:location/location.dart';
import '../ui/Palette.dart';
import 'package:geocoder/geocoder.dart';
import 'check_connexion.dart';
import 'package:connectivity/connectivity.dart';
import 'package:battery/battery.dart';
import '../ui/blinking/blinkingButton.dart';

import 'package:firebase_storage/firebase_storage.dart';

const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;


//*************************************************************************
// Classe contenant pour chaque membre du groupe sa poisition et son id (e-mail)
// Classe utilisée pour la récuperation des membres pour positioner leurs markers
class CurentLocation {
  String _id;

  GeoPoint _loc;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  GeoPoint get loc => _loc;

  CurentLocation(this._id, this._loc);

  set loc(GeoPoint value) {
    _loc = value;
  }

}
//*****************************************************************
class MapPage extends StatefulWidget {

  static Groupe groupeActif;

  static Personne select;

  static GeoPoint dest;

  static Personne personne;

  Stream<Groupe> stream;
  static Map<String, String> photos = Map<String, String>();

  MapPage();

  @override
  State<StatefulWidget> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  //********declaration des variables  ***********************************//
  connex cnx;

  Map<String, String> photos = Map<String, String>();

  double CAMERA_ZOOM;

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  LatLng SOURCE_LOCATION;

  LatLng DEST_LOCATION = (MapPage.dest == null) ? LatLng(0.0, 0.0) : LatLng(
      MapPage.dest.latitude,
      MapPage.dest.longitude); //= LatLng(36.716667, 4.05);
  final databaseReference = Firestore.instance;
  StreamSubscription subscription;
  StreamSubscription<Map<String, double>> streamSubscription;

  StreamController<Map<String, double>> controller = StreamController <
      Map<String, double>>();
  Stream stream;

  bool visibility = false;
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  Map<String, LatLng> _groupes = <String, LatLng>{};
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;
  String googleAPIKey = 'AIzaSyCKE3m3_ccKzsaqzD8I-Lb9cSKD2mjyPeg';
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  GeoPoint currentLocation;
  LocationData destinationLocation;

  Location location = new Location();
  Set<CurentLocation> lismem = new Set<CurentLocation>();
  double Position = -100;
  LocationData locationdata;
  PinInformation currentlySelectedPin = PinInformation(
    pinPath: '',
    avatarPath: '',
    location: GeoPoint(0, 0),
    locationName: '',
    labelColor: Colors.grey,
    vitesse: 0,
    distance: 0,

  );
  List<GeoPoint> locations = new List<GeoPoint>();
  Personne personne = Personne();
  var markerIdVall;

  List<String> users = new List<String>();
  PinInformation sourceInfo;
  PinInformation destinationInfo;
  PinInformation info;

  String usergr = (MapPage.groupeActif == null) ? "" : MapPage.groupeActif.id;
  var currentVitesse;

  MarkerId markertappe;

  Set<CurentLocation>changes = Set<CurentLocation>();
  Battery _battery = Battery();
  BatteryState _batteryState;
  int batteryLevel;
  String etat;

  StreamSubscription<BatteryState> _batteryStateSubscription;
  StreamSubscription _getChangesSubscription;
  Map<String, GeoPoint> arrets = Map<String, GeoPoint>();

  StreamSubscription <LocationData> _locastream;


//******************************************************************************************
  @override
  void dispose() {
    _getChangesSubscription?.cancel();
    print("Groups listener disposed");
    _batteryStateSubscription?.cancel();
    _getChangesSubscription?.cancel();
    _connectivitySubscription?.cancel();
    _locastream?.cancel();

    super.dispose();
  }


//******************************************************************************************
  void initState() {
    super.initState();
    location = Location();

    usergr = (MapPage.groupeActif == null) ? "" : MapPage.groupeActif.id;

    connex.per = MapPage.personne;

    connex().initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(
            connex().updateConnectionStatus);
    _batteryStateSubscription =
        _battery.onBatteryStateChanged.listen((BatteryState state) {
          _batteryState = state;
          update();
        });

    CAMERA_ZOOM =
    (MapPage.select.compte.email == MapPage.personne.compte.email) ? 8 : 13;

    // DEST_LOCATION= (MapPage.dest==null) ? LatLng( 36.7508896,5.0567333) : LatLng(MapPage.dest.latitude, MapPage.dest.longitude);
    currentlySelectedPin.personne = MapPage.select;
    location = new Location();
    polylinePoints = PolylinePoints();
    stream = controller.stream;
    _locastream =
        location.onLocationChanged().listen((LocationData cLoc) async {
          currentLocation = GeoPoint(cLoc.latitude, cLoc.longitude);
          GeoPoint center = GeoPoint(cLoc.latitude, cLoc.longitude);
          MapPage.personne.position = center;
          putGeoPoint(MapPage.personne, center);
          updatePinOnMap(MapPage.personne);
        });
    //*getLocsOfMembers();
    //* setInitialLocation();
    setSourceAndDestinationIcons();
    showPinsOnMap();
    placerArret();


    putGeoPoint(MapPage.personne, currentLocation);
    listenTochanges();

    markertappe = MarkerId(MapPage.select.compte.email);
  }


  //***************************************************************************************
  //* Met à jour le niveau de batterie de l'utilisateur dans la base de données
  void update() async {
    String etat;
    batteryLevel = await _battery.batteryLevel;
    if ((_batteryState == BatteryState.charging)) {
      etat = "charge";
    }
    else {
      if ((_batteryState == BatteryState.discharging)
          && (batteryLevel < 10)) {
        etat = "Batterie déchargée";
      }
      else {
        etat = "décharge";
      }
    }
    Firestore.instance.collection("users").document(
        MapPage.personne.compte.email).collection("baterie")
        .document("baterie")
        .setData({
      'niveau': batteryLevel,
      'etat': etat,
    });
  }

  //***************************************************************************************
  //* Initialise les markers source et destination
  void setInitialLocation() async {
    print(locationdata.toString());

    if (MapPage.select.compte.email == MapPage.personne.compte.email) {
      if (currentLocation!=null)
      SOURCE_LOCATION =
          LatLng(currentLocation.latitude, currentLocation.longitude);
      //*  currentLocation = GeoPoint(locationdata.latitude, locationdata.longitude);
    }
    else {
      await Firestore.instance.collection('users').document(
          MapPage.select.compte.email).get().then((document) async {
        SOURCE_LOCATION =
        (document.data["position"] == null) ? LatLng(0.0, 0.0) : LatLng(
            document.data["position"].latitude,
            document.data["position"].longitude);
      }


      );
    }
    DEST_LOCATION = (MapPage.dest == null) ? LatLng(0.0, 0.0) : LatLng(
        MapPage.dest.latitude, MapPage.dest.longitude);
  }


// ********************************************************************************************
// Verifie si l'utilisateur à presque atteint sa destination et envoie un rappel
  compareDestination(GeoPoint loc) async {
    if ((usergr != null) && (usergr != "")) {
      var x = DEST_LOCATION;
      var xx = GeoPoint(x.latitude, x.longitude);
      var distance = await getDistance(
          loc, xx, MapPage.personne.compte.numTel, MapPage.personne);
      if (distance == null) {
        PagePrincipale.msg = 'Vous êtes arrivés à votre destination';
        PagePrincipale.vis = true;
        Firestore.instance
          ..collection('groups').document(usergr)
              .collection("destinations")
              .document('Destination')
              .delete();
      }
    }
  }

//*************************************************************************************
  //Verifie si l'utilisateur à presque atteint son arret et envoie un rappel : nous avons des
  //arrets individuels ou arrets de groupes
  compareArret(GeoPoint loc, GeoPoint x, String lieu) async {
    if ((usergr != null) && (usergr != "")) {
      var xx = GeoPoint(x.latitude, x.longitude);
      var distance = await getDistance(
          loc, xx, MapPage.personne.compte.email, MapPage.personne);
      if (distance * 1000 <= 20) {
        print('Vous êtes arrivés à votre arrêt');
        PagePrincipale.msg = 'Vous êtes arrivé à votre arrêt';
        PagePrincipale.vis = true;
        //addDialog(context, 'Vous etes arrivés à votre arret à $lieu');
        // showdialog('ARRET', 'Vous etes arrivés à votre arret à $lieu',context);
        Firestore.instance
            .collection('groups').document(usergr).collection("arrets")
            .document(
            lieu).get()
            .then((doc) {
          if (doc.exists == true) {
            Firestore.instance
                .collection('groups').document(usergr)
                .collection("arrets")
                .document(
                lieu)
                .delete();
          }
          else {
            Firestore.instance
                .collection('users').document(MapPage.personne.compte.email)
                .collection("arrets").document(
                lieu)
                .delete();
          }
        });
      }
    }
  }

  //***********************************************************************
  void rappelDistance(GeoPoint loc, GeoPoint arret, String lieu) async {
    var distanceArret = await getDistance(
        loc, arret, MapPage.personne.compte.email, MapPage.personne);
    var distanceDest = await getDistance(
        loc, MapPage.dest, MapPage.personne.compte.email, MapPage.personne);
    if (distanceArret <= 3) {
      print(distanceArret);
      PagePrincipale.msg = 'vous etes à 3 km de votre Arret à $lieu';
      PagePrincipale.vis = true;
      //showdialog('RAPPEL','vous etes à 3 km de votre Arret à $lieu', context);
    }

    if (distanceDest <= 3) {
      //*PagePrincipale.msg = 'vous etes à 3 km de votre Destination';
      //*PagePrincipale.vis = true;

      //PagePrincipale(MapPage.personne).
      //showdialog('RAPPEL','vous etes à 3 km de votre Destination', context);
    }
  }

  //**************************************************************************
  void verif_arret(GeoPoint loc) {
    arrets.forEach((key, value) {
      rappelDistance(loc, value, key);
      compareArret(loc, value, key);
      PagePrincipale.vis = false;
    });
  }

  //***********************************************************************
  Future<void> showdialog(String msg1, String msg2) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msg1),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg2),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          elevation: 24.0,
          backgroundColor: Colors.white,
          shape: CircleBorder(),
        );
      },
    );
  }

  //**********************************************************************
  //*initialiser les markers des arrets sur la map
  void initArret(request) {
    MarkerId mark = new MarkerId("${request['place']}");
    final marker = Marker(
      markerId: mark,
      position: LatLng(request['coords'].latitude, request['coords'].longitude),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
          title: 'Arret', snippet: "place : ${request['place']}"),
    );

    _markers[mark] = marker;
  }

  //***************************************************************************************
  void placerArret() async
  {
    if ((usergr != null) && (usergr != "")) {
      final docs = await Firestore.instance.collection('groups').document(
          usergr).collection("arrets").getDocuments();
      if (docs.documents.isNotEmpty) {
        for (var i = 0; i < docs.documents.length; ++i) {
          arrets[docs.documents[i].documentID] =
          docs.documents[i].data['coords'];
          initArret(docs.documents[i].data);
        }
      }
    }
    final dc = await Firestore.instance.collection('users').document(
        MapPage.personne.compte.email).collection("arrets").getDocuments();
    if (dc.documents.isNotEmpty) {
      for (var i = 0; i < dc.documents.length; ++i) {
        arrets[dc.documents[i].documentID] = dc.documents[i].data['coords'];
        initArret(dc.documents[i].data);
      }
    }
  }

  //**********************************************************************************
  //Met a jour la vitesse et la position d'un utilisateur dans la base de données

  void putGeoPoint(Personne p, GeoPoint loc) async {
    verif_arret(loc);
    compareDestination(loc);
    try {
      currentVitesse = getVitesse(loc);
      //print(currentVitesse);
      databaseReference
          .collection('users')
          .document(p.compte.email)
          .updateData({
        'position': loc,
        'vitesse': currentVitesse,
      });
      setState(() {

      });
    } catch (e) {
      print(e.toString());
    }
  }


  //*************************************************************************
  //*Methode qui ecoute les changements des positions des utilisateurs du groupe
  // et met a jour à la bdd elle verifie aussi si un utilisateur à rejoint le
  //groupe ou a quitté
  void listenTochanges() async {
    if ((usergr != null) && (usergr != "")) {
      if ((MapPage.groupeActif.master == false) ||
          ((MapPage.groupeActif.master == true) &&
              (MapPage.groupeActif.existMaster(MapPage.personne.compte.email) ==
                  true))) {
        Firestore.instance.collection("groups").document(usergr).collection(
            "membres").snapshots().listen((resu) async {
          resu.documentChanges.forEach((resu) async {
            if (resu.type == DocumentChangeType.added) {
              await getLocsOfMembers();
            }
            else if (resu.type == DocumentChangeType.removed) {
              await getLocsOfMembers();
            }
            else if (resu.type == DocumentChangeType.modified) {
              await getLocsOfMembers();
            }
          });
        });
        _getChangesSubscription = Firestore.instance.collection("users").where(
            "groupeActif", isEqualTo: usergr).snapshots().listen((
            result) async {
          result.documents.forEach((res) async {
            if (lismem.isNotEmpty) {
              int i = 0;
              lismem.forEach((element) async {
                if ((element.id == res.documentID) &&
                    (element.id != MapPage.personne.compte.email)) {
                  await Firestore.instance.collection("users").document(
                      element.id).get().then((document) {
                    lismem
                        .elementAt(i)
                        .loc = (document.data["position"] == null) ? GeoPoint(
                        0.0, 0.0) : document.data["position"];
                  }
                  );
                }
              }
              );
            }
          }
          );
        });

        if (this.mounted) {
          setState(() {
            showPinsOnMap();
          });
        }
      }
    }
  }

  //********************************************************************
  //*Recuperation de la position d'un utilisateur donné de la bdd et ajout de son objet
  //Current Location à la liste
  getLocation(String email) async {
    var userpos;
    var document = Firestore.instance.collection('users').document(email);
    await document.get().then((doc) {
      userpos =
      (doc.data == null) ? GeoPoint(0.0, 0.0) : (doc.data["position"] == null)
          ? GeoPoint(0.0, 0.0)
          : doc.data["position"];
      print(userpos);

      lismem.add(CurentLocation(email, userpos));
    });
  }

  //***************************************************************************
  //*Ajouter un lieu à ses destinations
  addToDestinations() async {
    GeoPoint pos = GeoPoint(DEST_LOCATION.longitude, DEST_LOCATION.latitude);
    final coordinates = Coordinates(pos.latitude, pos.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    var first = addresses.first;
    Firestore.instance.collection('groups').document(usergr).collection(
        "destinations").add({
      'coords': GeoPoint(
          first.coordinates.latitude, first.coordinates.longitude),
      'place': first.featureName,
    });
  }

  //********************************************************************************
  //*Obtenir à partir des coordonnées d'un lieu son nom de place
  Future <String> getNamePlace(GeoPoint pos) async {
    final coordinates = (pos == null) ? Coordinates(0.0, 0.0) : Coordinates(
        pos.latitude, pos.longitude);
    print(coordinates);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    var first = addresses.first;
    return first.featureName;
  }

  //***************************************************************************************
  //*parrcours la liste des membres ayant le meme groupe actif que l'utilisateur en cours et
  //dont il dispose du droit de tarcker (pas d'utilisateurs master) et récuperation de leurs
  //position

  Future getLocsOfMembers() async {
    String per;
    String grp;


    if ((MapPage.groupeActif != null) && (MapPage.groupeActif.id != "")) {
      await Firestore.instance.collection("users").where(
          'groupeActif', isEqualTo: MapPage.groupeActif.id)
          .getDocuments()
          .then((querySnapshot) async {
        await querySnapshot.documents.forEach((result) async {
          print(result.documentID);


          //*  print(result.data);
          await getLocation(result.documentID);
        }
        );
      }
      );

      return;
    }

    return;
  }

//**************************************************************************
  //* customisation des icones source et destination
  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/source_icon.png');

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2),
        'assets/destination_map_marker.png');
  }

  //************************************************************************
  //recuperation de la distance entre 2 geopoints
  Future<double> getDistance(GeoPoint pos1, GeoPoint pos2, String mail,
      Personne p) async
  {
    var distance = 0.0;
    if (pos1 != null && pos2 != null) {
      distance = await Geolocator().distanceBetween(
          pos1.latitude, pos1.longitude, pos2.latitude, pos2.longitude);
    }
    var distancefin = distance / 1000;
    return distancefin;
  }

  //********************************************************************
  //* customisation des pins de la map
  Future<BitmapDescriptor> setCustomMapPin() async {
    return await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2),
        "assets/driving_pin.png");
  }

  //******************************************************************
  //* ajout d'un maker a la map en récuperant les données de son pin associé
  Future <Map<MarkerId, Marker>> _add(String email) async {
    var markerIdVal = email;
    Personne p = new Personne(email: email);
    final MarkerId markerId = MarkerId(markerIdVal);
    BitmapDescriptor locationIcon;
    var document = Firestore.instance.collection('users').document(email);
    await document.get().then((doc) async {
      if (doc != null) {
        p.position = await doc['position'];
        p.vitesse =
        await (doc['vitesse'] == null) ? 0.0 : doc['vitesse'].toDouble();
      }
    });
//*    getConnexion(MapPage.personne);
    await document.collection('compte').document('compte').get().then((
        document) async {
      p.compte.userName = document['Username'];
    }
    );

//    await document.collection("baterie").document("baterie").get().then((doc){
//      p.battery = doc['niveau'] ;
//      if (doc['etat']=="Batterie déchargée"){
//        MyBlinkingButton(p.compte.userName,"n'a plus de batterie");
//      }
//    });


    //*  BitmapImage btmp = BitmapImage(p);
    //*BitmapDescriptor inter = await btmp.getMarkerImageFromUrl();
    BitmapDescriptor inter = await setCustomMapPin();

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      icon: inter,
      position: LatLng(
        p.position.latitude,
        p.position.longitude,
      ),

      infoWindow: InfoWindow(title: markerIdVal),
      onTap: () {
        _onMarkerTapped(markerId, p, currentLocation);
      },
    );

    if (MapPage.select.compte.email == p.compte.email) {
      personne = p;
    }

    // adding a new marker to map
    _markers[markerId] = marker;
    return _markers;
  }

  //******************************************************************
  //*affichage d'une pin d'information lorsqu'un utilisateur clique sur
  //le marker
  void _onMarkerTapped(MarkerId markerId, Personne p, GeoPoint loc) async
  {
    visibility = true;
    p.distance = await getDistance(loc, p.position, p.compte.email, p);

    var name = await getNamePlace(p.position);
    p.photo = MapPage.photos[p.compte.email];

    currentlySelectedPin = (p == null) ? PinInformation(
      personne: MapPage.personne,

    )
        : PinInformation(
      avatarPath: p.photo,
      labelColor: Palette.bleu,
      personne: p,
      pinPath: "assets/driving_pin.png",
      distance: p.distance,
      vitesse: p.vitesse,
      location: p.position,
      locationName: name,
      //* connexion: p.connex ,

    );

    CameraPosition cPosition = CameraPosition(
      zoom: 15,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: (p.position == null) ? LatLng(
          currentLocation.latitude, currentLocation.longitude) : LatLng(
          p.position.latitude, p.position.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    //* _controller.moveCamera(CameraUpdate.newLatLng(GeoPoint(loc.latitude,loc.longitude)));


  }

  //*****************************************************************
  //*Calcul de la  vitesse de l'utilisateur
  double getVitesse(GeoPoint pos) {
    var locationOptions = LocationOptions(
        accuracy: pack3.LocationAccuracy.high, distanceFilter: 10);
    var maxx = GeoPoint(pos.latitude, pos.longitude);
    var _geoLocator = Geolocator();
    double _speed;
    _geoLocator.getPositionStream((locationOptions)).listen((maxx) {
      _speed = maxx.speed; // in mps
      currentVitesse = _speed;
    });
    return currentVitesse;
  }

  //************affichage des pins sur la map********************************************
  //*place les markers source , destination , utilisateur et des membres de son groupe actif
  void showPinsOnMap() async {
    locationdata = await location.getLocation();
    currentLocation = GeoPoint(locationdata.latitude, locationdata.longitude);
    putGeoPoint(MapPage.personne, currentLocation);
    setInitialLocation();
    var pinPosition =
    LatLng(currentLocation.latitude, currentLocation.longitude);
    var destPosition = DEST_LOCATION;
    //*LatLng(destinationLocation.latitude, destinationLocation.longitude);

    sourceInfo = PinInformation(
      locationName: '',
      location: GeoPoint(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude),
      labelColor: Colors.blueAccent,
      pinPath: "assets/source_icon.png",
      personne: MapPage.personne,);

    destinationInfo = PinInformation(
      //*   locationName: await  getNamePlace(GeoPoint(DEST_LOCATION.latitude ,DEST_LOCATION.longitude)),
      location: GeoPoint(DEST_LOCATION.latitude, DEST_LOCATION.longitude),
      pinPath: "assets/destination_map_marker.png",
      avatarPath: "assets/friend2.jpg",
      labelColor: Colors.purple,
    );
    info = PinInformation(
      locationName: '',
      location: GeoPoint(pinPosition.latitude, pinPosition.longitude),
      pinPath: 'assets/driving_pin.png',
      personne: MapPage.personne,
      vitesse: currentVitesse,

    );

    var markerIdValll = await getNamePlace(
        GeoPoint(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude));

    _markers[MarkerId('sourcePin')] = (Marker(
        markerId: MarkerId('sourcePin'),
        position: SOURCE_LOCATION,
        infoWindow: InfoWindow(title: markerIdValll),
        onTap: () {
//          setState(() {
//            currentlySelectedPin = sourceInfo;
//            Position = 0;
//          });
        },
        icon: sourceIcon));

//*    var markerIdVall = await getNamePlace(GeoPoint(DEST_LOCATION.latitude,DEST_LOCATION.longitude)) ;

    // destination pin
    _markers[MarkerId('destPin')] = (Marker(
        markerId: MarkerId('destPin'),
        position: DEST_LOCATION,
        infoWindow: InfoWindow(title: markerIdVall),

        onTap: () {
//          setState(() {
//            //currentlySelectedPin = destinationInfo;
//            //visibility = true ;
//            //Position = 0;
//
//          });
        },
        icon: destinationIcon));

    BitmapDescriptor icon = await setCustomMapPin();
    //* BitmapImage btmp = BitmapImage(MapPage.personne);
    //*BitmapDescriptor icon = await btmp.getMarkerImageFromUrl();
    _markers[MarkerId(MapPage.personne.compte.email)] = (Marker(
        markerId: MarkerId(MapPage.personne.compte.email),
        position: pinPosition,
        onTap: () {
          if (this.mounted) {
            setState(() {
              currentlySelectedPin = info;
              _onMarkerTapped(
                  MarkerId(MapPage.personne.compte.email), MapPage.personne,
                  currentLocation);
              Position = 0;
            });
          }
        },
        icon: icon));
    if ((MapPage.groupeActif != null) && (usergr != "")) {
      if (MapPage.groupeActif.master == false) {
        lismem.forEach((element) async {
          if (element.id != MapPage.personne.compte.email) {
            await _add(element.id);
          }
        });
      }

      else {
        if (MapPage.groupeActif.existMaster(MapPage.personne.compte.email) ==
            true) {
          lismem.forEach((element) async {
            if (element.id != MapPage.personne.compte.email) {
              await _add(element.id);
            }
          });
        }
      }
    }
    if (MapPage.select.compte.email != MapPage.personne.compte.email) {
      if (personne != null)
        _onMarkerTapped(
            MarkerId(MapPage.select.compte.email), personne, currentLocation);
    }

    //* setPolylines();


  }

//************************************************************************
  //********************************************************************
  /*void setPolylines() async {
    List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        currentLocation.latitude,
        currentLocation.longitude,
        destinationLocation.latitude,
        destinationLocation.longitude);

    if (result.isNotEmpty) {
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(Polyline(
            width: 5, // set the width of the polylines
            polylineId: PolylineId("poly"),
            color: Color.fromARGB(255, 40, 122, 198),
            points: polylineCoordinates));
      });
    }
  }
  */

  //******************************
  void updatePinOnMap(Personne p) async {
    //Creer une nouvelle instance de la caméra a chaque fois que l'utilisateur bouge
    //de sorte a voir le marker se deplacer


    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );
    BitmapDescriptor icon = await setCustomMapPin();
    //*  BitmapImage btmp = BitmapImage(MapPage.personne);
    //* BitmapDescriptor icon= await btmp.getMarkerImageFromUrl();
    /* final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));*/
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    if (this.mounted) {
      setState(() {
        // updated position
        var pinPosition =
        GeoPoint(p.position.latitude, p.position.longitude);

        //* info.location = pinPosition;


        // the trick is to remove the marker (by id)
        // and add it again at the updated location
        //*<Marker>.of(_markers.values).add.removeWhere((m) => m.markerId.value == 'sourcePin');
        _markers[MarkerId(MapPage.personne.compte.email)] = (Marker(
            markerId: MarkerId(MapPage.personne.compte.email),
            onTap: () {
              setState(() {
                currentlySelectedPin = sourceInfo;
                visibility = true;
                Position = 0;
              });
            },
            position: LatLng(pinPosition.latitude, pinPosition.longitude),
            // updated position
            icon: icon));
      });
    };
  }


  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: (SOURCE_LOCATION == null)
            ? LatLng(36.6366, 4.20671)
            : SOURCE_LOCATION);
    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }
    return Scaffold(
      body: FutureBuilder(
          future: getLocsOfMembers(),
          initialData: lismem,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.none &&
                snapshot.hasData == null) {
              return Container();
            }
            return Stack(
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("users").where(
                      "groupeActif", isEqualTo: usergr).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return LinearProgressIndicator();
                    else {
                      setInitialLocation();
                      getLocsOfMembers();
                      print("sortievivant");


                      showPinsOnMap();

                      placerArret();
                      setSourceAndDestinationIcons();
                    }


                    return

                      GoogleMap(
                          myLocationEnabled: true,
                          compassEnabled: true,
                          tiltGesturesEnabled: false,
                          markers: Set<Marker>.of(_markers.values),
                          polylines: _polylines,
                          mapType: MapType.normal,
                          initialCameraPosition: initialCameraPosition,
                          onTap: (LatLng loc) {
                            //*  Position = -0;
                            visibility = false;
                          },
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                            setSourceAndDestinationIcons();
                            showPinsOnMap();
                            placerArret();
                            //*setPolylines();

                          });
                  },
                ),

                MapPinPillComponent(
                    pinPillVisibility: visibility,
                    currentlySelectedPin: currentlySelectedPin)


              ],
            );
          }


      ),


    );
  }


}
//************************************************************************
