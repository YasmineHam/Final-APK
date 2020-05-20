import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import '../noyau/Personne.dart';
import 'Photo.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
class Image_pic3 extends StatefulWidget
{
  String fileName ;
  Image_pic3( this.fileName);
  @override
  _Image_pic3State createState() => _Image_pic3State();
}
class _Image_pic3State extends State<Image_pic3> {
  File _image;



  String _uploadedFileURL;

  Future<dynamic> loadImage(BuildContext context, String image) async {
    _uploadedFileURL= await FirebaseStorage.instance.ref().child('users/${widget.fileName}').getDownloadURL();
    //print("coucou moi c'est urllllllllllllllllllllllll ${_uploadedFileURL}");
  }




  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder(
        future: loadImage(context, widget.fileName),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.done)
            return Container(
                height:
                MediaQuery.of(context).size.height / 1.25,
                width:
                MediaQuery.of(context).size.width / 1.25,
                //*child: snapshot.data,
                child: Center(
                  child:  Neumorphic(
                    child: Center(
                      child: Container(
                        width: 1000.0,
                        height: 120.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          image:(_uploadedFileURL == null)? DecorationImage(
                            fit: BoxFit.fill,
                            image:  new AssetImage("assets/account.png"),
                          )  : new DecorationImage(
                            fit: BoxFit.fill,
                            image:  new NetworkImage(_uploadedFileURL),
                          ),
                        ),
                      ),
                    ),
                    boxShape: NeumorphicBoxShape.roundRect(borderRadius:
                        BorderRadius.circular(10)),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      depth: 8,
                      lightSource: LightSource.topLeft,
                      //*  color: Colors.grey
                    ),
                  ),
                )
            );

          if (snapshot.connectionState ==
              ConnectionState.waiting)
            return Container(
                height: MediaQuery.of(context).size.height /
                    1.25,
                width: MediaQuery.of(context).size.width /
                    1.25,
                child: CircularProgressIndicator());


          return Container();

        },
      );


  }
}