import 'package:flutter/material.dart';
import 'message_model.dart';
import 'Boite_rec.dart';
import 'recent_chat.dart';


class GroupeMembres extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical:10.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Text('Membres',
                  style: TextStyle(fontFamily: 'Gilroy',
                      color: Color(0xff4b00e9),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                  )
              ),
              IconButton(
                icon: Icon(Icons.more_horiz,
                ),
                iconSize: 30.0,
                color: Color(0xff4b00e9),
                onPressed: (){},
              )
            ],

            ),
          ),
          Container(
            height: 100.0,
            color: Color(0xffe0e5ec),
            child: ListView.builder(
              padding: EdgeInsets.only(left: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: membres.length,
                itemBuilder: (BuildContext contextn, int index){
                return GestureDetector(
                  onTap:() => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_)=> BoiteReception(
                            user: membres[index],)
                      )
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 25.0,
                          //backgroundImage: AssetImage(membres[index].photo),

                        ),
                        SizedBox(height: 6.0),
                        Text(membres[index].compte.userName,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16.0
                        ),),
                      ],

                    ),

                  ),
                );
            },
            )
          )
        ],
      ),
    );
  }
}
