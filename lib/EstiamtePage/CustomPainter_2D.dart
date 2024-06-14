

import 'package:flutter/material.dart';

class CustomPaint2D extends StatefulWidget {
  //final ConstructSpotImage =  aaa
  @override
  State<CustomPaint2D> createState() => _CustomPaint2DState();
}

class _CustomPaint2DState extends State<CustomPaint2D> {
  int a =0;
  int b=0;

  @override
  Widget build(BuildContext context) {

    double childWidth = MediaQuery.of(context).size.width;
    double childHeight = MediaQuery.of(context).size.height*0.65;

    if(a == b) {
      childHeight = childWidth/childHeight * childHeight;
    }
    print(childWidth);
    print(childHeight);
    return Scaffold(
      appBar: AppBar(
        title: Text("그림 그리기"),
      ),
      body: Container(
        child : Column(
          children: <Widget> [
            Container(
              margin: EdgeInsets.only(left: 5, right: 5, top: 5.0),
              width : childWidth,
              height: childWidth/childHeight * childHeight,
              color: Colors.green,
              child : CustomPaint(
                size: Size(childWidth, childHeight), // 위젯의 크기를 정함. 
                foregroundPainter: MyPainter(), // painter에 그리기를 담당할 클래스를 넣음.
              ),
            ),
            Container(
            //  width : 100,
            //  height: 300*0.5,
              color: Colors.black,
            )
          ],
        
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
 /* void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
    ..color = Colors.deepPurpleAccent
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 5.0;

    Offset p1 = Offset(0.0, 20.0);
    Offset p2 = Offset(size.width, size.height);

    canvas.drawLine(p1, p2, paint);
   
    
  }*/
  /*
  void paint(Canvas canvas, Size size) {

    Paint paint = Paint()
      ..strokeWidth = 5
      ..color = Colors.deepPurpleAccent
      ..strokeCap = StrokeCap.round;
     // ..style = ui.PaintingStyle.stroke;
    
    Path path = Path()
      ..moveTo(10, 50)
      ..lineTo(10, 100)
      ..close();
      
     canvas.drawPath(path, paint);
  }
*/
/// x = 400, y = 500
 /*
  void paint(Canvas canvas, Size size) {
    print(" paint x: ${size.width}");
    print(" paint y: ${size.height}");
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    canvas.drawPath(getPath(size.width, size.height), paint);
  }

  Path getPath(double x, double y) {
    Path path = Path()
   /*   ..moveTo(x / 2, 0)
      ..lineTo(x, y / 3)
      ..lineTo(x, y)
      ..lineTo(0, y)
      ..lineTo(0, y / 3)
      ..close();*/
      
      ..moveTo(0, 0)
      ..lineTo(0, y)
      ..lineTo(x, y)
      ..lineTo(x, 0)
      ..close();
      

    return path;
  }
*/
   void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white // 선의 색
      ..strokeWidth = 3  // 선의 굵기
      ..style = PaintingStyle.stroke; // 안을 채우지않음
      // ..style = PaintingStyle.fill; // 안을 채움

    // left top(x,y) of rectangle
    final a = Offset(0, size.height * 1/4);
    // right down(x,y) of rectangle
    final b = Offset(size.width, size.height * 3/4);
    final rect = Rect.fromPoints(a, b);

    canvas.drawRect(
      rect,
      paint,
    );
  }
  @override
  //bool shouldRepaint(CustomPainter oldDelegate) {
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
  
}