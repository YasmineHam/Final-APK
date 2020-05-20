import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:typed_data';
import 'dart:async';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/services.dart";
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "../noyau/Personne.dart";

class BitmapImage extends StatelessWidget {
   Personne per ;
  BitmapImage(this.per);



   Future<BitmapDescriptor> getMarkerImageFromUrl(
      {
        int targetWidth,
      }) async {


  if (per.photo != null) {
    final File markerImageFile = await DefaultCacheManager().getSingleFile(per.photo);

    Uint8List markerImageBytes = await markerImageFile.readAsBytes();
    targetWidth= 20 ;

    if (targetWidth != null) {
      markerImageBytes = await _resizeImageBytes(
        markerImageBytes,
        targetWidth,
      );
    }

    return BitmapDescriptor.fromBytes(markerImageBytes);
  }
  else{

      return await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5),
           "assets/driving_pin.png");

  }
  }
  static Future<Uint8List> _resizeImageBytes(
      Uint8List imageBytes,
      int targetWidth,
      ) async {
    assert(imageBytes != null);
    assert(targetWidth != null);

    final Codec imageCodec = await instantiateImageCodec(
      imageBytes,
      targetWidth: targetWidth,
    );

    final FrameInfo frameInfo = await imageCodec.getNextFrame();

    final ByteData byteData = await frameInfo.image.toByteData(
      format: ImageByteFormat.png,
    );

    return byteData.buffer.asUint8List();
  }



  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
