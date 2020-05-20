import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Photo extends StatelessWidget {

  final String imageUrl;

  Photo({@required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        Container(
          child: Neumorphic(
            child:Center(
              child: Container(
                width: 50.0,
                height: 50.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,


                    image: new DecorationImage(

                        fit: BoxFit.fill,
                        image: new NetworkImage(
                            this.imageUrl)
                    )
                ),
              ),
            ),
            boxShape: NeumorphicBoxShape.roundRect( borderRadius:BorderRadius.circular(100)),
            style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              depth: 8,
              lightSource: LightSource.topLeft,
              //*  color: Colors.grey
            ),
          ),
          height:54,
          width: 54,
        ),


      ],
    );

  }
}
