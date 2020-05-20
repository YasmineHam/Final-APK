
import 'package:flutter/material.dart';
import './accueil/Accueil.dart';
import './accueil/slide_fonc1.dart';
import 'authrecup/CustomLoginForm1.dart';
import 'noyau/Personne.dart';
import 'noyau/Groupe.dart';
//*import 'Messages/chat.dart';




void main() {




  runApp(MyApp());
}




class MyApp extends StatelessWidget {
  static List<Personne> list = new List<Personne>()  ;


  MyApp();

  @override
  Widget build(BuildContext context) {
    final appTitle = "Login";

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,

      home: Scaffold(

        backgroundColor: Color(0XFFE0E5EC),
        body : CustomLoginForm1(),
        //*checkConnex(),
        //* BatteryLevelPage(),
        //*DemoApp(),


      ),
    );
  }
}







