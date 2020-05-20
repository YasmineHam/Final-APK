import 'package:flutter/material.dart';
import '../geoloc/PlacePick2.dart';
import '../noyau/Personne.dart';

class PlacePick2Main extends StatelessWidget {
  static const String _title = 'Place Picker';

  Personne p;
  PlacePick2Main(this.p);
 //PlacePick2Main({ this.personne});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        backgroundColor: Color(0XFFE0E5EC),
        body : PlacePick2(p),
    )
    );
  }
}