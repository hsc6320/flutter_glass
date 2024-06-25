

//import 'dart:ffi';
//import 'dart:math';

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:glassapp/EstiamtePage/EstimatePostModel.dart';


enum Options { option1, option2, option3, option4, }
// ignore: must_be_immutable
class OptionChoicepage extends StatefulWidget {

  @override
  State<OptionChoicepage> createState() => _OptionChoicepageState();
}

class _OptionChoicepageState extends State<OptionChoicepage> {
  Options? _selectedOption = Options.option1;
  String AreaX = ''; 
  String AreaY = '';
  
  bool isSelect = false;
  Future<bool> ShowTempSaveDialog () async {
    return await showDialog (
      barrierDismissible: false,
      context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Get out?'),
            content: Text("저장되지 않습니다. 나가시겠습니까?"),
            actions: <Widget> [
              TextButton(
                child: const Text('Got it'),
                onPressed: () {
                  Navigator.pop(context, true);
                }
              ),
              TextButton(
                child: const Text('Nope'),
                onPressed: () => Navigator.pop(context, false),
              ),
            ],
          );
        },
    );
  }
  @override
  Widget build(BuildContext context) {
  double MaxWidth = MediaQuery.of(context).size.width;
  double MaxHeight = MediaQuery.of(context).size.height;
  print('width : $MaxWidth');
  print('height : $MaxHeight');
    return  WillPopScope (
      onWillPop: () async {
      //  isPortrait = false;
      //  return await DisplayRotation(); 
        return ShowTempSaveDialog();
      }, 
      child : Scaffold(
   //   appBar: AppBar(
   //       title: Text("면적 선택"),
   //     ),
      body : SafeArea (
        minimum: EdgeInsets.all(1),
      child :Container(
        color: Color.fromARGB(255, 247, 247, 243),
        padding: EdgeInsets.only(top: 5, right: 3),
        width : MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child : Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children : <Widget> [
            Container( 
              height:1.0,
              width : MediaQuery.of(context).size.width,
              color:Colors.black,
            ),
            Container(
              margin:  EdgeInsets.only(top : 5),
              padding: EdgeInsets.all(5),
            //  decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
              decoration: BoxDecoration (
                border: Border.symmetric(horizontal: BorderSide(color: Colors.black, width: 1))
              ),
        //      color: Colors.blue,
              child : Row (
                children: [
                Container(
                  margin: EdgeInsets.only(left: 2, top: 0),
                  padding: EdgeInsets.only(top: 65),
          //        color: Colors.red,
                  width: MediaQuery.of(context).size.width*0.36,
                  height: MediaQuery.of(context).size.height*0.2, //Constraints.heightConstraints().maxHeight,
                    child : RadioListTile<Options>(
                      title: Text('정사각형'),
                      value: Options.option1, 
                      groupValue: _selectedOption, 
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value;
                        });
                      },
                    ),
                ), 
                Container (
                  width: MediaQuery.of(context).size.width*0.51,//Constrints.widthConstraints().maxWidth,
                  height: MediaQuery.of(context).size.height*0.2, //Constraints.heightConstraints().maxHeight,
                  margin: EdgeInsets.only(left: 18),
          //        color: Colors.yellow,
                  child : CustomPaint (
                      foregroundPainter: SqurePaint(), // painter에 그리기를 담당할 클래스를 넣음.
                    ), 
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top : 5),
              padding: EdgeInsets.all(10),
            //  decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
              decoration: BoxDecoration (
                border: Border.symmetric(horizontal: BorderSide(color: Colors.black, width: 1))
              ),
            //  color: Colors.blue,
              child : Row (
                children: [
                  Container (
                    margin: EdgeInsets.only(left: 2, top: 0),
                    padding: EdgeInsets.only(top: 40),
            //        color: Colors.red,
                    width: MediaQuery.of(context).size.width*0.36,
                    height: MediaQuery.of(context).size.height*0.15, //Constraints.heightConstraints().maxHeight,
                    child : RadioListTile<Options>(
                      title: Text('직사각형'),
                      value: Options.option2, 
                      groupValue: _selectedOption, 
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value;
                        });
                      },
                    ),
                  ), 
                  Container (
                    width: MediaQuery.of(context).size.width*0.55,//Constraints.widthConstraints().maxWidth,
                    height: MediaQuery.of(context).size.height*0.15, //Constraints.heightConstraints().maxHeight,
                    margin: EdgeInsets.only(left: 10,),
             //       color: Colors.yellow,
                    child : CustomPaint (
                    //  size: Size(300, 200), // 위젯의 크기를 정함. 
                      foregroundPainter: Rectanglepaint(), // painter에 그리기를 담당할 클래스를 넣음.
                    ), 
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top : 5),
              padding: EdgeInsets.all(10),
            //  decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
              decoration: BoxDecoration (
                border: Border.symmetric(horizontal: BorderSide(color: Colors.black, width: 1))
              ),
          //    color: Colors.blue,
              child : Row (
                children: [
                  Container (
                    margin: EdgeInsets.only(left: 2, top: 0),
                    padding: EdgeInsets.only(top: 45),
                //    color: Colors.red,
                    width: MediaQuery.of(context).size.width*0.36,
                    height: MediaQuery.of(context).size.height*0.16, //Constraints.heightConstraints().maxHeight,
                    child : RadioListTile<Options>(
                      title: Text('타원형'),
                      value: Options.option3, 
                      groupValue: _selectedOption, 
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value;
                          print("_selectedOption : $_selectedOption");
                        });
                      },
                    ),
                  ), 
                  Container (
                    width: MediaQuery.of(context).size.width*0.55,//Constraints.widthConstraints().maxWidth,
                    height: MediaQuery.of(context).size.height*0.16, //Constraints.heightConstraints().maxHeight,
                    margin: EdgeInsets.only(left: 10,),
                 //   color: Colors.yellow,
                    child : CustomPaint (
                    //  size: Size(300, 200), // 위젯의 크기를 정함. 
                    foregroundPainter: OvalPaint(), // painter에 그리기를 담당할 클래스를 넣음.
                    ), 
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top : 5),
              //padding: EdgeInsets.all(1),
              decoration: BoxDecoration (
                border: Border.symmetric(horizontal: BorderSide(color: Colors.black, width: 1))
              ),
           //   color: Colors.blue,
              child : Row(
                children: [
                  Container (
                    margin: EdgeInsets.only(left: 3, top: 0),
                    padding: EdgeInsets.only(top: 20),
               //     color: Colors.red,
                    width: MediaQuery.of(context).size.width*0.98,
                    height: MediaQuery.of(context).size.height*0.1, //Constraints.heightConstraints().maxHeight,
                    child : RadioListTile<Options>(
                      title: Text('직접 그리기'),
                      value: Options.option4, 
                      groupValue: _selectedOption, 
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value;
                        });
                      },
                    ),
                  ), 
                /*  Container (
                    width: MediaQuery.of(context).size.width*0.55,//Constraints.widthConstraints().maxWidth,
                    height: MediaQuery.of(context).size.height*0.16, //Constraints.heightConstraints().maxHeight,
                    margin: EdgeInsets.only(left: 10,),
                    color: Colors.yellow,
                    child : CustomPaint (
                    //  size: Size(300, 200), // 위젯의 크기를 정함. 
                    foregroundPainter: OvalPaint(), // painter에 그리기를 담당할 클래스를 넣음.
                    ), 
                  ),*/
                ],

              ),
            ),
            Container( 
              margin: EdgeInsets.only(top:3),
              height:1.0,
              width:MediaQuery.of(context).size.width,
              color:Colors.black,
            ),
            const SizedBox(
                height: 10,
            ),
            Row(
              children : <Widget> [
                Container (
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.only(left: 7),
                  width:  MediaQuery.of(context).size.width*0.4,
                  height: MediaQuery.of(context).size.height*0.075,
                  child : FormBuilderTextField (
                    name: 'widtharea',
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                    //  hintText: 'YY/MM/DD',
                      labelText: '가로 길이(단위 : M)',
                    ),
                   onChanged: (val) {
                      setState(() {
                        AreaX = val!;
                        print("onSaved : $val, $AreaX");
                      });
                    },
                  ),
                  
                ),
                Spacer(
                  flex: 1,
                ),
                Container (
                  //alignment: Alignment.bottomLeft,
                  width:  MediaQuery.of(context).size.width*0.4,
                  height: MediaQuery.of(context).size.height*0.075,
                  child : FormBuilderTextField (
                    name: 'heightarea',
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                    //  hintText: 'YY/MM/DD',
                      labelText: '세로 길이(단위 : M)',
                    ),
                    onChanged: (val) {
                      setState(() {
                        AreaY = val!;
                        print("onSaved : $val, $AreaY");
                      });
                    },
                  ),
                  
                ),
              ],
            ),
            const SizedBox(
                height: 40,
            ),
            Row(
              children: [
                SizedBox (
                  width: MediaQuery.of(context).size.width*0.48,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 139, 231, 181),  
                        surfaceTintColor: Color.fromARGB(255, 3, 199, 90),  
                        foregroundColor: Colors.black,
                    ),
                    child: Text(
                      "확인",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      ShapeChoiceArea shapeArea = ShapeChoiceArea(AreaX: AreaX, AreaY: AreaY, sports: _selectedOption.toString(),);
                      print("직접 입력 : $AreaX, $AreaY");
                      Navigator.of(context).pop(shapeArea);
                    },
                  ),
                ), 
                  Spacer(
                      flex: 1,
                    ),
                SizedBox (
                  width: MediaQuery.of(context).size.width*0.48,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 139, 231, 181),  
                        surfaceTintColor: Color.fromARGB(255, 3, 199, 90),  
                        foregroundColor: Colors.black,
                    ),
                    child: Text(
                      "취소",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ), 
              ],
            ),
          ],
        ),

        
      ),
      ),
    ),
    );
  }
}


