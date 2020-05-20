import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import '../noyau/Personne.dart';
import 'Photo.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../noyau/Personne.dart';
class Image_pic2 extends StatefulWidget {


  Personne personne ;
  Image_pic2( this.personne);
  @override
  _Image_pic2State createState() => _Image_pic2State();
}



class _Image_pic2State extends State<Image_pic2> {
  File _image;
  File _cachedFile;
  String _uploadedFileURL;


  @override
  Widget build(BuildContext context) {
    return Container(
      //*height:
      //*MediaQuery.of(context).size.height / 1.25,
      //*width:
      //*MediaQuery.of(context).size.width / 1.25,
      //*child: snapshot.data,
        child: Center(
          child: (widget.personne.photo==null)? Container(
            width: 60.0,
            height: 60.0,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(

                  fit: BoxFit.fill,
                  image: new AssetImage("assets/account.png")
              ),
            ),
          ) :Container(
            width:60.0,
            height:60.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,

            ),
            child: Photo(imageUrl:widget.personne.photo),
          ),
        )

      //* enleve les 3 derniéres lignes à la place tu copies le 3eme  code CachedNetworkImage et pour image url mets comme param _uploadedFileUrl
    );





  }
}