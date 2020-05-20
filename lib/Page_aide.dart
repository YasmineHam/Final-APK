
import 'package:flutter/material.dart';
import 'noyau/Personne.dart';
import 'PagePrincipale.dart';
import 'ui/Palette.dart';
class Page_aide extends StatefulWidget {
  Personne p ;
  Page_aide(this.p);
  @override
  _Page_aideState createState() => _Page_aideState();
}

class _Page_aideState extends State<Page_aide> {
 // static const _popItem = <String>["Modifier les paramétres du compte", "Supprimer le compte"];
 // static const _popItem2 = <String>["Modifier les paramétres du compte", "Supprimer le compte"];
 // static List<PopupMenuItem<String>> pop = _popItem
    //  .map((String val) => PopupMenuItem<String>(
   // value: val,
   // child: Text(val),
  //))
  //    .toList();
  String value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.violet,
        title: Text(
          "Page d'aide",
          style: TextStyle(
            fontFamily: 'Gilroy-ExtraBold',
            color: Color(0xffe0e5ec),
            fontSize: 26,

            fontStyle: FontStyle.normal,
          ),
          textAlign: TextAlign.start,
        ),
        leading: IconButton(
          alignment: Alignment.topLeft,
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 26,
          ),
          color: Color(0xffe0e5ec),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PagePrincipale(widget.p)),
            );
            print("retour");
          },
        ),

      ),
      body: Column(
        children: <Widget>[
          Text(
              '\n\tVeuillez visiter la page d\'aide de GoTrack via ce lien : \n'
              'https://gotrack---easy-go-easy-track-11.webself.net/aide ',
            style: TextStyle(
              fontFamily: 'Gilroy',
              color: Palette.violet,
              fontSize: 18,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.normal,
            ),

          )
        ],
      )

    );
  }
}
