import 'package:flutter/material.dart';

class MyBlinkingAlerte extends StatefulWidget {
  String msg ;
  MyBlinkingAlerte({this.msg});
  @override
  _MyBlinkingAlerteState createState() => _MyBlinkingAlerteState();
}

class _MyBlinkingAlerteState extends State<MyBlinkingAlerte>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
    new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Container(
        color: Colors.white10,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () => null,
              icon: Icon(Icons.add_alert),
              color: Colors.red,
              iconSize: 35.0,

            ),
            MaterialButton(
              onPressed: () => null,
              child: Text(widget.msg,style: TextStyle(color: Colors.white),),
              color: Colors.red,

            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}