class SqurePaint extends CustomPainter {
  double textScaleFactor = 1.0;

  void drawRowText(Canvas canvas, Size size, String text) {
    //double fontSize = getFontSize(size, text);

    TextSpan sp = TextSpan(style: TextStyle(fontSize: 20, /*fontWeight: FontWeight.bold,*/ color: Colors.black), text: text); // TextSpan은 Text위젯과 거의 동일하다. 
    TextPainter tp = TextPainter(text: sp, textDirection: TextDirection.ltr);

    tp.layout(); // 필수! 텍스트 페인터에 그려질 텍스트의 크기와 방향를 정함.
    
    double dx = size.width / 2 - tp.width/2;
    double dy = size.height*0.05;// - tp.height*0.05;
    Offset offset = Offset(dx, dy); 
    tp.paint(canvas, offset);
  }

  void drawColumnText(Canvas canvas, Size size, String text) {
    //double fontSize = getFontSize(size, text);

    TextSpan sp = TextSpan(style: TextStyle(fontSize: 20, /*fontWeight: FontWeight.bold,*/ color: Colors.black), text: text); // TextSpan은 Text위젯과 거의 동일하다. 
    TextPainter tp = TextPainter(text: sp, textDirection: TextDirection.ltr);

    tp.layout(); // 필수! 텍스트 페인터에 그려질 텍스트의 크기와 방향를 정함.
    
    double dx = size.width*0.03;// - tp.width/2;
    double dy = size.height*0.4;// - tp.height*0.05;
    Offset offset = Offset(dx, dy); 
    tp.paint(canvas, offset);
  }
  double getFontSize(Size size, String text) {
    return size.width / text.length * textScaleFactor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black // 선의 색
      ..strokeWidth = 3  // 선의 굵기
      //..isAntiAlias = true
      ..style = PaintingStyle.stroke; // 안을 채움
      // ..style = PaintingStyle.stroke; // 안을 채우지않음
     final paint2 = Paint()
      ..color = Colors.deepPurpleAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

      Offset p1 = Offset(0.0, 10.0);
      Offset p2 = Offset(size.width, 10.0);
    
      canvas.drawLine(p1, p2, paint2);
      
       final paint3 = Paint()
      ..color = Colors.deepPurpleAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

      Offset p3 = Offset(10.0, 0);
      Offset p4 = Offset(10.0, size.height);
    
      canvas.drawLine(p3, p4, paint3);

      drawRowText(canvas, size, " 가로"); // 텍스트를 화면에 표시함.
      drawColumnText(canvas, size, " 세로"); // 텍스트를 화면에 표시함.
      //print('정사각형 사이즈 : ${size.width}, ${size.height}');
      Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
      canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
class Rectanglepaint extends CustomPainter {

  void drawRowText(Canvas canvas, Size size, String text) {
    //double fontSize = getFontSize(size, text);

    TextSpan sp = TextSpan(style: TextStyle(fontSize: 20, /*fontWeight: FontWeight.bold,*/ color: Colors.black), text: text); // TextSpan은 Text위젯과 거의 동일하다. 
    TextPainter tp = TextPainter(text: sp, textDirection: TextDirection.ltr);

    tp.layout(); // 필수! 텍스트 페인터에 그려질 텍스트의 크기와 방향를 정함.
    
    double dx = size.width / 2 - tp.width/2;
    double dy = size.height*0.05;// - tp.height*0.05;
    Offset offset = Offset(dx, dy); 
    tp.paint(canvas, offset);
  }

  void drawColumnText(Canvas canvas, Size size, String text) {
    //double fontSize = getFontSize(size, text);

    TextSpan sp = TextSpan(style: TextStyle(fontSize: 20, /*fontWeight: FontWeight.bold,*/ color: Colors.black), text: text); // TextSpan은 Text위젯과 거의 동일하다. 
    TextPainter tp = TextPainter(text: sp, textDirection: TextDirection.ltr);

    tp.layout(); // 필수! 텍스트 페인터에 그려질 텍스트의 크기와 방향를 정함.
    
    double dx = size.width*0.03;// - tp.width/2;
    double dy = size.height*0.4;// - tp.height*0.05;
    Offset offset = Offset(dx, dy); 
    tp.paint(canvas, offset);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black // 선의 색
      ..strokeWidth = 3  // 선의 굵기
      //..isAntiAlias = true
      ..style = PaintingStyle.stroke; // 안을 채움
      // ..style = PaintingStyle.stroke; // 안을 채우지않음
    
   //   print('직사이즈 : ${size.width}, ${size.height}');
      Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
      canvas.drawRect(rect, paint);

      final paint2 = Paint()
      ..color = Colors.deepPurpleAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

      Offset p1 = Offset(0.0, 10.0);
      Offset p2 = Offset(size.width, 10.0);
    
      canvas.drawLine(p1, p2, paint2);
      
       final paint3 = Paint()
      ..color = Colors.deepPurpleAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

      Offset p3 = Offset(10.0, 0);
      Offset p4 = Offset(10.0, size.height);
    
      canvas.drawLine(p3, p4, paint3);

      drawColumnText(canvas, size, "세로");
      drawRowText(canvas, size, "가로");
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class OvalPaint extends CustomPainter {
  

  void drawRowText(Canvas canvas, Size size, String text) {
    //double fontSize = getFontSize(size, text);

    TextSpan sp = TextSpan(style: TextStyle(fontSize: 20, /*fontWeight: FontWeight.bold,*/ color: Colors.black), text: text); // TextSpan은 Text위젯과 거의 동일하다. 
    TextPainter tp = TextPainter(text: sp, textDirection: TextDirection.ltr);

    tp.layout(); // 필수! 텍스트 페인터에 그려질 텍스트의 크기와 방향를 정함.
    
    double dx = size.width / 2 - tp.width/2;
    double dy = size.height*0.5;// - tp.height*0.05;
    Offset offset = Offset(dx, dy); 
    tp.paint(canvas, offset);
  }

  void drawColumnText(Canvas canvas, Size size, String text) {
    //double fontSize = getFontSize(size, text);

    TextSpan sp = TextSpan(style: TextStyle(fontSize: 20, /*fontWeight: FontWeight.bold,*/ color: Colors.black), text: text); // TextSpan은 Text위젯과 거의 동일하다. 
    TextPainter tp = TextPainter(text: sp, textDirection: TextDirection.ltr);

    tp.layout(); // 필수! 텍스트 페인터에 그려질 텍스트의 크기와 방향를 정함.
    
    double dx = size.width*0.05;// - tp.width/2;
    double dy = size.height*0.3;// - tp.height*0.05;
    Offset offset = Offset(dx, dy); 
    tp.paint(canvas, offset);
  }

  void paint(Canvas canvas, Size size) {
   // Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final paint = Paint()
      ..color = Colors.black // 선의 색
      ..strokeWidth = 3  // 선의 굵기
      //..isAntiAlias = true
      ..style = PaintingStyle.stroke; // 안을 채움

    Path path = Path()
      ..moveTo(w*0.2, 0)
      ..quadraticBezierTo(-40, h*0.5, w*0.2, h)
      ..lineTo(w*0.8, h)
      ..quadraticBezierTo(w*1.17, h*0.5, w*0.8, 0)
     // ..lineTo(0, h)
      ..close();

    drawColumnText(canvas, size, '세로');
    drawRowText(canvas, size, '가로');
    canvas.drawPath(path, paint);

    final paint2 = Paint()
      ..color = Colors.deepPurpleAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

      Offset p1 = Offset(0, size.height*0.5);
      Offset p2 = Offset(size.width, size.height*0.5);
    
      canvas.drawLine(p1, p2, paint2);
      
       final paint3 = Paint()
      ..color = Colors.deepPurpleAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

      Offset p3 = Offset(size.width*0.2, 0);
      Offset p4 = Offset(size.width*0.2, size.height);
    
      canvas.drawLine(p3, p4, paint3);
      
  //  return path;
//  }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}


class ShapeChoiceArea {
  final String AreaX;
  final String AreaY;
  final String sports;
  
  const ShapeChoiceArea({required this.AreaX, required this.AreaY, required this.sports});
}

class CustomPaint2D extends StatefulWidget {
  final ConstructSpotImage EstimateInfo;
  CustomPaint2D({Key? key, required this.EstimateInfo, /* required this.totalArea_Y,*/ }) : super(key: key);

  @override
  State<CustomPaint2D> createState() => _CustomPaint2DState();
}

class _CustomPaint2DState extends State<CustomPaint2D> {
  bool isPortrait = false;

  bool _DisplayRotation() {
    SystemChrome.setPreferredOrientations (
    isPortrait
      ? [
          DeviceOrientation.landscapeRight,
        ]
      : [
          DeviceOrientation.portraitUp,
        ],
  ).then((value) {
    SystemChrome.setPreferredOrientations(
      isPortrait
        ? [
            DeviceOrientation.landscapeRight,
            DeviceOrientation.portraitUp,
            
          ]
        : [
            DeviceOrientation.portraitUp,
            DeviceOrientation.landscapeRight,
          ],
    );
  });
  return true;
  }
  Future<bool> DisplayRotation() async {
    return await _DisplayRotation();
  }

  @override
  Widget build(BuildContext context) {

    double MaxWidth = MediaQuery.of(context).size.width;
    double MaxHeight = MediaQuery.of(context).size.height*0.6;
    print("전체 가로 : $MaxWidth, 전체 세로 : $MaxHeight");
    double EstimateX = double.parse(widget.EstimateInfo.Estimate_Area_X);
    double EstimateY = double.parse(widget.EstimateInfo.Estimate_Area_Y);


    print("가로 면적11");
    print(EstimateX);
    print("세로 면적11");
    print(EstimateY);
   
    return  WillPopScope (
      onWillPop: () async {
        isPortrait = false;
        return await DisplayRotation(); 
      }, 
      child: Scaffold(
        appBar: AppBar(
          title: Text("그림 그리기"),
        ),
        body: Container(
          color: Color.fromARGB(255, 242, 240, 211),
          width : MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.95,
          child : SingleChildScrollView (
            child : Column (
              children: <Widget> [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 5, right: 5, top: 20.0),
                  width : MaxWidth,
                  height: MaxHeight,
                  padding: EdgeInsets.only(left: 1, top: 5, right: 1, bottom: 1),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color:  Colors.white,
                  ),
                  child : LayoutBuilder(
                    builder: (_, Constraints)=> Container (
                      width: Constraints.widthConstraints().maxWidth,
                      height: Constraints.heightConstraints().maxHeight,
                      child : CustomPaint (
                        size: Size(MaxWidth, MaxHeight), // 위젯의 크기를 정함. 
                          //size: Size(),
                          foregroundPainter: MyPainter(CustomPaint_X: EstimateX, CustomPaint_Y: EstimateY, Maxwidth: MaxWidth, MaxHeight: MaxHeight), // painter에 그리기를 담당할 클래스를 넣음.
                        ),
                    ),
                  )
                ),
                Container(
                  width : 100,
                  height: 3,
                  color: Colors.black,
                ),
              ],
            
            ),
          ),
        ),
        floatingActionButton: Stack (
          children: <Widget> [
          Align (
            alignment: Alignment.bottomRight,
            child : FloatingActionButton(
              child: Icon(Icons.screen_rotation),
              heroTag: 'rotation',
              onPressed: () { isPortrait = !isPortrait; DisplayRotation(); },
              elevation: 10,
            ), 
          ),
          ]
        ), 
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final CustomPaint_X;
  final CustomPaint_Y;
  final Maxwidth;
  final MaxHeight;

  MyPainter({required this.CustomPaint_X, required this.CustomPaint_Y, required this.Maxwidth, required this.MaxHeight, });
  
  var _width = 0.0;
  var _height = 0.0;
  
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

  void DrawRectacgle(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.lightGreen // 선의 색
      ..strokeWidth = 1  // 선의 굵기
      //..isAntiAlias = true
      ..style = PaintingStyle.fill; // 안을 채움
      // ..style = PaintingStyle.stroke; // 안을 채우지않음
    
    // left top(x,y) of rectangle
    //final a = Offset(size.width *0.05, size.height*0.08);
    // right down(x,y) of rectangle
    //final b = Offset(size.width*0.95, size.height*0.98);

    double a = CustomPaint_X*5;
    double b = CustomPaint_Y*5;

    if(CustomPaint_X >= 100 || CustomPaint_Y >= 100) {
      a = CustomPaint_X;
      b = CustomPaint_Y;
    }

     final center, rect, radius;
    if(_width > _height) {
      center = Offset(_width/2, _height/2);
      rect = Rect.fromCenter(center: center, width: a, height: b);
      radius = Radius.circular(7);
    }
    else {
      center = Offset(_width/2, _height/2);
      rect = Rect.fromCenter(center: center, width: a, height: b);
      radius = Radius.circular(7);
    }
    

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, radius),
      paint,
    );


/*
///가운데에서 부터 시작해 그림 그리기
    final center = Offset(size.width, size.height);
    
    canvas.save(); // 1
    canvas.translate(center.dx, center.dy); // 2
    canvas.drawRect( // 3
      Rect.fromPoints(
        Offset(-_width/2, -_height / 2),
        Offset(_width/2, _height /2),
      ),
      paint,
    );
    canvas.restore(); // 4`
    */
  }
  
  void DrawLine(Canvas canvas) {

    Paint paint2 = Paint()
      ..strokeWidth = 3
      ..color = Colors.black  // 선의 굵기
      ..style = PaintingStyle.stroke; // 안을 채우지않음
     // ..style = ui.PaintingStyle.stroke;
      
      canvas.drawPath(getPath(_width, _height), paint2);
  }
  Path getPath(double x, double y) {
      Path path = Path()
     /* ..moveTo(60, 50)
      ..lineTo(10, 100)
      ..close();*/
        
        ..moveTo(x / 2, 0)
      ..lineTo(x, y / 3)
      ..lineTo(x, y)
      ..lineTo(0, y)
      ..lineTo(0, y / 3)
      ..close(); 

      return path;
  }
  @override
  void paint(Canvas canvas, Size size) {
    _width = size.width*0.98;
    _height = size.height*0.98;
    print("size: $size");
    
    DrawRectacgle(canvas, size);
    DrawLine(canvas);
  }

  @override
  //bool shouldRepaint(CustomPainter oldDelegate) {
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
  
}