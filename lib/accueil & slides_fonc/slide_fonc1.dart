import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'slide_fonc2.dart';

class Slide_fonc1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SlideState();
  }
}

class _SlideState extends State<Slide_fonc1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5813EA),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            Image(image: new AssetImage('photos/slide1.jpg'),
           height: 300,
            width: 300,),
            SizedBox(height: 20,),
            Text("Voyager en groupe n'a" ,
              style: TextStyle
                (
                fontFamily:'Gilroy-ExtraBold.ttf',
                fontSize:25,
                color :Color(0xffffffff),
              ),
              textAlign: TextAlign.center,
            ),
            Text("jamais été aussi simple" ,
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
                  color: Color(0xff5813EA),

                 );
                navigateToSubPage(context);

               },
               boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(30)),
               style: NeumorphicStyle(
                 shape: NeumorphicShape.convex,
                 depth: 24,
                 lightSource: LightSource.bottomRight,
                 color: Color(0xff5813EA),

               ),
               child:Text("Continuer" ,
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => Slide_fonc2()));
  }
}