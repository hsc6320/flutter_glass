import 'package:flutter/material.dart';
import 'package:glassapp/EstiamtePage/CanvasController.dart';

class DrawCanvasNode<T> {
  DrawCanvasNode({
    required this.key,
    required this.widgetKey,
    required this.sizeX,
    required this.sizeY,
    required this.offsetX,
    required this.offsetY,
    required this.isSelect,
    //required this.child,
    required this.label,
    this.allowResize = true,
    this.allowMove = true,
    this.clipBehavior = Clip.none,
    this.overlapXLine = false,
    this.overlapXLine2 = false,
    this.overlapXLine3 = false,
    this.overlapXLine4 = false,
    this.overlapYLine = false,
    this.overlapYLine2 = false,
    this.overlapYLine3 = false,
    this.overlapYLine4 = false,
    this.alreadyDraw = false,
    this.value,
    
  });

  String get id => key.toString();

  final UniqueKey key;
  final UniqueKey widgetKey;
  late double sizeX;
  late double sizeY;
  late double offsetX;
  late double offsetY;
  late String label;
  late bool alreadyDraw;
  T? value;
  //final Widget child;
  final bool allowResize, allowMove;
  final Clip clipBehavior;
  bool overlapXLine;
  bool overlapXLine2;
  bool overlapXLine3;
  bool overlapXLine4;
  bool overlapYLine;
  bool overlapYLine2;
  bool overlapYLine3;
  bool overlapYLine4;
  late  bool isSelect;
  
  

  String get ChangedLabel => label;
  double get ChangedPositionX => offsetX == 0 ? 10 : offsetX;
  double get ChangedPositionY => offsetY == 0 ? 10 : offsetY;
  double get ChangedSizeX => sizeX == 0 ? 50 : sizeX;
  double get ChangedSizeY => sizeY == 0 ? 50 : sizeY;
  
  void Changed_Label(String label) {
    this.label = label;
  }

  void ChangedPosition_Y(double PositionY) {
   //   print("ChangedPositionY : $PositionY");
      offsetY = PositionY;
  } 

  void ChangedPosition_X(double PositionX) {
    offsetX = PositionX;
  }

  void ChangedSize_X(double sizex) {
    sizeX = sizex;
  }

  void ChangedSize_Y(double sizey) {
    sizeY = sizey;
  }

  static const double dragHandleSize = 10;
  static const double borderInset = 2;
  
}


class Drawing_Cad2D extends CustomPainter {
  Drawing_Cad2D({
  //  required this.keyWidget,
    required this.FieldController,
    required this.node,
    required this.verifyNode,
    required this.verifyNode2,
    required this.aniMation,
    required this.anyTriger,
    required this.sliderScale,

  });
  final CanvasController FieldController;
  final List<DrawCanvasNode> node;
  final double verifyNode;
  final double verifyNode2;
  final double sliderScale;
  final double aniMation;
  late final bool anyTriger;
  
  int tempIdx =0;
  //final void Function() offsetBuilder;
  void _drawOutline(Canvas canvas, DrawCanvasNode nodelist) {
    Path path = Path();

    var oulinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = 1.0
      ..isAntiAlias = true;

    var oulinePaint2 = Paint()
      ..style = PaintingStyle.stroke
      ..color = Color.fromARGB(255, 177, 185, 226)
      ..strokeWidth = 1.0
      ..isAntiAlias = true;
    path.addRect(Rect.fromCenter(center: Offset(nodelist.offsetX/*+(nodelist.sizeX/2)*/, nodelist.offsetY/*+(nodelist.sizeY/2)*/), width: nodelist.sizeX*sliderScale, height: nodelist.sizeY*sliderScale));
    path.close();
    canvas.drawPath(path, oulinePaint);

    canvas.drawLine(Offset(nodelist.offsetX-200, nodelist.offsetY), Offset(nodelist.offsetX+200, nodelist.offsetY), oulinePaint2);
    canvas.drawLine(Offset(nodelist.offsetX, nodelist.offsetY-200), Offset(nodelist.offsetX, nodelist.offsetY+200), oulinePaint2);
  }

