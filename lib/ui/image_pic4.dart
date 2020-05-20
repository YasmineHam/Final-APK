

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import '../noyau/Personne.dart';
import 'Photo.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
class Image_pic4 extends StatefulWidget {

  String fileName ;
  bool per ;
  Image_pic4( this.fileName ,this.per);
  @override
  _Image_pic4State createState() => _Image_pic4State();
}



class _Image_pic4State extends State<Image_pic4> {
  File _image;




  String _uploadedFileURL;


  Future<dynamic> loadImage(BuildContext context, String image) async {
    if(widget.per==true) {
      _uploadedFileURL = await FirebaseStorage.instance.ref()
          .child('users/${widget.fileName}')
          .getDownloadURL();
      print("coucou moi c'est urllllllllllllllllllllllll ${_uploadedFileURL}");
    }
    else{
      _uploadedFileURL = await FirebaseStorage.instance.ref()
          .child('groups/${widget.fileName}')
          .getDownloadURL();
      print("coucou moi c'est urllllllllllllllllllllllll ${_uploadedFileURL}");

    }

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
              //*height:
              //*MediaQuery.of(context).size.height / 1.25,
              //*width:
              //*MediaQuery.of(context).size.width / 1.25,
              //*child: snapshot.data,
                child: Center(
                  child: (_uploadedFileURL==null)? Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(

                          fit: BoxFit.fill,
                          image: new AssetImage("assets/groupe.jpg")
                      ),
                    ),
                  ) : Photo(imageUrl: _uploadedFileURL),



                )
            );

//          if (snapshot.connectionState ==
//              ConnectionState.waiting)
//            return Container(
//                height: MediaQuery.of(context).size.height /
//                    2,
//                width: MediaQuery.of(context).size.width /
//                    2,
//                child: CircularProgressIndicator());


          return Container();

        },
      );


  }
}
