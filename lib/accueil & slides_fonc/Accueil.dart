import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:geoloc/authrecup/CustomLoginForm1.dart';
import '../authrecup/Inscription.dart';
import '../ui/size_screen.dart';
import '../ui/size_screen.dart';
import '../ui/size_screen.dart';
import 'slide_fonc2.dart';

class Accueil extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccueilState();
  }
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Color(0xffE0E4EC),
      body:Column(
        children: <Widget>[

      Container(
        height:20,
        width:250,
        margin: new EdgeInsets.only(top: 50),
        child:

            Neumorphic(
              boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(30)),
              style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                depth: -8,
                lightSource: LightSource.topLeft,
                color:Color(0xff3CBBEB),


              ),
            ),

        ),




          Center(
        child: Container(
          margin: new EdgeInsets.all(100 ),

            child: Neumorphic(
              child: Container(
                height:120,
                width: 120,
                child: Neumorphic(
                  boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(12)),
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.convex,
                    depth: 8,
                    lightSource: LightSource.topLeft,
                    color: Color(0XFFe0e4ec),

                  ),

                  child:

                    Image(image: new AssetImage('photos/logo.jpg') ,height: 100,width: 100,),







              ),
            ),
          ),
        ),
      ),

          Container(

            child: Text("Easy Track Easy Go! " ,
              style: TextStyle
                (
                fontFamily:'Gilroy-ExtraBold.ttf',
                fontSize:35,
                color :Color(0xff6D7587),
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 80,),
           Container(
             width: displayWidth(context) *0.35 ,
             height: displayHeight(context)*0.058,
             child: NeumorphicButton(

                onClick:()
                {
                  boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(0));
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    depth: -8,
                    lightSource: LightSource.bottomRight,
                    color: Color(0xff3CBBEB),
                  );

                  navigateToSubPage(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Inscription()),
                  );


                },
                boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(0)),
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  depth: 8,
                  lightSource: LightSource.bottomRight,
                  color:Color(0xff3CBBEB),



                ),
                child:Center(
                  child: Text("S'inscrire!" ,
                    style: TextStyle
                      (
                      fontFamily:'Gilroy-ExtraBold.ttf',
                      fontSize:18,
                      color :Color(0xffffffff),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
           ),
          SizedBox(height: 30,),
          Container(
            width: displayWidth(context) *0.35 ,
            height: displayHeight(context)*0.058,
            child: NeumorphicButton(

              onClick:()
              {

                boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(0));
                style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  depth: -24,
                  lightSource: LightSource.bottom,

                  //*color: Color(0xffE0E4EC),
                );

                navigateToSubPage(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomLoginForm1()),
                );

              },
              boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(0)),
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                depth: 24,
                lightSource: LightSource.bottomRight,
                color:Color(0xffE0E4EC),



              ),
              child:Text("Se connecter" ,
                style: TextStyle
                  (
                  fontFamily:'Gilroy-ExtraBold.ttf',
                  fontSize:18,
                  color :Color(0xff6D7587),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future navigateToSubPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Inscription() ));
  }
  Future navigateToSubPage2(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CustomLoginForm1() ));
  }
}