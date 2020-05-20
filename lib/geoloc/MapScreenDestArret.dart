import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'Arret1.dart';
//import 'package:location/location.dart';
import 'AddFavorisScreen.dart';
import 'FavorisScreen.dart';
import 'dart:async';
import '../noyau/Personne.dart';

class MyHomeDestArret extends StatefulWidget {
  final GeoPoint pos;
  final int i;
  final String place;
  final Personne p ;
  const MyHomeDestArret({Key key, this.pos, this.i, this.place , this.p}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MyHomePageState();

}
class _MyHomePageState extends State<MyHomeDestArret> {
  //GoogleMapController _controller;
  Completer<GoogleMapController> _controller = Completer();
  static Position position;
  Widget _child;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List<Marker> allMarkers = [];
  String destination = '', favoris = '', arrets = '';

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  //*String googleAPIKey = 'AIzaSyD8HY7gcqoiJ7Udz0g4GaxHB7YrfnqxWq0';
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  BitmapDescriptor stopIcon;


  @override
  void initState(){
    getCurrentLocation();
    getDataa();
    //createMarker();  
    //setSourceAndDestinationIcons(); 
    super.initState();
  }
  void getCurrentLocation() async{

    Position res = await Geolocator().getCurrentPosition();
    setState(() {
      position = res;
    });
  }
  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/home.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/Destianation.png');
    stopIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/stop.jpg');
  }
  void compareArret(){
    var x= GeoPoint(position.latitude, position.longitude);
    if(x == widget.pos){
      Firestore.instance.collection('arrets').document('arret').delete();
    }
  }
  void comparedestination(){
    var x= GeoPoint(position.latitude, position.longitude);
    if(x == widget.pos){
      Firestore.instance.collection('arrets').document('arret').delete();
    }
  }
//*************************add a marker to destinations on firestore********************//
  addToDestinations() async {
    await Firestore.instance.collection('destinations').document('Destination').setData({
      'coords': GeoPoint(widget.pos.latitude, widget.pos.longitude),
      'place': widget.place,
    });
  }

//*************************add a marker to destinations on firestore********************//
  addToArrets() async {
    await Firestore.instance.collection('arrets').document(widget.place).setData({
      'coords': GeoPoint(widget.pos.latitude, widget.pos.longitude),
      'place': widget.place,
    });
  }
//*******************************create a polyline on map******************************//
  Set<Polyline> _createPolyLine(){
    polylineCoordinates.add(LatLng(position.latitude, position.longitude));
    polylineCoordinates.add(LatLng(widget.pos.latitude, widget.pos.longitude));
    return<Polyline>[
      Polyline(
          polylineId: PolylineId('poly'),
          visible: true,
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates
      )
    ].toSet();
  }

//*************************************************************************************//
  createMarker(){
    if(widget.i==1){
      addToDestinations();
    }
    if(widget.i==2){
      addToArrets();
      final marker = Marker(
        markerId: MarkerId('Arret'),
        position: LatLng(widget.pos.latitude, widget.pos.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: 'Arret', snippet: widget.place),
      );
      //adding a new marker to list
      allMarkers.add(marker);
    };
    final me = Marker(
      markerId: MarkerId('Me'),
      position: LatLng(position.latitude, position.longitude),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(title: 'Me',),
    );
    //adding a new marker to list
    allMarkers.add(me);
  }
//*************************************************************************************//
  getDataa() async {
    createMarker();
    final docs = await Firestore.instance.collection('arrets').getDocuments();
    if(docs.documents.isNotEmpty){
      for(var i = 0; i<docs.documents.length; ++i){
        initArret(docs.documents[i].data);
        print('fuck');
        print(docs.documents[i].data);
      }
    };

    final doc = await Firestore.instance.collection('destinations').getDocuments();
    if(doc.documents.isNotEmpty){
      for(var i = 0; i<doc.documents.length; ++i){
        initDest(doc.documents[i].data);
        print('fuck');
        print(doc.documents[i].data);
      }
    }

    setState((){
      _child = mapWidget();
    });
  }
//*************************************************************************************//
  void initArret(request){
    //create a new marker
    final marker = Marker(
      markerId: MarkerId('Arret'),
      position: LatLng(request['coords'].latitude, request['coords'].longitude),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(title: 'Arret', snippet: request['place']),
    );
    allMarkers.add(marker);
  }
//*************************************************************************************//
  void initDest(request){
    //create a new marker
    final marker = Marker(
      markerId: MarkerId('Destination'),
      position: LatLng(request['coords'].latitude, request['coords'].longitude),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(title: 'Destination', snippet: request['place']),
    );
    //adding a new marker to map
    allMarkers.add(marker);
  }


//*************************************************************************************//

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('GooTrack'),
        /*leading: IconButton(
      icon: Icon(Icons.add),
      onPressed: () {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddFavorisScreen()),);
      }
      ),*/
        leading: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Arret(widget.p)),);
            }
        ),
      ),
      body: _child,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FavorisScreen()),);
        },
        label: Text('Liste des favoris'),
      ),
    );
  }

  Widget mapWidget(){
    return GoogleMap(
        myLocationEnabled: true,
        markers: Set<Marker>.of(allMarkers),
        //markers: _createMarkers(),
        //polylines: _createPolyLine(),
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 16.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        }
    );
  }
}
