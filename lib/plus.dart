import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Plus extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint yellow = Paint()..color=Colors.amberAccent..strokeWidth=5;
    Paint greenPaint = Paint()..color=Colors.green..strokeWidth=5;
    Paint bluePaint = Paint()..color=Colors.blue..strokeWidth=5;
    Paint redPaint = Paint()..color=Colors.red..strokeWidth=5;

    canvas.drawLine(Offset(size.width * 0.27, size.height * 0.5),
        Offset(size.width * 0.5 , size.height * 0.5),yellow);

    canvas.drawLine(Offset(size.width * 0.5, size.height * 0.5),
        Offset(size.width * 0.5 , size.height-(size.height * 0.27)), greenPaint);

    canvas.drawLine(Offset(size.width * 0.5, size.height * 0.5),
        Offset(size.width -(size.width * 0.27) , size.height * 0.5), bluePaint);

    canvas.drawLine(Offset(size.width * 0.5, size.height * 0.5),
        Offset(size.width * 0.5 , size.height * 0.27), redPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
  @override
  bool shouldRebuildSemantics(Plus oldDelegate) => false;

}