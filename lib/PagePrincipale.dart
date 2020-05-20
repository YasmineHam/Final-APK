
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'accueil/Accueil.dart';
import 'geoloc/ModifierFavori.dart';
import 'groupes/CreerGroupe.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'geoloc/localisation.dart';
import 'groupes/Rejoindre_groupe.dart';
import 'groupes/crud.dart';
import 'messages/homeScreen.dart';
import 'ui/image_pic2.dart';
import 'groupes/Groupes_page.dart';
import 'ui/Iconnes.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'groupes/Invitation_groupe.dart';
import 'Page_aide.dart';
import 'ui/fancyFab.dart';
import 'geoloc/PageFavoris.dart';
import 'noyau/Personne.dart';
import 'noyau/Groupe.dart';
import 'geoloc/PageFavoris.dart';
import 'ui/size_screen.dart';
import 'ui/Palette.dart';
import 'ui/Image_pic3.dart';
import 'geoloc/Arret1.dart';
import 'editingAccount/ParametresCompte.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ui/Image_pic.dart';
import 'dart:async';
import 'geoloc/check_connexion.dart';
import 'package:connectivity/connectivity.dart';
import 'groupes/CreerVoyage.dart';
import 'package:location/location.dart';


class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}

class Messagee {
  String title;
  String body;
  String message;
  Messagee(title, body, message) {
    this.title = title;
    this.body = body;
    this.message = message;
  }
}

class PagePrincipale extends StatefulWidget {
  final List<BottomNavigationBarItem> boutons = [];
  Personne personne;
  String group_id;
  static bool vis = false;
  static String msg = '';
  String dialogMsg='';


  PagePrincipale(this.personne);

  @override
  _PagePrincipaleState createState() => _PagePrincipaleState();
}


class _PagePrincipaleState extends State<PagePrincipale> with SingleTickerProviderStateMixin{



  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _getToken() {
    _firebaseMessaging.getToken().then((token) {
      print("Device Token: $token");
    });
  }
  List<Messagee> messagesList= new List<Messagee>();



  _configureFirebaseListeners() {
    String titre;

    _firebaseMessaging.configure(
      onMessage:
//          (Map<String, dynamic> message) async {
//        print('onMessage: $message');
//        _setMessage(message);
//      },
          (Map<String, dynamic> message) async {
        print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
        print('onMessage: $message');
        titre = message['notification']['title'];
        print(titre);
        switch(titre) {
          case "Invtation" :{

            print('onMessage: $message');
            final notification = message['notification'];
            final data = message['data'];
            widget.group_id= data['group'];
            //_setMessage(message);
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text( 'vous avez une nouvelle invitation'),
                    content: Text(' ${message['data']['group']}  ${message['data']['key1']}'),
                    actions: <Widget>[

                      FlatButton(
                        child: Text('Visulaiser la notification'),
                        onPressed: () {
                          print("hhhhhhhhhhhhhhhhhhheeeeeeeeeeeeeeeyyyyyyyyyyyyyyyyyyyyyyyyy");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Invitation_groupe(widget.personne,widget.group_id)),
                          );
                        },
                      ),
                    ],
                  );
                });
          }
          break;
          case "Alerte" :{
            print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
            print('onMessage: $message');
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text( 'vous avez une alerte!',
                        style: TextStyle(color: Colors.redAccent)),
                    content: Text(' ${message['data']['push_key']} ',
                        style: TextStyle(color: Colors.redAccent)),


                  );
                });
          } break;
          case "Message" : {
            print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
            print('onMessage: $message');
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text( 'vous avez un nouveau message',
                        style: TextStyle(color: Colors.purple)),
                    content: Text(' ${message['data']['push_key']}: ${message['data']['key1']}',
                        style: TextStyle(color: Colors.purple)),


                  );
                });
          }
        }

      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        _setMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        _setMessage(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }

  //  AndroidNotificationSound slow_spring_board ;
