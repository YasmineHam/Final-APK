import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../PagePrincipale.dart';
import '../messages/Boite_rec.dart';
import 'package:intl/intl.dart';
import 'Palette.dart';
import '../geoloc/Arret1.dart';
import '../PagePrincipale.dart';
import '../noyau/Personne.dart';

class FancyFab extends StatefulWidget {
  Personne p;
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  FancyFab(this.p,{this.onPressed, this.tooltip, this.icon});

  @override
  _FancyFabState createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
  bool visible =false;

  @override
  initState() {
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget message() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Color(0xff14eb8e),
        onPressed: (){
          setState(() {
            visible = !visible;
          });
         //PagePrincipale(widget.p).createState().setVsible();
          //addDialog(context, 'affiche moi un message baliz');
        },
        tooltip: 'Message',
        heroTag: 'message',
        child: Icon(Icons.message, color: Palette.background,),

      ),
    );
  }

  Widget alert() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Color(0xFF4f00f2) ,
        onPressed: (){
        },
        tooltip: 'Alert',
          heroTag: 'alert',
        child:  Icon(Icons.add_alert, size: 38, color: Palette.background,)
      ),
    );
  }

  Widget arret() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Color(0xffef883e),
        onPressed:() {
      Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) => Arret(widget.p)),
      );
      },
        tooltip: 'Arret',
        heroTag: 'arret',
        child: Icon(Icons.stop, size: 38, color: Palette.background),
      ),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        heroTag: 'toogle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 3.0,
            0.0,
          ),
          child: message(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: alert(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: arret(),
        ),
        toggle(),
      ],
    );
  }
  ///***************************Showing a dialog****************************///
  Future<bool> addDialog(BuildContext context, String msg) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content:
            Text(msg),
            title: Row(
              children: const<Widget>[

                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('Ok'),
                  textColor: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pop();
                  }
              ),
            ],

          );
        });
  }
  ///***************************Envoyer un message****************************///
  Future<void> addMessages(String grp, String username, String msg) async {
    {
      bool unread;
      String currentname = widget.p.compte.userName;

      if (username==widget.p.compte.userName){
        unread = false;}
      else {unread=true;}
      DateTime now = DateTime.now();
      String time = DateTime.now().toLocal().toString();
      print(time);
      String formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(now);
      String formattedDate2 = DateFormat('dd-MM-yyyy \nHH:mm').format(now);
      Firestore.instance.collection('groups').document(grp)
          .collection('messages').document(time).setData({
        'auteur': username,
        'time': formattedDate,
        'message': msg,
        'unread': unread,

      }).catchError((e) {
        print(e);
      });
      Firestore.instance.collection('groups').document(grp).updateData({
        'lastMsg': msg,
        'timeLast': formattedDate2,
        'unread': unread,

      }).catchError((e) {
        print(e);
      });
    }
  }

}