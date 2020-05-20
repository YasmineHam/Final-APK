import 'package:flutter/material.dart';
import '../noyau/Personne.dart';
import 'homeScreen.dart';

class ChatPage extends StatelessWidget {
  Personne myTest = new Personne(email: 'may@gmail.com');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff6220ed),

      ),
      home: HomeScreen(per: myTest,),
    );
  }
}
