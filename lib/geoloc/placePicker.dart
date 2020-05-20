import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../ui/size_screen.dart';
import '../ui/Palette.dart';

// Your api key storage.




class pick extends StatelessWidget {
  // Light Theme
  final ThemeData lightTheme = ThemeData.light().copyWith(
    // Background color of the FloatingCard
    cardColor: Colors.white,
    buttonTheme: ButtonThemeData(
      // Select here's button color
      buttonColor: Colors.black,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  // Dark Theme
  final ThemeData darkTheme = ThemeData.dark().copyWith(
    // Background color of the FloatingCard
    cardColor: Colors.grey,
    buttonTheme: ButtonThemeData(
      // Select here's button color
      buttonColor: Colors.yellow,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Map Place Picker Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PickResult selectedPlace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Google Map Place Picer Demo"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("Load Google Map"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PlacePicker(
                          apiKey: "AIzaSyAxF6S7WsSlsrZ_JF9DnEwcNoK4-ohCdTI",
                          initialPosition: HomePage.kInitialPosition,
                          useCurrentLocation: true,
                          //usePlaceDetailSearch: true,
                          onPlacePicked: (result) {
                            selectedPlace = result;
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                          forceSearchOnZoomChanged: true,
                          automaticallyImplyAppBarLeading: false,
                          autocompleteLanguage: "fr",
                          region: 'dz',
                          selectInitialPosition: true,
                          selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
                             print("state: $state, isSearchBarFocused: $isSearchBarFocused");
                             return isSearchBarFocused
                                 ? Container()
                                 : FloatingCard(
                                     bottomPosition: 10.0,    // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                                     leftPosition: 0.0,
                                     rightPosition: 0.0,
                                     width: 50,

                                     borderRadius: BorderRadius.circular(20.0),
                                     color: Palette.violet.withOpacity(0.5) ,
                                     child: state == SearchingState.Searching
                                         ? Center(child: CircularProgressIndicator())
                          : RaisedButton
                                       (
                                       padding: EdgeInsets.all(20),

                                       color: Palette.violet.withOpacity(0.5),
                                            child: Column(
                                              children: <Widget>[
                                                Text("choisis ce lieu", style: TextStyle(
                                                  fontFamily: "gilroy-ExtraBold",
                                                  fontSize: 15 ,
                                                  color: Colors.white,                                            ),),
                                                Text((selectedPlace.geometry.location.lat==null) ?"":selectedPlace.geometry.location.lat.toString(),
                                                style: TextStyle(
                                                  fontFamily: "gilroy-Light",
                                                  fontSize: 11,
                                                  color: Colors.white,
                                                ),),
                                                Text((selectedPlace.geometry.location.lng==null) ?"":selectedPlace.geometry.location.lng.toString(),
                                                  style: TextStyle(
                                                    fontFamily: "gilroy-Light",
                                                    fontSize: 11,
                                                    color: Colors.white,
                                                  ),),
                                                Text((selectedPlace.name==null) ?"":selectedPlace.name,
                                                  style: TextStyle(
                                                    fontFamily: "gilroy-Light",
                                                    fontSize: 11,
                                                    color: Colors.white,
                                                  ),),


                                              ],
                                            ),
                                         onPressed: () {
                                 // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
                                 //            this will override default 'Select here' Button.
                                 print(selectedPlace.toString());
                            print(selectedPlace.geometry.location.lng);
                            print(selectedPlace.geometry.location.lat);
                            Firestore.instance.collection("lieux").document("lieu1").setData(
                            {"position":GeoPoint(selectedPlace.geometry.location.lat ,
                            selectedPlace.geometry.location.lng),
                            "nom": selectedPlace.name ,
                            }
                            );
                            Navigator.of(context).pop();
                            },



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
                      },
                    ),
                  );
                },
              ),
              selectedPlace == null ? Container() : Text(selectedPlace.formattedAddress ?? ""),
            ],
          ),
        ));
  }
}