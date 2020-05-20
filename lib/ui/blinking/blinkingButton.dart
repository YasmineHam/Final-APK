import 'package:flutter/material.dart';

class MyBlinkingButton extends StatefulWidget {
  String user ;
  String msg;
  MyBlinkingButton(this.user , this.msg);
  @override
  _MyBlinkingButtonState createState() => _MyBlinkingButtonState();
}

class _MyBlinkingButtonState extends State<MyBlinkingButton>
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
              child: Text('${widget.user} ${widget.user}',style: TextStyle(color: Colors.white),),
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