


import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'Palette.dart';
import '../noyau/Personne.dart';
import 'dart:async';
import 'Photo.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as Path;
import '../PagePrincipale.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Image_pic extends StatefulWidget {
  String p ;
  bool per ;
  Personne personne ;

  Image_pic(this.p , this.per , this.personne);
  static File img ;
  @override
  _Image_picState createState() => _Image_picState();
}
enum AppState {
  free,
  picked,
  cropped,
}


class _Image_picState extends State<Image_pic> {
  File _image =null ;
  AppState state;
  File imageFile;
  String fileName ;
  String _uploadedFileURL;
  @override
  void initState() {
    super.initState();
    state = AppState.free;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(
          "Choix Image",
          style: TextStyle(fontWeight:FontWeight.bold ,fontSize: 30 , color: Colors.white),

        ),
        leading: IconButton(
          alignment: Alignment.topLeft,
          icon: const Icon(
            Icons.save_alt,
            size: 40,
          ),
          color: Colors.white,
          onPressed: () async {
            if ((state==AppState.cropped)|| (state==AppState.picked)) {
              await uploadFile();

              await Firestore.instance.collection("users").document(
                  widget.personne.compte.email).collection("compte").document("compte").updateData({
                'Photo': _uploadedFileURL,
              });

              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PagePrincipale(widget.personne)),
              );
            }


            print("retour");
          },
        ),
        backgroundColor: Palette.violet,
        centerTitle: true,
      ),
      body: Center(
        //* child: imageFile != null ? Image.file(imageFile) : Container(),
        child: imageFile != null ?  Container(
          width: 100.0,
          height: 100.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(

              fit: BoxFit.fill,
              image: new AssetImage(imageFile.path),

            ),
          ),
        ):
        Container(
          width: 100.0,
          height: 100.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(

                fit: BoxFit.fill,
                image: new AssetImage("assets/camera.png")
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.violet,
        onPressed: () {
          if (state == AppState.free) {
            _pickImage();
           //* print(_image.path);
          }
          else if (state == AppState.picked)
            _cropImage();
          else if (state == AppState.cropped){ _clearImage();

        //*  uploadFile();
            }
        },
        child: _buildButtonIcon(),
      ),
    );
  }

  Widget _buildButtonIcon() {
    if (state == AppState.free)
      return Icon(Icons.add);
    else if (state == AppState.picked)
      return Icon(Icons.crop);
    else if (state == AppState.cropped)
      return Icon(Icons.clear);
    else
      return Container();
  }


  Future uploadFile() async {
    if (widget.per==true) {
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('users/$fileName');
      StorageUploadTask uploadTask = storageReference.putFile(_image);
      await uploadTask.onComplete;

      print('File Uploaded');
      await storageReference.getDownloadURL().then((fileURL) async {
        setState(() {
          _uploadedFileURL = fileURL;


        });

      });


      widget.personne.photo= _uploadedFileURL;
    }
    else{
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('groups/$fileName');
      StorageUploadTask uploadTask = storageReference.putFile(_image);
      await uploadTask.onComplete;
      print('File Uploaded');
      storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          _uploadedFileURL = fileURL;
        });
      });
    }
  }

  Future<Null> _pickImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _image = imageFile;
        fileName = widget.p;
        state = AppState.picked;
      });
    }
  }


  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets:
      [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],

      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),


    );
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        state = AppState.cropped;
      });

    }
  }

  void _clearImage() {
    imageFile = null;
    setState(() {
      state = AppState.free;
    });
  }
}