  void _drawNodes(Canvas canvas, DrawCanvasNode nodelist) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Color.fromARGB(198, 90, 255, 90)
      ..isAntiAlias = true;

    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 10,
    );

    Path path = Path();
    path.addRect(Rect.fromCenter(center: Offset(nodelist.offsetX, nodelist.offsetY), width: nodelist.sizeX*sliderScale, height: nodelist.sizeY*sliderScale));
    path.close();
    canvas.drawPath(path, paint);
    _drawText(canvas,nodelist.offsetX, nodelist.offsetY, "(${nodelist.label})", textStyle);
    _drawText(canvas, nodelist.offsetX-(nodelist.sizeX/2), nodelist.offsetY-(nodelist.sizeY/2), ("{${(nodelist.offsetX-(nodelist.sizeX/2)).toStringAsFixed(1)}, ${(nodelist.offsetY-(nodelist.sizeY/2)).toStringAsFixed(1)}"),  textStyle);
    _drawText(canvas, nodelist.offsetX+(nodelist.sizeX/2), nodelist.offsetY+(nodelist.sizeY/2), ("{${(nodelist.offsetX+(nodelist.sizeX/2)).toStringAsFixed(1)}, ${(nodelist.offsetY+(nodelist.sizeY/2)).toStringAsFixed(1)}}"), textStyle);
    
  }
  void _drawText(Canvas canvas, centerX, centerY, text, style) {
    final textSpan = TextSpan(
      text: text,
      style: style,
    );
    final textPainter = TextPainter()
      ..text = textSpan
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center
      ..layout();

    final xCenter = (centerX - textPainter.width / 2);
    final yCenter = (centerY - textPainter.height / 2);
    final offset = Offset(xCenter, yCenter);

    textPainter.paint(canvas, offset);
  }

  void _drawCanvas(Canvas canvas) {

   var overlapPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = 0.1
      ..isAntiAlias = true;

  const textStyle = TextStyle(
    color: Colors.black,
    fontSize: 10,
  );

  for(DrawCanvasNode nodelist in FieldController.nodes) {
    _drawNodes(canvas, nodelist);
    if(nodelist.isSelect) {
      _drawOutline(canvas, nodelist);
      _drawText(canvas,nodelist.offsetX, nodelist.offsetY-10, "(${nodelist.offsetX.toStringAsFixed(1)}, ${nodelist.offsetY.toStringAsFixed(1)})", textStyle);
      if(nodelist.overlapXLine) {
      //  print("nodelist.overlapXLine : ${nodelist.overlapXLine}, $verifyNode");
        canvas.drawLine(Offset(nodelist.offsetX-(nodelist.sizeX/2), nodelist.offsetY-200), Offset(nodelist.offsetX-(nodelist.sizeX/2), nodelist.offsetY+200), overlapPaint);
        nodelist.ChangedPosition_X(verifyNode);
        nodelist.overlapXLine = false;
      }
      if(nodelist.overlapXLine2) {
    //  print("nodelist.overlapXLine2 : ${nodelist.overlapXLine2} $verifyNode");
        canvas.drawLine(Offset(nodelist.offsetX+(nodelist.sizeX/2), nodelist.offsetY-200), Offset(nodelist.offsetX+(nodelist.sizeX/2), nodelist.offsetY+200), overlapPaint);
        nodelist.ChangedPosition_X(verifyNode);
        nodelist.overlapXLine2 = false;
      }
      if(nodelist.overlapXLine3) {
    //  print("nodelist.overlapXLine3 : ${nodelist.overlapXLine3} $verifyNode");
        canvas.drawLine(Offset(nodelist.offsetX+(nodelist.sizeX/2), nodelist.offsetY-200), Offset(nodelist.offsetX+(nodelist.sizeX/2), nodelist.offsetY+200), overlapPaint);
        nodelist.ChangedPosition_X(verifyNode);
        nodelist.overlapXLine3 = false;
      }
      if(nodelist.overlapXLine4) {
        canvas.drawLine(Offset(nodelist.offsetX-(nodelist.sizeX/2), nodelist.offsetY-200), Offset(nodelist.offsetX-(nodelist.sizeX/2), nodelist.offsetY+200), overlapPaint);
        nodelist.ChangedPosition_X(verifyNode);
        nodelist.overlapXLine4 = false;
      }

      if(nodelist.overlapYLine ) {
      //print("nodelist.overlapXLine : ${nodelist.overlapXLine}");
        canvas.drawLine(Offset(nodelist.offsetX-200, nodelist.offsetY-(nodelist.sizeY/2)), Offset(nodelist.offsetX+200, nodelist.offsetY-(nodelist.sizeY/2)), overlapPaint);
        nodelist.ChangedPosition_Y(verifyNode2);
        nodelist.overlapYLine = false;
      }
      if(nodelist.overlapYLine2) {
    //  print("nodelist.overlapYLine2 : ${nodelist.overlapYLine2} $verifyNode2");
        canvas.drawLine(Offset(nodelist.offsetX-200, nodelist.offsetY+(nodelist.sizeY/2)), Offset(nodelist.offsetX+nodelist.sizeX+200, nodelist.offsetY+(nodelist.sizeY/2)), overlapPaint);
        nodelist.ChangedPosition_Y(verifyNode2);
        nodelist.overlapYLine2 = false;
      }
      if(nodelist.overlapYLine3) {
      //print("nodelist.overlapYLine3 : ${nodelist.overlapYLine3} $verifyNode2");
        canvas.drawLine(Offset(nodelist.offsetX-200, nodelist.offsetY+(nodelist.sizeY/2)), Offset(nodelist.offsetX+nodelist.sizeX+200, nodelist.offsetY+(nodelist.sizeY/2)), overlapPaint);
        nodelist.ChangedPosition_Y(verifyNode2);
        nodelist.overlapYLine3 = false;
      }
      if(nodelist.overlapYLine4 ) {
  //    print("nodelist.overlapXLine4 : ${nodelist.overlapYLine4}");
        canvas.drawLine(Offset(nodelist.offsetX-200, nodelist.offsetY-(nodelist.sizeY/2)), Offset(nodelist.offsetX+200, nodelist.offsetY-(nodelist.sizeY/2)), overlapPaint);
        nodelist.ChangedPosition_Y(verifyNode2);
        nodelist.overlapYLine4 = false;
      }
    }
  }
     
  }
  @override
  void paint(Canvas canvas, Size size) {
    _drawCanvas(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}