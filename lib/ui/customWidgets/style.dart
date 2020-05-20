import 'package:flutter/material.dart';

InputDecoration myInputDecoration = InputDecoration(
    hintText: 'Email'
);
BoxDecoration myBoxDecoration = BoxDecoration(
  color: Color(0xffe0e5ec),
  borderRadius: BorderRadius.circular(0),
  boxShadow: [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.1),
      offset: Offset(-6, -2),
      blurRadius: 6.2,
      spreadRadius: 3,
    ),
    BoxShadow(
      color: Color.fromRGBO(250, 250, 250, 0.9),
      offset: Offset(6, 2),
      blurRadius: 6.2,
      spreadRadius: 3,
    ),
  ],
);