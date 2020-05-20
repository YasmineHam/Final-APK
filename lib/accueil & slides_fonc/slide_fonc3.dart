import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'Accueil.dart';

class Slide_fonc3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SlideState3();
  }
}

class _SlideState3 extends State<Slide_fonc3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFF7272),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            Image(image: new AssetImage('photos/slide3.jpg'),
              height: 300,
              width: 300,),
            SizedBox(height: 20,),
            Text("Plus de distraction! vous n'avez" ,
              style: TextStyle
                (
                fontFamily:'Gilroy-ExtraBold.ttf',
                fontSize:25,
                color :Color(0xffffffff),
              ),
              textAlign: TextAlign.center,
            ),
            Text("qu'à vous envoyez des icônes" ,
              style: TextStyle
                (
                fontFamily:'Gilroy-ExtraBold.ttf',
                fontSize:25,
                color :Color(0xffffffff),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 200,),
            Container(
              width: 200,
              height: 40,
              child: NeumorphicButton(

                onClick:()
                {
                  boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(30));
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    depth: 8,
                    lightSource: LightSource.bottomRight,
                    color: Color(0xffFF7272),
                  );
                  navigateToSubPage(context);

                },
                boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(30)),
                style: NeumorphicStyle(
                  shape: NeumorphicShape.convex,
                  depth: 24,
                  lightSource: LightSource.bottomRight,
                  color: Color(0xffFF7272),



                ),
                child:Text("Commencer!" ,
                  style: TextStyle
                    (
                    fontFamily:'Gilroy-ExtraBold.ttf',
                    fontSize:18,
                    color :Color(0xffffffff),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Future navigateToSubPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Accueil()));
  }
}