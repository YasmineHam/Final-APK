import 'package:flutter/material.dart';
import '../models/pin_pill_info.dart';
import '../../ui/Palette.dart';
import '../../ui/image_pic2.dart';



class MapPinPillComponent extends StatefulWidget {

  //*double pinPillPosition;
  bool pinPillVisibility ;
  PinInformation currentlySelectedPin;

  MapPinPillComponent({ this.pinPillVisibility, this.currentlySelectedPin});

  @override
  State<StatefulWidget> createState() => MapPinPillComponentState();
}

class MapPinPillComponentState extends State<MapPinPillComponent> {

  @override
  Widget build(BuildContext context) {

    return Visibility(
      visible :widget.pinPillVisibility,

      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.all(20),
          height: 150,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: <BoxShadow>[
                BoxShadow(blurRadius: 20, offset: Offset.zero, color: Colors.grey.withOpacity(0.5))
              ]
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 50, height: 90,


                margin: EdgeInsets.only(left: 10),
                child: (widget.currentlySelectedPin.personne ==null) ?SizedBox(width: 20 ,height:  20 ,) :Image_pic2(widget.currentlySelectedPin.personne),
              ),


              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      //  itemCount: 1,
                      Text(
                          (widget.currentlySelectedPin.personne.compte==null)?'':
                          widget.currentlySelectedPin.personne.compte.userName, style: TextStyle(color: Palette.violet , fontSize:12 , fontFamily: "Gilroy" )),
                      Text((widget.currentlySelectedPin.locationName== null) ?'':(widget.currentlySelectedPin.locationName) , style: TextStyle(color: widget.currentlySelectedPin.labelColor ,fontFamily: "Gilroy")),
                      Text((('Latitude: ${widget.currentlySelectedPin.location.latitude.toString()}')==null)? '':('Latitude: ${widget.currentlySelectedPin.location.latitude.toString()}'), style: TextStyle(fontSize: 12, color: Colors.grey ,fontFamily:"Gilroy" )),
                      Text('Longitude: ${widget.currentlySelectedPin.location.longitude.toString()}', style: TextStyle(fontSize: 12, color: Colors.grey ,fontFamily: "Gilroy")),
                      Text('Vitesse : ${(widget.currentlySelectedPin.vitesse==null)?"0.0":widget.currentlySelectedPin.vitesse.toString()} m/s', style: TextStyle(fontSize: 12, color: Colors.grey ,fontFamily: "Gilroy")),
                      Text('Distance : ${(widget.currentlySelectedPin.distance==null) ?"0": widget.currentlySelectedPin.distance.toString()} km', style: TextStyle(fontSize: 12, color: Colors.grey ,fontFamily: "Gilroy")),
                      Text("Batterie: ${(widget.currentlySelectedPin.personne==null)?"":(widget.currentlySelectedPin.personne.battery==null)?"":widget.currentlySelectedPin.personne.battery}" ,style: TextStyle(fontSize: 12 ,color: Colors.grey ,fontFamily: "Gilroy"),),

                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}