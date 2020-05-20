import 'dart:ffi';

import 'package:flutter/material.dart';

class MyButton extends FlatButton{
  final GestureTapCallback onPressed;
  double longeur = 250.0;
  double hauteur = 75;
  final String text;

  MyButton({@required this.onPressed, this.longeur = 250, this.hauteur = 75,this.text});

  @override
  Widget build(BuildContext context) {
    return
      FlatButton(
        padding: EdgeInsets.all(0.5),
        onPressed: () {
          this.onPressed();
        },
        child: Container(
          //margin: const EdgeInsets.only(left: 300),
          child: Center(
              child: new Text(this.text,
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    color: Color(0xff5813ea),
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ))),
          width: this.longeur,
          height: this.hauteur,
          decoration: new BoxDecoration(
            color: Color(0XFFE0E5EC).withOpacity(1),
            borderRadius: BorderRadius.circular(47),
            boxShadow: [
              BoxShadow(
                  color: Color(0XFFA6ABBD).withOpacity(1),
                  offset: Offset(10, 10),
                  blurRadius: 20,
                  spreadRadius: 0),
              BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  offset: Offset(-10, -10),
                  blurRadius: 20,
                  spreadRadius: 0),
            ],
          ),
        ),

    );
  }
}
