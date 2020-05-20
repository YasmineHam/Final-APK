import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

import '../ui/customWidgets/MyTextField.dart';

class ChoixDestination extends StatefulWidget {
  @override
  _ChoixDestinationState createState() => _ChoixDestinationState();
}

class _ChoixDestinationState extends State<ChoixDestination> {
  /**
   * On doit definir la liste des destinations possibles
   */
  final List<String> listDestinations = <String>['Tizi Ouzou','Alger','Ain makhlouf','Boumerdes','Tizi Ouzou','Alger','Ain makhlou;,nf','Boumerkljhdes'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            69.13134765625,
          ),
          child: AppBar(
            title: Text(
              "Retour",
              style: TextStyle(
                fontFamily: 'Gilroy',
                color: Color(0xff6220ed),
                fontSize: 25,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              ),
              textAlign: TextAlign.start,
            ),
            leading: IconButton(
              alignment: Alignment.topLeft,
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 40,
              ),
              color: Color(0xff4b00e9),
              onPressed: () {
                /*
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Recuperation1()),
              );*/
                print("retour");
              },
            ),
            centerTitle: false,
            titleSpacing: 0,
            elevation: 0.0,
            // This removes the shadow from all App Bars.
            backgroundColor: Color(0xffe0e5ec),
          ),
        ),
        backgroundColor: Color(0xffe0e5ec),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Text(
              "  Nom du groupe",
              style: TextStyle(
                fontFamily: 'Gilroy',
                color: Color(0xff6220ed),
                fontSize: 30,

                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 30,
            ),
            MyTextField(
              inputType: TextInputType.text,
              focusMe: false,
              hauteur: 50,
              largeur: 500,
              textsize: 20,
              defaultText: "",
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "  Destination",
              style: TextStyle(
                fontFamily: 'Gilroy',
                color: Color(0xff6220ed),
                fontSize: 30,

                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                width: 400,
                height: 300,
                decoration: new BoxDecoration(
                  color: Color(0xffe0e5ec),
                  borderRadius: BorderRadius.circular(47),
                  boxShadow: [BoxShadow(
                      color: Color(0xffa6abbd),
                      offset: Offset(10,10),
                      blurRadius: 20,
                      spreadRadius: 0
                  )
                  ],
                ),
                child: ListView.builder(
                  itemCount: listDestinations.length,
                  itemBuilder: (context, position) {

                    return ListTile(
                      title: Text(listDestinations[position]),
                      //leading: Icon(Icons.directions_car),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onLongPress: (){},
                      //selected: true,
                      onTap: (){
                        print("hi");
                      },
                    );
                  },
                ),

              ),
            ),
          ],
        )
    );

  }
}