//  Future _showNotification(Map<String, dynamic> message) async {
//    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//      'channel id',
//      'channel name',
//      'channel desc',
//      playSound: true,
//      sound: slow_spring_board,////////////////////////////////////////////////////////////////////////////////////////////////
//      importance: Importance.Max,
//      priority: Priority.High,
//    );
//
//    var platformChannelSpecifics = new NotificationDetails(
//        androidPlatformChannelSpecifics, null);
//    await flutterLocalNotificationsPlugin.show(
//      0,
//      'new message arived',
//      'i want ${message['data']['push_key']} for ${message['data']['key1']}',
//      platformChannelSpecifics,
//      payload: 'Custom_Sound',
//    );
//  }
//
//  Future selectNotification(String payload)async{
//    await flutterLocalNotificationsPlugin.cancelAll();
//  }

  _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    widget.group_id= data['group'];
    String mMessage = data['key1'];
    print("Title: $title, body: $body, message: $mMessage");
    setState(() {
      Messagee msg = Messagee(title, body, mMessage);
      messagesList.add(msg);
    });
  }

  @override
  Future<void> initState ()  {
    ////    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
////
////    var initializationSettings = InitializationSettings(
////        initializationSettingsAndroid, null);
////    flutterLocalNotificationsPlugin.initialize(initializationSettings,
////        onSelectNotification: selectNotification);
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
    messagesList= List<Messagee>();
    // _getToken();
    _configureFirebaseListeners();
    print('coucouuuuuuu');
    if (widget.personne.groupeActif ==null)
    {
      MapPage.select=widget.personne;
      MapPage.personne=widget.personne;
      print(widget.personne.listeGroupes.length);
    }

    _visibleDialog = PagePrincipale.vis;
    print(PagePrincipale.vis);
    if(_visibleDialog) {
      SchedulerBinding.instance.addPostFrameCallback((call) {
        addDialog(context,PagePrincipale.msg);
      }); }

  }


  ///***********************************************************************************************************///


  onSelectItem(int index) {
    if (this.mounted) {
      setState(() => _selectedDrawerIndex = index);
    }

    Navigator.of(context).pop(); // close the drawer
  }

  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
  bool visible =false;
  //MapPageState map ;
  int _selectedDrawerIndex = 0;
  final Map<String, Marker> _markers = {};
  bddMethods crudObj = bddMethods();
  Map<String,String > photos = Map<String ,String>();
  bool _visibleDialog=false;
  Map<String ,Personne> affich = Map <String ,Personne>();

  _getDrawerItemWidget(int pos) {
    switch (pos) {

      case 0:
      //* return new FirstFragment();
      case 1:
      //*return new SecondFragment();
      case 2:
      //*return new ThirdFragment();

      default:
        return new Text("Error");
    }
  }
  Future membre () async{
    affich= Map<String ,Personne>();

    if (widget.personne.groupeActif !=null ) {




      widget.personne.groupeActif.listMembres.forEach((element) async {
        if (element != null) {

          affich[element.compte.email]=element;

          print(element.photo);


        }

      });
    }
    print('pk tu sors ap');


  }
  bool Select ()  {
    if ((widget.personne.groupeActif.master == false) ||
        ((widget.personne.groupeActif.master == true) &&
            (widget.personne.groupeActif.existMaster(widget.personne.compte.email) ==
                true)))
      return true ;
    else return false ;


  }


  void recup()async
  {
    for (int i=1 ;i<=widget.personne.listeGroupes.length;i++)
    {
      for (int j=1 ;j<=widget.personne.listeGroupes[i].listMembres.length ;j++)
      {
        widget.personne.listeGroupes[i].listMembres[j].photo= await FirebaseStorage.instance.ref()
            .child('users/${widget.personne.listeGroupes[i].listMembres[j].compte.email}')
            .getDownloadURL();
      }
    }

    /*if ( membre.photo==null) {
     membre.photo= await FirebaseStorage.instance.ref()
         .child('users/gotrackprofil.png')
         .getDownloadURL();
   }
   */

  }

  void showToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  bool _nonVisible = true;

  void showToast2() {
    if (this.mounted) {
      setState(() {
        _nonVisible = !_nonVisible;

      });
    }

  }
  bool _visibleIcons =false;
  void setVsible (){
    setState(() {
      _visibleIcons = !_visibleIcons;

    });
    print('----------------------------____________-----------__________-------');
    print(_visibleIcons);
  }

  var databaseReference = Firestore.instance;
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontFamily: "gilroy", fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    if (this.mounted) {
      setState(() {
        _selectedIndex = index;
      });
    }

  }
  void recupPhotos(Groupe grp)
  {


    if (grp!=null) {
      if (grp.listMembres != null) {
        for (int i=1 ; i<= grp.listMembres.length-1 ;i++)
        {
          photos[grp.listMembres[i].compte.email] = grp.listMembres[i].photo;


        }


      }
    }

  }
  StreamController<Groupe> _controller = StreamController<Groupe>();

  @override
  Widget build(BuildContext context) {
    var list1 = <String>['alger', 'ain Makhlouf', 'tizi ouzou'];
    List<Groupe> lg = widget.personne.listeGroupes;
    var _listvisible = false;
    var icon = Icons.arrow_drop_down;
    bool _visibleDialog = false;



    return WillPopScope(
      onWillPop: _onBackPressed,
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        home: Scaffold(
          backgroundColor: Color(0XFFE0E5EC).withOpacity(1),
          floatingActionButton: FancyFab(),
//          FancyFab(
//            widget.personne,
//            icon: Icons.more_vert,
//          ),


          body: Stack(
            children: <Widget>[
              Positioned(
                bottom: displayHeight(context) * 0.075,
                height: displayHeight(context)*0.95,
                width: displayWidth(context),
                child: MapPage(),
                //*Container(),
              ),
              //* Container(child: Text("helloooooooo"),),²



              Container(
                height: 85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Palette.background,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        blurRadius: 20,
                        offset: Offset.zero,
                        color: Colors.grey.withOpacity(1))
                  ],
                ),
                margin: new EdgeInsets.only(bottom: 640),
                child: (widget.personne.groupeActif == null)
                    ? FlatButton(
                  onPressed: () {
                    setState(() {
                      MapPage.select = widget.personne;
                    });
                  },
                  child: Image_pic2(
                    (widget.personne),
                  ),
                )
                    : (Select() == false)
                    ? FlatButton(
                  onPressed: () {
                    setState(() {
                      MapPage.select = widget.personne;
                    });
                  },
                  child: Image_pic2(
                    (widget.personne),
                  ),
                )
                    : StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection("users")
                      .where("groupeActif",
                      isEqualTo: widget.personne.groupeActif.id)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return LinearProgressIndicator();
                    } else {
                      membre();

                    }
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(0.0),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder:
                            (BuildContext context, int index) {
                          DocumentSnapshot document =
                          snapshot.data.documents[index];
                          Personne p;

                          return Column(
                            children: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  if (this.mounted) {
                                    setState(() {
                                      MapPage.select = (MapPage
                                          .groupeActif ==
                                          null)
                                          ? widget.personne
                                          : (MapPage.groupeActif
                                          .listMembres ==
                                          null)
                                          ? widget.personne
                                          : (affich[document
                                          .documentID] ==
                                          null)
                                          ? widget.personne
                                          : affich[document
                                          .documentID];
                                      //* MapPage.source=document.data['position'];

                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PagePrincipale(
                                                      widget
                                                          .personne)),
                                              (Route<dynamic>
                                          route) =>
                                          false);
                                      /*   Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PagePrincipale(widget.personne)),
                                    );

*/
                                    });
                                  }
                                },
                                child: (affich[document.documentID] ==
                                    null)
                                    ? SizedBox(
                                  height: 2,
                                  width: 2,
                                )
                                    : Image_pic2(
                                    affich[document.documentID]),
                              ),
                              Text(
                                (document.documentID == null)
                                    ? ""
                                    : document.documentID
                                    .split('@')[0],
                                style: TextStyle(
                                  fontFamily: "Gilroy",
                                  fontSize: 13,
                                  color: Palette.violet,
                                ),
                              )
                            ],
                          );
                        });
                  },
                ),
              ),


              Container(
                height: 300,
                width: 200,
                margin:EdgeInsets.only(top: 190 ),
                child: Visibility(
                  visible: _visibleDialog,
                  child: Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text('Message de lilya'),
                          FlatButton(
                              child: Text('Ok'),
                              textColor: Colors.blue,
                              onPressed: () {
                                Navigator.of(context).pop();
                              }
                          ),
                        ],
                      ),
                    ) ,
                  ),

                ),

              ),




              Container(
                //*margin: new EdgeInsets.only(top: 350 ,left: 100),
                height: 400,
                width: 420,
                margin: EdgeInsets.only(top: 190),
                child: Opacity(
                  opacity : (_visibleIcons == false) ? 0.0 : 1.0,
                  //child: Visibility(
                  // visible: _visibleIcons,
                  child:  Container(
                    color: Colors.white.withOpacity(0.5),
                    child: GridView.count(
                      primary: false,
                      childAspectRatio: 3 / 3,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 8.0,
                      crossAxisCount: 3,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Iconnes(
                            iconne: Icon(Icons.battery_alert, size: 28),
                            couleur: Color(0xffef883e),
                            user: widget.personne,
                            msg: 'Ma batterie est faible !',
                          ),
                          //* width: 25,
                          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Iconnes(
                            iconne: Icon(Icons.signal_cellular_off, size: 28),
                            couleur: Color(0xffff7272),
                            user: widget.personne,
                            msg: 'J\'ai des problèmes de réseau',
                          ),
                          //* width: 25,
                          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Iconnes(
                            iconne: Icon(FontAwesomeIcons.broadcastTower, size: 28),
                            couleur: Color(0xFF4f00f2),
                            user: widget.personne,
                            msg: 'Attention radar dans les alentours !',),
                          //*width: 25,
                          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Iconnes(
                            iconne: Icon(FontAwesomeIcons.userSecret, size: 28),
                            couleur: Color(0xff3cbbeb),
                            user: widget.personne,
                            msg: 'Attention barage !',),
                          //*width: 25,
                          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Iconnes(
                            iconne: Icon(FontAwesomeIcons.carCrash, size: 28),
                            couleur: Color(0xff6d7587),
                            user: widget.personne,
                            msg: 'Accident dans les parages',),
                          //*width: 25,
                          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Iconnes(
                            iconne: Icon(FontAwesomeIcons. exclamationTriangle, size: 28),
                            couleur: Colors.red,
                            user: widget.personne,
                            msg: 'Attention travaux !',),
                          //*width: 25,
                          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Iconnes(
                            iconne: Icon(FontAwesomeIcons.road, size: 28),
                            couleur: Color(0xff6d7587),
                            user: widget.personne,
                            msg: 'Attention route glissante',),
                          //*width: 25,
                          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Iconnes(
                            iconne: Icon(FontAwesomeIcons.gasPump, size: 28),
                            couleur: Color(0xffef883e),
                            user: widget.personne,
                            msg: 'Station de service',),
                          //*width: 25,
                          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Iconnes(
                            iconne: Icon(FontAwesomeIcons.stopwatch, size: 28),
                            couleur: Color(0xff4f00f2),
                            user: widget.personne,
                            msg: 'On fait une pause ?',),
                          //*width: 25,
                          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(displayHeight(context) * 0.082),
            child: AppBar(

              backgroundColor: Palette.background,
              /*leading:IconButton(icon: Icon(Icons.supervised_user_circle , size: 50, color: Color(0xff5813ea),)  ),*/
              title: Text(
                "Go Track",
                style: TextStyle(
                  fontFamily: 'Gilroy-ExtraBold',
                  fontSize: 38,
                  color: Palette.violet,
                ),
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
            ),
          ),
          drawer: new Drawer(
            child: StreamBuilder(
                stream: Firestore.instance
                    .collection('users')
                    .document(widget.personne.compte.numTel)
                    .collection("compte")
                    .document("compte")
                    .snapshots(),
                builder: (context, snapshot) {

                  return ListView(
                    // Important: Remove any padding from the ListView.
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      DrawerHeader(
                        child: Column(children: [
                          Text(
                            widget.personne.compte.userName,
                            style: TextStyle(
                              fontFamily: 'Gilroy-Light',
                              fontSize: 18,
                              color: Color(0xFF4f00f2),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Stack(
                            alignment: Alignment.topRight,
                            children: <Widget>[
                              Container(
                                child: Image_pic3(widget.personne.compte.email),
                                height: 90,
                                width: 100,
                              ),


                            ],
                          ),
                        ]),
                        decoration: BoxDecoration(
                          color: Color(0XFFE0E5EC),
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(33),
                            ),
                            color: Color(0xffe0e5ec).withOpacity(0.5),
                          ),
                          height: 120,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Icon(
                                      Icons.supervised_user_circle,
                                      color: Color(0xff10b0ec),
                                      size: 28,
                                    ),
                                  ),
                                  Expanded(
                                    child: FlatButton(
                                      child: Text(
                                        "Informations",
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 10,
                                          color: Color(0xff6D7587),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ParametresCompte(
                                                      widget.personne)),
                                        );
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.camera_alt,
                                        color: Color(0xffff3e00),
                                        size: 25,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Image_pic(widget.personne.compte.email ,true ,widget.personne)
                                            )
                                        );


                                      },
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                "Email:",
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 12,
                                  color: Color(0xff6D7587),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(

                                (widget.personne.compte.email==null) ?"Il n'y a pas d'\Email" :widget.personne.compte.email,
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 12,
                                  color: Color(0xff6D7587),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(33),
                          ),
                          color: Color(0xffe0e5ec).withOpacity(0.5),
                        ),
                        height: 200,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    " Groupes :",
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-Light',
                                      fontSize: 16,
                                      color: Color(0xff6D7587),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.group,
                                        color: Color(0xff10b0ec),
                                        size: 28,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Groupes_page(widget.personne)),
                                        );
                                      },
                                    )),
                                Expanded(
                                    child: IconButton(

                                      icon: Icon(
                                        icon,
                                        color: Color(0xff10b0ec),
                                        size: 28,
                                      ),
                                      onPressed: () {
                                        if (this.mounted){
                                          setState(() {
                                            _listvisible = !(_listvisible);
                                            icon = (_listvisible)? Icons.arrow_drop_up : Icons.arrow_drop_down;
                                          });
                                        }

                                        print(" $_listvisible");
                                      },
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                              child: Text(

                                "groupe actif : " +((widget.personne.groupeActif ==null) ?"" :widget.personne.groupeActif.id ),
                              ),
                            ),
                            Flexible(
                              child: new ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: (lg == null) ? 0 : lg.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return (widget.personne.listeGroupes ==
                                        null)
                                        ? Text("Vous n'avez aucun groupe pour le moment" , style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Gilroy-Light",
                                      color: Palette.sousTitre,

                                    ),)
                                        : ListTile(
                                      title:
                                      Column(
                                        children: <Widget>[
                                          FlatButton(
                                            onPressed: (){
                                              if (this.mounted) {
                                                setState(() {
                                                  if(widget.personne.groupeActif == widget.personne.listeGroupes[index])
                                                  {
                                                    widget.personne.groupeActif = null;
                                                    MapPage.groupeActif=null;
                                                    MapPage.select= MapPage.personne;
                                                  }
                                                  else {
                                                    widget.personne.groupeActif = widget.personne.listeGroupes[index];
                                                    //*  membre();
                                                    MapPage.groupeActif = widget.personne.groupeActif;
                                                    MapPage.select = widget.personne;
                                                    MapPage.personne = widget.personne;
                                                    recupPhotos(widget.personne.groupeActif);
                                                    MapPage.photos = photos;
                                                    Firestore.instance.collection("users").document(widget.personne.compte.email).updateData({'groupeActif': widget.personne
                                                        .groupeActif.id,
                                                    });
                                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                                        PagePrincipale(widget.personne)), (Route<dynamic> route) => false);

                                                  }
                                                });
                                              }


                                            },

                                            child: Text(
                                              (widget.personne
                                                  .listeGroupes[index].id==null)?"":widget.personne
                                                  .listeGroupes[index].id,
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 12,
                                                color: Color(0xff6D7587),
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Container(
                                            width: 250,
                                            height: 7.632568359375,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        16)),
                                                color:  Color(0xffffffff)),
                                            child: // surface bar
                                            Container(
                                              width: 250,
                                              height: 7.632568359375,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(
                                                          16)),
                                                  border: Border.all(
                                                      color: const Color(
                                                          0x4dced0d6),
                                                      width: 1),
                                                  gradient: LinearGradient(
                                                      end:
                                                      Alignment(1, 1),
                                                      begin: Alignment(0,
                                                          -0.09900990128517152),
                                                      colors: [
                                                        (widget.personne.listeGroupes[index].id.compareTo((widget.personne.groupeActif==null)?"" :widget.personne.groupeActif.id) == 0)? Colors.yellow :
                                                        Color(0xffff3e00),
                                                        Color(0xffffffff)
                                                      ])),
                                            ),
                                          ),
                                        ],
                                      ),
                                      /*  subtitle: Padding(
                                                padding: EdgeInsets.only(top: 5),
                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                      width: 250,
                                                      height: 7.632568359375,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      16)),
                                                          color:  Color(0xffffffff)),
                                                      child: // surface bar
                                                          Container(
                                                        width: 250,
                                                        height: 7.632568359375,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        16)),
                                                            border: Border.all(
                                                                color: const Color(
                                                                    0x4dced0d6),
                                                                width: 1),
                                                            gradient: LinearGradient(
                                                                end:
                                                                    Alignment(1, 1),
                                                                begin: Alignment(0,
                                                                    -0.09900990128517152),
                                                                colors: [
                                                                   (widget.personne.listeGroupes[index].id.compareTo(widget.personne.groupeActif.id) == 0)? Colors.yellow :
                                                                  Color(0xffff3e00),
                                                                  Color(0xffffffff)
                                                                ])),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )*/
                                      // surface ba
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Créer un groupe",
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 12,
                            color: Palette.violet,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        leading: Icon(Icons.group),
                        onTap: () {Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CreerGroupe(widget.personne)),
                        );},
                      ),
                      ListTile(
                        title: Text(
                          "Chercher des groupes",
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 12,
                            color: Palette.violet,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        leading: Icon(Icons.group_add),
                        onTap: () async {

                          List <Groupe> li = new List<Groupe> () ;

                          Navigator.push(
                            context,
                            await  MaterialPageRoute(
                                builder: (context) =>
                                    Rejoindre_groupe(widget.personne ,li , "Rechercher un groupe")),
                          );
                        },
                      ),
                      ListTile(
                        title: Text(
                          "Messagerie",
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 12,
                            color: Palette.violet,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        leading: Icon(Icons.message),
                        onTap: () {
                          print('USERNAME');
                          print(widget.personne.getUser());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(per: widget.personne,)),
                          );

                        },
                      ),
                      ListTile(
                        title: Text(
                          "favoris",
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 12,
                            color: Palette.violet,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        leading: Icon(Icons.favorite),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PageFavoris(widget.personne)),
                          );
                        },
                      ),
                      ListTile(
                        title: Text(
                          "Page d'aide",
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 12,
                            color: Palette.violet,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        leading: Icon(Icons.help),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Page_aide(widget.personne)),
                          );
                        },
                      ),
                      ListTile(
                        title: Text(
                          "Invitation groupe",
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 12,
                            color: Palette.violet,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        leading: Icon(Icons.person_add),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Invitation_groupe(widget.personne,widget.personne.groupeActif.code)),
                          );
                        },
                      ),
                      ListTile(
                          title: Text(
                            "Se deconnecter",
                            style: TextStyle(
                              fontFamily: 'Gilroy-light',
                              fontSize: 12,
                              color: Palette.violet,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          leading: Icon(Icons.location_off),
                          onTap: () {
                            FirebaseAuth.instance.signOut().catchError((e){print(e);});
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Accueil()),
                            );

                          }),
                    ],
                  );

                }),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {

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

  @override
  /* void initState() {
    super.initState();
    if (widget.personne.groupeActif ==null)
    {
      MapPage.select=widget.personne;
      MapPage.personne=widget.personne;
      print("je passe par laaaaaaaa");
      print(widget.personne.listeGroupes.length);
      print("heeerrre");
    }
    print('*************--------------------------------------***********');
    _visibleDialog = PagePrincipale.vis;
    print(PagePrincipale.vis);
    if(_visibleDialog) {
      SchedulerBinding.instance.addPostFrameCallback((call) {
        addDialog(context,PagePrincipale.msg);
      }); }
  }*/
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
  ///*********************************************************************//
  Future<bool> _onBackPressed(){
    return showDialog(
        context: context,
        builder:(context) => AlertDialog(
          title: Text('Voulez vous vraiment quitter l\'application ?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Non'),
              onPressed: ()=> Navigator.pop(context,false) ,
            ),
            FlatButton(
              child: Text('Oui'),
              onPressed: ()=> Navigator.pop(context,true) ,
            )
          ],
        )

    );


  }




  Widget alert() {
    return Container(
      child: FloatingActionButton(
          backgroundColor: Color(0xFF4f00f2) ,
          onPressed: (){
            if (widget.personne.groupeActif!=null){
              print("yyyyyyyyyyyyyooooooooooooohhhhhhhhhhhoooooooooooooooo");
              print(widget.personne.groupeActif);
              Firestore.instance.collection('groups').document(widget.personne.groupeActif.id).collection('alertes').document(widget.personne.compte.email).setData({
                'coordonnées lors de l''envoi' : "heyhey",//GeoPoint(widget.p.position.latitude,widget.p.position.longitude),
              });
              ShowToast('alerte envoyée avec succèes');
            }
            else {
              ShowToast('veuillez vérifier votre groupe');
            }

            // return MyBlinkingAlerte(msg:'Une alerte a été lancée par '+ widget.p.getUser());
          },
          tooltip: 'Alert',
          heroTag: 'alert',
          child:  Icon(Icons.add_alert, size: 38, color: Palette.background,)
      ),
    );
  }

  Widget message() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Color(0xff3cbbeb),
        onPressed: (){
          this.setVsible();

        },
        tooltip: 'Message',
        heroTag: 'message',
        child: Icon(Icons.message, color: Palette.background,),

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
                builder: (context) =>  Arret(widget.personne)),
          );
        },
        tooltip: 'Arret',
        heroTag: 'arret',
        child: Icon(Icons.stop, size: 38, color: Palette.background),
      ),
    );
  }
  Widget voyage() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed:() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreerVoyage (widget.personne ,widget.personne.groupeActif))// Arret(widget.personne)),
            //Arret(widget.personne
          );
        },
        tooltip: 'voyage',
        heroTag: 'voyage',
        child: Icon(Icons.local_car_wash, size: 30, color: Palette.background),
      ),
    );
  }
  Widget favoris() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Color(0xffff7272),
        onPressed:() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ModifierFavori(widget.personne,true,0))// Arret(widget.personne)),
            //Arret(widget.personne
          );
        },
        tooltip: 'Favori',
        heroTag: 'favori',
        child: Icon(Icons.stars, size: 30, color: Palette.background),
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

  ///**************************Widget FancyFab******************************///
  Widget FancyFab(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 5.0,
            0.0,
          ),
          child: message(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 4.0,
            0.0,
          ),
          child: alert(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 3.0,
            0.0,
          ),
          child: voyage(),
        ),Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: favoris(),
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
  ///***********************************************************************///
  void ShowToast(message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }


}