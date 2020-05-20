import 'package:flutter_shapes/flutter_shapes.dart';
import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.black;
    Shapes shapes = Shapes(canvas: canvas, radius: 50, paint: paint, center: Offset.zero, angle: 0);

    shapes.drawCircle();                // method name
    shapes.drawType(ShapeType.Circle);  // enum
    shapes.draw('Circle');              // string
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return null;
  }
}