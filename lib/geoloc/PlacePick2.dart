/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Arret1.dart';
import 'ModifierFavori.dart';
import '../groupes/CreerVoyage.dart';
import '../ui/Palette.dart';
import '../ui/size_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

class PlacePick2 extends StatefulWidget {
  const PlacePick2({Key key}) : super(key: key);
  static PickResult pickResult;
  static var option ;// pour definir si c un choix de destination (1)//arret(2) ou bien favoris(3)

  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  _PlacePickState2 createState() => _PlacePickState2();
}

class _PlacePickState2 extends State<PlacePick2> {
  PickResult selectedPlace;

  @override
  Widget build(BuildContext context) {
    return PlacePicker(

      apiKey: "AIzaSyAxF6S7WsSlsrZ_JF9DnEwcNoK4-ohCdTI",
      initialPosition: PlacePick2.kInitialPosition,
      useCurrentLocation: true,
      usePlaceDetailSearch: true,
      usePinPointingSearch: true,
      onPlacePicked: (result) {
        setState(() => selectedPlace = result);
        Navigator.of(context).pop();
        //setState(() {});
      },
      forceSearchOnZoomChanged: true,
      automaticallyImplyAppBarLeading: true,
      autocompleteLanguage: "ko",
      region: 'au',
      selectInitialPosition: true,
      selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
        print("state: $state, isSearchBarFocused: $isSearchBarFocused");
        return isSearchBarFocused
            ? Container()
            : FloatingCard(

          bottomPosition: 0.0,    // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
          leftPosition: 0.0,
          rightPosition: 0.0,

          width: displayWidth(context)*0.95,
          height: displayHeight(context) * 0.15,
          borderRadius: BorderRadius.circular(8),

          child: state == SearchingState.Searching
              ? Center(child: CircularProgressIndicator())
              : Container(
            color: Palette.background,
            child: Column(

              children: <Widget>[
                SizedBox(height: 5,),
                Text(selectedPlace.formattedAddress),
                SizedBox(
                  height: 15,
                ),
                RaisedButton(
                  child: Text("Selectionner ici"),
                  onPressed: () {
                    PlacePick2.pickResult = selectedPlace;
                    // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
                    //            this will override default 'Select here' Button.
                    print("do something with [selectedPlace] data");
                    switch(PlacePick2.option)
                    {
                      case 1:
                        //CreerVoyage.dest = selectedPlace.geometry.location;
                        CreerVoyage.dest= selectedPlace.formattedAddress;

                        break;
                      case 3 :
                        Arret.dest= selectedPlace.name;
                      //si c'est pour choisir emplacement arret
                        break;

                      case 2:
                        ModifierFavori.dest = selectedPlace.name;
                        //pour adresse favori
                        break;


                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
      // pinBuilder: (context, state) {
      //   if (state == PinState.Idle) {
      //     return Icon(Icons.favorite_border);
      //   } else {
      //     return Icon(Icons.favorite);
      //   }
      // },
    );
  }
}*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../geoloc/Arret1.dart';
import '../geoloc/ModifierFavori.dart';
import '../groupes/CreerVoyage.dart';
import '../ui/Palette.dart';
import '../ui/size_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import '../noyau/Personne.dart';
//Final

class PlacePick2 extends StatefulWidget {
//  final Personne personne;
//const PlacePick2({Key key}) : super(key: key);
  Personne p;
  PlacePick2(this.p);

  static PickResult pickResult;

  static var option ;// pour definir si c un choix de destination (1)//arret(2) ou bien favoris(3)

  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  _PlacePickState2 createState() => _PlacePickState2();
}

class _PlacePickState2 extends State<PlacePick2> {
  PickResult selectedPlace;

  @override
  Widget build(BuildContext context) {
    return PlacePicker(

      apiKey: "AIzaSyAxF6S7WsSlsrZ_JF9DnEwcNoK4-ohCdTI",
      initialPosition: (selectedPlace == null )?PlacePick2.kInitialPosition : selectedPlace,
      useCurrentLocation: true,
      usePlaceDetailSearch: true,
      usePinPointingSearch: true,
      onPlacePicked: (result) {
        setState(() {
          selectedPlace = result;

        });
        //Navigator.of(context).pop();
        setState(() {

        });


      },
      forceSearchOnZoomChanged: true,
      automaticallyImplyAppBarLeading: true,
      autocompleteLanguage: "en",
      region: 'au',
      selectInitialPosition: true,
      selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
        print("state: $state, isSearchBarFocused: $isSearchBarFocused");
        return isSearchBarFocused
            ? Container()
            : FloatingCard(

          bottomPosition: 0.0,    // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
          leftPosition: 0.0,
          rightPosition: 0.0,

          width: displayWidth(context)*0.95,
          height: displayHeight(context) * 0.15,
          borderRadius: BorderRadius.circular(8),

          child: state == SearchingState.Searching
              ? Center(child: CircularProgressIndicator())
              : Container(
            color: Palette.background,
            child: Column(

              children: <Widget>[
                SizedBox(height: 5,),
                Text(selectedPlace.formattedAddress),
                SizedBox(
                  height: 15,
                ),
                RaisedButton(
                  child: Text("Selectionner ici"),
                  onPressed: () {

                    PlacePick2.pickResult = selectedPlace;

                    // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
                    //            this will override default 'Select here' Button.
                    print("do something with [selectedPlace] data");
                    switch(PlacePick2.option)
                    {
                      case 1:
                        print('------------------------case 1------------ ');
                        // CreerVoyage.dest = selectedPlace.geometry.location;
                        CreerVoyage.dest= selectedPlace.name;
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) =>
                                  CreerVoyage(widget.p,widget.p.groupeActif),
                            )
                        );

                        break;
                      case 3 :
                        print('------------------------case 3------------ ');
                        Arret.dest= selectedPlace.name;
                        //si c'est pour choisir emplacement arret
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) =>
                                  Arret(widget.p),
                            )
                        );
                        break;

                      case 2:
                        print('------------------------case 2------------ ');
                        ModifierFavori.dest = selectedPlace.name;
                        //pour adresse favori
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ModifierFavori(widget.p,true,0),
                            )
                        );
                        break;


                    }
                    //Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
      // pinBuilder: (context, state) {
      //   if (state == PinState.Idle) {
      //     return Icon(Icons.favorite_border);
      //   } else {
      //     return Icon(Icons.favorite);
      //   }
      // },
    );
  }
}