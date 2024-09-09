
import 'package:flutter/material.dart';
import 'package:glassapp/EstiamtePage/CanvasController.dart';
import 'package:glassapp/EstiamtePage/CustomPaintFunc.dart';
import 'package:glassapp/EstiamtePage/CustomPaintFunc2.dart';

double EndPosX_Coordi =0;
bool flagExit = false;
Map<String, bool> mapLabelCheck = {};
DrawCanvasNode? endXPointing, endYPointing, startingPointX, startingPointY;
DrawCanvasNode? startingPoint;

class DrawViewSettings {
  DrawViewSettings({
    required bool viewAll,
    required bool viewX ,
    required bool viewY,
    required bool viewLine,
  }) :   _viewX = viewX,
        _viewY = viewY,
        _viewLine = viewLine,
        _viewAll = viewAll;

  bool _viewX;
  bool _viewY;
  bool _viewAll;
  bool _viewLine;

  bool get viewX => _viewX;
  set viewX(bool value) {
    _viewX = viewX;
  }

  bool get viewY => _viewY;
  set viewY(bool value) {
    _viewY = viewY;
  }

  bool get viewAll => _viewAll;
  set viewAll(bool value) {
    _viewAll = value;
    
  }

  bool get viewLine => _viewLine;
  set viewLine(bool value) { 
    _viewLine = value;
  }
  
}

class DrawCanvasNode<T> {
  DrawCanvasNode({
    required this.key,
    required this.widgetKey,
    required this.sizeX,
    required this.sizeY,
    required this.offsetX,
    required this.offsetY,
    required this.isSelect,
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
    //required this.child,
  });

  //final Widget child;
  final UniqueKey key;
  final UniqueKey widgetKey;
  late double sizeX;
  late double sizeY;
  late double offsetX;
  late double offsetY;
  late String label;
  late bool alreadyDraw;
  T? value;
  final bool allowResize, allowMove;
  final Clip clipBehavior;
  double _scaleX =100;
  double _scaleY = 100;
  double _scaleOffsetLeft = 50;
  double _scaleOffsetRight = 50;
  double _scaleOffsetTop = 50;
  double _scaleOffsetBottom = 50;
  double _scaleValue =1;

  bool overlapXLine;
  bool overlapXLine2;
  bool overlapXLine3;
  bool overlapXLine4;
  bool overlapYLine;
  bool overlapYLine2;
  bool overlapYLine3;
  bool overlapYLine4;
  late bool isSelect;
  

  String get id => key.toString();
  String get ChangedLabel => label;
  double get Scale => _scaleValue;
  double get ChangedPositionX => offsetX == 0 ? 10 : offsetX;
  double get ChangedPositionY => offsetY == 0 ? 10 : offsetY;
  double get SizeX => _scaleX;
  double get SizeY => _scaleY;
  double get OffsetLeft =>double.parse(_scaleOffsetLeft.toStringAsFixed(1));
  double get OffsetRight =>double.parse(_scaleOffsetRight.toStringAsFixed(1));
  double get OffsetTop => double.parse(_scaleOffsetTop.toStringAsFixed(1));
  double get OffsetBottom => double.parse(_scaleOffsetBottom.toStringAsFixed(1));
  double get OffsetX => offsetX;
  double get OffsetY => offsetY;

  double get Diamension {
    return OffsetLeft*OffsetTop;
  }

  double get verticalTemp {
    return OffsetTop;
  }

  double get horizontalLength {
    if(_scaleOffsetLeft > _scaleOffsetRight) {
      return _scaleOffsetLeft - _scaleOffsetRight;  
    }
    else {
      return _scaleOffsetRight - _scaleOffsetLeft;  
    }
  } 
  double get verticalLength {
    if(_scaleOffsetTop > _scaleOffsetBottom) {
      return _scaleOffsetTop - _scaleOffsetBottom;
    }
    else {
      return _scaleOffsetBottom - _scaleOffsetTop;
    }
  }
  double get diagramDimension {
    return horizontalLength * verticalLength;
   //return SizeX * SizeY;
  }

  void Changed_Label(String label) {
    this.label = label;
  }

  void ChangedPosition_Y(double PositionY) {
    offsetY = PositionY;
    //print("setX $offsetY,  _scaleX ${_scaleX}, _scaleY ${_scaleY}, sizeX : $sizeX, sizeY $sizeY, scale $_scaleValue");
    _scaleOffsetTop = offsetY-(_scaleY/2);
    _scaleOffsetBottom = offsetY+(_scaleY/2);
    //print("WidgetKey : ${this.widgetKey} label : $label, offsetX : $offsetY OffsetX : $OffsetY, _scaleOffsetTop : $_scaleOffsetTop");;
  } 

  void ChangedPosition_X(double PositionX) {
    offsetX = PositionX;
    //print("setX $offsetX,  _scaleX ${_scaleX}, _scaleY ${_scaleY}, sizeX : $sizeX, sizeY $sizeY, scale $_scaleValue");
    _scaleOffsetLeft = offsetX-(_scaleX/2);
    _scaleOffsetRight = offsetX+(_scaleX/2);
    //print("WidgetKey : ${this.widgetKey} label : $label, offsetX : $offsetX OffsetX : $OffsetX, _scaleOffsetLeft : $_scaleOffsetLeft");
  }

  void ChangedSize_X(double sizex) {
    sizeX = sizex;
    _scaleX = sizeX*_scaleValue;
    print("_scaleX : $_scaleX, OffsetX : $OffsetX");
    _scaleOffsetLeft = OffsetX-(SizeX/2);
    _scaleOffsetRight = OffsetX+(SizeX/2);
    print("ChangedSize_X() : OffsetLeft : $OffsetLeft, OffsetRight : $OffsetRight");
  }

  void ChangedSize_Y(double sizey) {
    sizeY = sizey;
    _scaleY = sizey*_scaleValue;
  }

  void ChangedScale(double scale) {
    _scaleX = sizeX*scale;
    _scaleY = sizeY*scale;
    _scaleValue = scale;
    _scaleOffsetLeft = offsetX-(_scaleX/2);
    _scaleOffsetRight = offsetX+(_scaleX/2);
    _scaleOffsetTop = offsetY-(_scaleY/2);
    _scaleOffsetBottom = offsetY+(_scaleY/2);
  }

  void ChangedScaleOffset(double setX, double setY) {
    offsetX = setX;
    offsetY = setY;
   // print("setX $offsetX, setY $offsetY, _scaleX ${_scaleX}, _scaleY ${_scaleY}, sizeX : $sizeX, sizeY $sizeY, scale $_scaleValue");
    _scaleOffsetLeft = offsetX-(_scaleX/2);
    _scaleOffsetRight = offsetX+(_scaleX/2);
    _scaleOffsetTop = offsetY-(_scaleY/2);
    _scaleOffsetBottom = offsetY+(_scaleY/2);
   // print("ChangedScaleOffset : left : ${_scaleOffsetLeft}, Right : ${_scaleOffsetRight} _scaleOffsetTop :${_scaleOffsetTop}, _scaleOffsetBottom : ${_scaleOffsetBottom}");
   
  }
  void canvasNodePrint() {
    print("print() label : $label,  offsetX $offsetX, offsetY : $offsetY, _scaleOffsetLeft : $_scaleOffsetLeft, _scaleOffsetRight : $_scaleOffsetRight");
    print("print() sizeX : $sizeX, sizeY : $sizeY, _scaleX : $_scaleX, _scaleY : $_scaleY, _scaleOffsetTop : $_scaleOffsetTop, _scaleOffsetBottom : $_scaleOffsetBottom");
  }
  static const double dragHandleSize = 10;
  static const double borderInset = 2;
  
}

class EachOffsetPoint {
  DrawCanvasNode endXPointing, endYPointing, startingPointX, startingPointY;
  DrawCanvasNode startingPoint;
  int loopCnt =0;
  bool flagStartY = false, flagStartX = false, flagEndX = false, flagEndY = false;
  
  EachOffsetPoint(this.endXPointing,this.endYPointing, this.startingPointX,this.startingPointY, this.startingPoint);

}


class Drawing_Cad2D extends CustomPainter {
  Drawing_Cad2D({
  //  required this.keyWidget,
    required this.FieldController,
    required this.verifyNode,
    required this.verifyNode2,
    required this.viewSetting,
  });
  final DrawViewSettings viewSetting;
  final CanvasController FieldController;
  
  final double verifyNode;
  final double verifyNode2;
  
  
  listOffsetTBLR ListOffsetFunc = new listOffsetTBLR();

  var nodePaint = Paint()
    ..style = PaintingStyle.fill
    ..color = Color.fromARGB(198, 90, 255, 90)
    ..isAntiAlias = true;

  void _drawViewLine(Canvas canvas) {
    var viewPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Color.fromARGB(255, 141, 164, 152)
      ..strokeWidth = 2
      ..isAntiAlias = true;

    EndPosX_Coordi =0;
    
    bool isSelct = false;
   // CalculateRowAxis calcurateX = CalculateRowAxis( FieldController);


    for(DrawCanvasNode node in FieldController.nodes) { 
      if(node.isSelect == true)
        isSelct = true;;
    }
    if(isSelct == true) return;
    
    for(DrawCanvasNode node in FieldController.nodes) {
      mapLabelCheck[node.label] = false;
    }
    
    /*endXPointing = calcurateX.CalculateEndXPoint();
    endYPointing = calcurateX.CalculateEndYPoint();
    startingPointX = calcurateX.CalculateStartingPointX();
    startingPointY = calcurateX.CalculateStartingPointY();
    
    startingPoint = startingPointX;*/

    
  //  EachOffsetPoint eachOffsetPoint = EachOffsetPoint(endXPointing!, endYPointing!, startingPointX!, startingPointY!, startingPoint!);
    
    /*print("endXPoint : ${eachOffsetPoint.endXPointing.label}");
    print("endYPointing : ${eachOffsetPoint.endYPointing.label}");
    print("startingPointY : ${eachOffsetPoint.startingPointY.label}");
    print("startingPointX : ${eachOffsetPoint.startingPointX.label}"); 
*/
  //  ListOffsetFunc.offsetPoint.add(OffsetXY(eachOffsetPoint.startingPointX.OffsetLeft, eachOffsetPoint.startingPointX.OffsetTop, 
  //                              eachOffsetPoint.startingPointX.Diamension, eachOffsetPoint.startingPointX.widgetKey, eachOffsetPoint.startingPointX.label));
    
    for(DrawCanvasNode node in FieldController.nodes) {
      ListOffsetFunc.listOffsetTop.add(OffsetPoint2(node.OffsetTop, node.label));
      ListOffsetFunc.listOffsetRight.add(OffsetPoint2(node.OffsetRight, node.label));
    }

  // for(int i=0; i<FieldController.nodes.length; i++ ) {
     
    //print("eachOffsetPoint.loopCnt++ : ${eachOffsetPoint.loopCnt}");
    print("-------------------------------------------------------");
    print("--------------------Draw Start-------------------------");
    print("-------------------------------------------------------");
    {
    /*    print("eachOffsetPoint.flagStartY ==${eachOffsetPoint.flagStartY} && eachOffsetPoint.flagEndX == ${eachOffsetPoint.flagEndX}");
        if(eachOffsetPoint.flagStartY ==false) {
          eachOffsetPoint = SerarchTopPoint(eachOffsetPoint);
        }
        if(eachOffsetPoint.flagEndX == false) {
          eachOffsetPoint = SerarchRightPoint(eachOffsetPoint);
        }
        if(eachOffsetPoint.flagEndY == false) {
          eachOffsetPoint = SerarchBottomPoint(eachOffsetPoint);
        }
        print("eachOffsetPoint.flagEndX ==${eachOffsetPoint.flagEndX} && eachOffsetPoint.flagEndY == ${eachOffsetPoint.flagEndY} && eachOffsetPoint.flagStartX == ${eachOffsetPoint.flagStartX}");
        if(eachOffsetPoint.flagEndX ==true && eachOffsetPoint.flagEndY == true && eachOffsetPoint.flagStartX == false) {
          eachOffsetPoint = SerarchLeftPoint(eachOffsetPoint);
        }
        */
      //print("startingPoint : ${eachOffsetPoint.startingPoint.label}");
      
      CombineSurface cs = CombineSurface(ListOffsetFunc, FieldController);
      List<OffsetPoint> aatemp = [];
      
      for(int i =0; i<FieldController.nodes.length; i++) {
        ListOffsetFunc = InitBottomSurface(cs, canvas, ListOffsetFunc, FieldController.nodes[i]);
        aatemp.addAll(ListOffsetFunc.listOffsetPoint);
        ListOffsetFunc.listOffsetPoint.clear();
        
        ListOffsetFunc = InitTopSurface(cs, canvas, ListOffsetFunc, FieldController.nodes[i]);
        aatemp.addAll(ListOffsetFunc.listOffsetPoint);
        ListOffsetFunc.listOffsetPoint.clear();

        ListOffsetFunc = InitLeftSurface(cs, canvas, ListOffsetFunc, FieldController.nodes[i]);
        aatemp.addAll(ListOffsetFunc.listOffsetPoint);
        ListOffsetFunc.listOffsetPoint.clear();

        ListOffsetFunc = InitRightSurface(cs, canvas, ListOffsetFunc, FieldController.nodes[i]);
        aatemp.addAll(ListOffsetFunc.listOffsetPoint);
        ListOffsetFunc.listOffsetPoint.clear();
      }

       var viewPaint2 = Paint()
          ..style = PaintingStyle.stroke
          ..color = Color.fromARGB(255, 38, 3, 14)
          ..strokeWidth = 2
          ..isAntiAlias = true; 

        Path path = Path();
        aatemp.map((offset) {
          if(offset.allowMove == true) {
            path.moveTo(offset.offsetX, offset.offsetY);
          }
          else {
            path.lineTo(offset.offsetX , offset.offsetY);
          }
        }).toList();
     //   path.close();
        canvas.drawPath(path, viewPaint2);

    print("----------------------------------------------------------");
    print("-------------------------------------------------------");
    print("----------------------------------------------------------");

    }

  }

  listOffsetTBLR InitTopSurface(CombineSurface cs, Canvas canvas, listOffsetTBLR ListFunc, DrawCanvasNode fieldCtrl) {
     print("InitTopSurface()");
    ListFunc = SearchTopSurface(canvas, ListFunc, fieldCtrl);
    //print("ListFunc.listOffsetPoint.length ${ListFunc.listOffsetPoint.length}");
    if( (ListFunc.listOffsetPoint.length >0) && (ListFunc.mapfieldCtrl['top'] == fieldCtrl.label) ){
      ListFunc = cs.CombineSurfaceTop( ListFunc, fieldCtrl);
    }
    ListFunc.listOffsetPoint.forEach((element) {
      print(" final Sort : ${element.offsetX}, ${element.offsetY}");
    });
    
    return ListFunc;
  }

  listOffsetTBLR InitBottomSurface(CombineSurface cs, Canvas canvas, listOffsetTBLR ListFunc, DrawCanvasNode fieldCtrl) {
    print("InitBottomSurface()");
    ListFunc = SearchBottomSurface(canvas, ListFunc, fieldCtrl);
    if((ListFunc.listOffsetPoint.length >0) && (ListFunc.mapfieldCtrl['bottom'] == fieldCtrl.label) ) {
      ListFunc = cs.CombineSurfaceBottom( ListFunc, fieldCtrl);
    }
    ListFunc.listOffsetPoint.forEach((element) {
      print(" final Sort : ${element.offsetX}, ${element.offsetY}");
    });
    return ListFunc;
  }

  listOffsetTBLR InitLeftSurface(CombineSurface cs, Canvas canvas, listOffsetTBLR ListFunc, DrawCanvasNode fieldCtrl) {
    print("InitBottomSurface()");
    ListFunc = SearchLeftSurface(canvas, ListFunc, fieldCtrl);
    if((ListFunc.listOffsetPoint.length >0) && (ListFunc.mapfieldCtrl['left'] == fieldCtrl.label) ) {
      ListFunc = cs.CombineSurfaceLeft( ListFunc, fieldCtrl);
    }
    ListFunc.listOffsetPoint.forEach((element) {
      print(" final Sort : ${element.offsetX}, ${element.offsetY}");
    });
    return ListFunc;
  }

  listOffsetTBLR SearchLeftSurface(Canvas canvas,listOffsetTBLR ListFunc, DrawCanvasNode fieldCtrl) {
    print("SearchLeftSurface()");

    for(DrawCanvasNode node2 in FieldController.nodes) {
    //  print("${fieldCtrl.label}(${node2.label})(${fieldCtrl.OffsetLeft} == ${node2.OffsetRight}) &&(${fieldCtrl.OffsetLeft} == ${node2.OffsetLeft})");
      
      if( (fieldCtrl.OffsetLeft == node2.OffsetRight) 
        &&((fieldCtrl.OffsetTop < node2.OffsetTop) && (fieldCtrl.OffsetBottom > node2.OffsetTop))
        &&((fieldCtrl.OffsetTop < node2.OffsetBottom) && (fieldCtrl.OffsetBottom > node2.OffsetBottom))
        && (fieldCtrl.label != node2.label) ) {
    //    print("1111 node label : ${fieldCtrl.label} , ${node2.label}");

        ListFunc.mapfieldCtrl['left'] = fieldCtrl.label;
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetRight, node2.OffsetTop, false));
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetRight, node2.OffsetBottom, true));
      }
      if( (fieldCtrl.OffsetLeft == node2.OffsetRight)
        &&((fieldCtrl.OffsetTop > node2.OffsetTop) && (fieldCtrl.OffsetTop < node2.OffsetBottom)) ) {
    //    print("2222 node label : ${fieldCtrl.label} , ${node2.label}");
        
        ListFunc.mapfieldCtrl['left'] = fieldCtrl.label;
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetRight, node2.OffsetTop, true));
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetRight, node2.OffsetBottom, true));
      }
      if( (fieldCtrl.OffsetLeft == node2.OffsetRight)
        &&(fieldCtrl.OffsetTop == node2.OffsetTop) && (fieldCtrl.label != node2.label) ) {
     //   print("3333 node label : ${fieldCtrl.label} , ${node2.label}");
     
        ListFunc.mapfieldCtrl["left"] = fieldCtrl.label;
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetRight, node2.OffsetBottom, true));
      }
      if( (fieldCtrl.OffsetLeft == node2.OffsetRight)
        &&((fieldCtrl.OffsetTop < node2.OffsetTop) && (fieldCtrl.OffsetBottom > node2.OffsetTop))
        && (fieldCtrl.OffsetBottom <= node2.OffsetBottom) )  {
     //   print("4444 node label : ${fieldCtrl.label} , ${node2.label}, ${node2.OffsetRight}");
        ListFunc.mapfieldCtrl["left"] = fieldCtrl.label;
     
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetRight, node2.OffsetTop, false));
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetRight, node2.OffsetBottom, false));
      }
    }
    if(ListFunc.mapfieldCtrl["left"] != fieldCtrl.label) {
   //   print('else ');
      List<OffsetPoint> tempOffsetPoint = [];
      tempOffsetPoint.add(OffsetPoint(fieldCtrl.OffsetLeft, fieldCtrl.OffsetTop, true));
      tempOffsetPoint.add(OffsetPoint(fieldCtrl.OffsetLeft, fieldCtrl.OffsetBottom, false));
   
      ListFunc.listOffsetPoint.addAll(tempOffsetPoint);
    }
    return ListFunc;
  }
  
  listOffsetTBLR InitRightSurface(CombineSurface cs, Canvas canvas, listOffsetTBLR ListFunc, DrawCanvasNode fieldCtrl) {
    print("InitRightSurface()");
    ListFunc = SearchRightSurface(canvas, ListFunc, fieldCtrl);
    if((ListFunc.listOffsetPoint.length >0) && (ListFunc.mapfieldCtrl['right'] == fieldCtrl.label) ) {
      ListFunc = cs.CombineSurfaceRight( ListFunc, fieldCtrl);
    }
    ListFunc.listOffsetPoint.forEach((element) {
      print(" final Sort : ${element.offsetX}, ${element.offsetY}");
    });
    return ListFunc;
  }

  listOffsetTBLR SearchRightSurface(Canvas canvas,listOffsetTBLR ListFunc, DrawCanvasNode fieldCtrl) {
    print("SearchRightSurface()");
    for(DrawCanvasNode node2 in FieldController.nodes) {
     // print("${fieldCtrl.label}(${node2.label})(${fieldCtrl.OffsetRight} == ${node2.OffsetLeft})");
      
      if( (fieldCtrl.OffsetRight == node2.OffsetLeft) 
        &&((fieldCtrl.OffsetTop < node2.OffsetTop) && (fieldCtrl.OffsetBottom > node2.OffsetTop))
        &&((fieldCtrl.OffsetTop < node2.OffsetBottom) && (fieldCtrl.OffsetBottom > node2.OffsetBottom))
        && (fieldCtrl.label != node2.label) ) {
     //   print("1111 node label : ${fieldCtrl.label} , ${node2.label}");

        ListFunc.mapfieldCtrl['right'] = fieldCtrl.label;
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetLeft, node2.OffsetTop, false));
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetLeft, node2.OffsetBottom, true));
      }
      if( (fieldCtrl.OffsetRight == node2.OffsetLeft) 
        &&((fieldCtrl.OffsetTop > node2.OffsetTop) && (fieldCtrl.OffsetTop < node2.OffsetBottom)) ) {
     //   print("2222 node label : ${fieldCtrl.label} , ${node2.label}");
        
        ListFunc.mapfieldCtrl['right'] = fieldCtrl.label;
     //   ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetLeft, node2.OffsetTop, true));
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetLeft, node2.OffsetBottom, true));
      }
      if( (fieldCtrl.OffsetRight == node2.OffsetLeft) 
        &&(fieldCtrl.OffsetTop == node2.OffsetTop) && (fieldCtrl.label != node2.label) ) {
   //     print("3333 node label : ${fieldCtrl.label} , ${node2.label}");
        ListFunc.mapfieldCtrl["right"] = fieldCtrl.label;
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetLeft, node2.OffsetBottom, true));
      }
      if( (fieldCtrl.OffsetRight == node2.OffsetLeft) 
        &&((fieldCtrl.OffsetTop < node2.OffsetTop) && (fieldCtrl.OffsetBottom > node2.OffsetTop))
        && (fieldCtrl.OffsetBottom <= node2.OffsetBottom) )  {
    //    print("4444 node label : ${fieldCtrl.label} , ${node2.label}, ${node2.OffsetRight}");
        ListFunc.mapfieldCtrl["right"] = fieldCtrl.label;
     
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetLeft, node2.OffsetTop, false));
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetLeft, node2.OffsetBottom, false));
      }
    }
     if(ListFunc.mapfieldCtrl["right"] != fieldCtrl.label) {
    //    print('else ');
        List<OffsetPoint> tempOffsetPoint = [];
        tempOffsetPoint.add(OffsetPoint(fieldCtrl.OffsetRight, fieldCtrl.OffsetTop, true));
        tempOffsetPoint.add(OffsetPoint(fieldCtrl.OffsetRight, fieldCtrl.OffsetBottom, false));

        ListFunc.listOffsetPoint.addAll(tempOffsetPoint);
    }
    return ListFunc;
  }
  listOffsetTBLR SearchTopSurface(Canvas canvas,listOffsetTBLR ListFunc, DrawCanvasNode fieldCtrl) {
    print("SearchTopSurface()");

    var viewPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Color.fromARGB(255, 141, 164, 152)
      ..strokeWidth = 2
      ..isAntiAlias = true;

    for(DrawCanvasNode node2 in FieldController.nodes) {
   //   print("${fieldCtrl.label}(${node2.label})(${fieldCtrl.OffsetTop} == ${node2.OffsetBottom}) &&(${fieldCtrl.OffsetLeft} == ${node2.OffsetLeft})");
      
      if( (fieldCtrl.OffsetTop == node2.OffsetBottom) 
        &&((fieldCtrl.OffsetLeft < node2.OffsetLeft) && (fieldCtrl.OffsetRight > node2.OffsetLeft))
        &&((fieldCtrl.OffsetLeft < node2.OffsetRight) && (fieldCtrl.OffsetRight > node2.OffsetRight))
        && (fieldCtrl.label != node2.label) ) {
     //   print("1111 node label : ${fieldCtrl.label} , ${node2.label}");

        ListFunc.mapfieldCtrl['top'] = fieldCtrl.label;
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetLeft, node2.OffsetBottom, false));
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetRight, node2.OffsetBottom, true));
      }
      if((fieldCtrl.OffsetTop == node2.OffsetBottom)
        &&((fieldCtrl.OffsetLeft > node2.OffsetLeft) && (fieldCtrl.OffsetLeft < node2.OffsetRight)) ) {
     //   print("2222 node label : ${fieldCtrl.label} , ${node2.label}");
        
        ListFunc.mapfieldCtrl['top'] = fieldCtrl.label;
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetRight, node2.OffsetBottom, true));
      //   canvas.drawLine(Offset(nodelist.OffsetX-200, nodelist.offsetY), Offset(nodelist.OffsetX+200, nodelist.offsetY), viewPaint);
      }
      if( (fieldCtrl.OffsetTop == node2.OffsetBottom)
        &&(fieldCtrl.OffsetLeft == node2.OffsetLeft) && (fieldCtrl.label != node2.label) ) {
    //    print("3333 node label : ${fieldCtrl.label} , ${node2.label}");
        ListFunc.mapfieldCtrl["top"] = fieldCtrl.label;
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetRight, node2.OffsetBottom, true));
      }
      if( (fieldCtrl.OffsetTop == node2.OffsetBottom)
        &&((fieldCtrl.OffsetLeft < node2.OffsetLeft) && (fieldCtrl.OffsetRight > node2.OffsetLeft))
        && (fieldCtrl.OffsetRight <= node2.OffsetRight) )  {
    //    print("4444 node label : ${fieldCtrl.label} , ${node2.label}, ${node2.OffsetRight}");
        ListFunc.mapfieldCtrl["top"] = fieldCtrl.label;
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetLeft, node2.OffsetBottom, false));
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetRight, node2.OffsetBottom, false));
      }
    }
    if(ListFunc.mapfieldCtrl["top"] != fieldCtrl.label) {
    //    print('else ');
        List<OffsetPoint> tempOffsetPoint = [];
        tempOffsetPoint.add(OffsetPoint(fieldCtrl.OffsetLeft, fieldCtrl.OffsetTop, true));
        tempOffsetPoint.add(OffsetPoint(fieldCtrl.OffsetRight, fieldCtrl.OffsetTop, false));

     /*   Path path = Path();
        tempOffsetPoint.map((offset) {
          if(offset.allowMove == true) {
            path.moveTo(offset.offsetX, offset.offsetY);
            print("temp move to : ${offset.offsetX}, ${offset.offsetY}");
          }
          else {
              path.lineTo(offset.offsetX , offset.offsetY);
              print("temp not move : ${offset.offsetX}, ${offset.offsetY}");
          }
        }).toList();
        canvas.drawPath(path, viewPaint);*/
        ListFunc.listOffsetPoint.addAll(tempOffsetPoint);
    }

    return ListFunc;
  }
  listOffsetTBLR SearchBottomSurface(Canvas canvas,listOffsetTBLR ListFunc, DrawCanvasNode fieldCtrl) {
    
    var viewPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Color.fromARGB(255, 141, 164, 152)
      ..strokeWidth = 2
      ..isAntiAlias = true;

    for(DrawCanvasNode node2 in FieldController.nodes) {
      if( (fieldCtrl.OffsetBottom == node2.OffsetTop) 
        &&((fieldCtrl.OffsetLeft < node2.OffsetLeft) && (fieldCtrl.OffsetRight > node2.OffsetLeft))
        &&((fieldCtrl.OffsetLeft < node2.OffsetRight) && (fieldCtrl.OffsetRight > node2.OffsetRight))
        && (fieldCtrl.label != node2.label) ) {
        print("1111 node label : ${fieldCtrl.label} , ${node2.label}");
        
        ListFunc.mapfieldCtrl['bottom'] = fieldCtrl.label;
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetLeft, node2.OffsetTop, false));
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetRight, node2.OffsetTop, true));
        
      }
      if((fieldCtrl.OffsetBottom == node2.OffsetTop)
        &&((fieldCtrl.OffsetLeft > node2.OffsetLeft) && (fieldCtrl.OffsetLeft < node2.OffsetRight)) ) {
        print("2222 node label : ${fieldCtrl.label} , ${node2.label}");
        
        ListFunc.mapfieldCtrl['bottom'] = fieldCtrl.label;
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetRight, node2.OffsetTop, true));
        
      }
      if( (fieldCtrl.OffsetBottom == node2.OffsetTop) 
        &&(fieldCtrl.OffsetLeft == node2.OffsetLeft) && (fieldCtrl.label != node2.label) ) {
        print("3333 node label : ${fieldCtrl.label} , ${node2.label}");
        ListFunc.mapfieldCtrl["bottom"] = fieldCtrl.label;
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetLeft, node2.OffsetTop, false));
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetRight, node2.OffsetTop, true));
     
      }
      if( (fieldCtrl.OffsetBottom == node2.OffsetTop)
        &&((fieldCtrl.OffsetLeft < node2.OffsetLeft) && (fieldCtrl.OffsetRight > node2.OffsetLeft))
        && (fieldCtrl.OffsetRight <= node2.OffsetRight)  && (fieldCtrl.label != node2.label))  {
        print("4444 node label : ${fieldCtrl.label} , ${node2.label}, ${node2.OffsetRight}");
        ListFunc.mapfieldCtrl["bottom"] = fieldCtrl.label;
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetLeft, node2.OffsetTop, false));
        ListFunc.listOffsetPoint.add(OffsetPoint(node2.OffsetRight, node2.OffsetTop, false));
    
      }
      print("label : ${fieldCtrl.label}");
      
    }
    if(ListFunc.mapfieldCtrl["bottom"] != fieldCtrl.label) {
      List<OffsetPoint> tempOffsetPoint = [];
      tempOffsetPoint.add(OffsetPoint(fieldCtrl.OffsetLeft, fieldCtrl.OffsetBottom, true));
      tempOffsetPoint.add(OffsetPoint(fieldCtrl.OffsetRight, fieldCtrl.OffsetBottom, false));
      ListFunc.listOffsetPoint.addAll(tempOffsetPoint);
    }
    return ListFunc;
  }

  EachOffsetPoint SerarchLeftPoint(EachOffsetPoint T ) {
    int overlapCnt = 0;
    print('SerarchLeftPoint()');
    //while(T.startingPoint.label != T.startingPointX.label) {
    while(true) {
      ListOffsetFunc.offsetPoint = GetCoordinateLeftPos(T.startingPoint, ListOffsetFunc.offsetPoint);

      if(ListOffsetFunc.offsetPoint.last.label != T.startingPoint.label ) {
        for(DrawCanvasNode node3 in FieldController.nodes) {
          if(ListOffsetFunc.offsetPoint.last.label == node3.label) {
            T.startingPoint = node3;
            print("----SerarchLeftPoint.label : ${T.startingPoint.label}");
          
            break;
          }
        }
      }
      print("T.startingPoint label : ${T.startingPoint.label}");
      if( (T.startingPoint.OffsetBottom == T.endYPointing.OffsetBottom) &&  T.flagEndY == false ) {
        print("T.startingPoint.OffsetBottom == T.endYPointing.OffsetBottom  ${T.startingPoint.OffsetBottom} == ${T.endYPointing.OffsetBottom}");
        ListOffsetFunc.offsetPoint.add(OffsetXY(T.startingPoint.OffsetLeft, T.startingPoint.OffsetBottom, T.startingPoint.Diamension, T.startingPoint.widgetKey, T.startingPoint.label));
        T.flagEndY = true;
      }
      if( (T.startingPoint.OffsetLeft == T.startingPointX.OffsetLeft) && T.flagStartX == false ){
        print("erarchLeftPoint End ================  ${T.startingPoint.OffsetLeft} == ${T.startingPointX.OffsetLeft}");
        ListOffsetFunc.offsetPoint.add(OffsetXY(T.startingPoint.OffsetLeft, T.startingPoint.OffsetBottom, T.startingPoint.Diamension, T.startingPoint.widgetKey, T.startingPoint.label));
        T.flagStartX = true;
        break;
      }
      overlapCnt++;
      print("overlapCnt : $overlapCnt");
      if(overlapCnt == FieldController.nodes.length) {
        ListOffsetFunc.offsetPoint.add(OffsetXY(T.startingPoint.OffsetLeft, T.startingPoint.OffsetBottom, T.startingPoint.Diamension, T.startingPoint.widgetKey, T.startingPoint.label));
        ListOffsetFunc.offsetPoint.add(OffsetXY(T.startingPoint.OffsetLeft, T.startingPoint.OffsetTop, T.startingPoint.Diamension, T.startingPoint.widgetKey, T.startingPoint.label));
      //  T.flagStartX = true;
        print("SerarchLeftPoint End ================");
        overlapCnt =0;
        break;
      }
    }
    return T;
  }
  List<OffsetXY> GetCoordinateLeftPos(DrawCanvasNode startPos, List<OffsetXY> endPos) {
    //endPos.add(OffsetXY(startPos.OffsetLeft, startPos.OffsetBottom, startPos.Diamension, startPos.widgetKey, startPos.label));
    print("GetCoordinateLeftPos start label : ${startPos.label}");

    for(DrawCanvasNode node in FieldController.nodes) { 
      if( (startPos.OffsetLeft == node.OffsetRight) && ((startPos.OffsetTop > node.OffsetTop) && (startPos.OffsetBottom > node.OffsetTop)) 
            && ((startPos.OffsetTop > node.OffsetBottom) && (startPos.OffsetBottom < node.OffsetBottom))
            && (startPos.label != node.label) ) {
        print("111 node label : ${node.label}");
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        //endPos.add(OffsetXY(node.OffsetLeft, node.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( (startPos.OffsetTop == node.OffsetBottom) && ((startPos.OffsetLeft > node.OffsetLeft)&&(startPos.OffsetLeft < node.OffsetRight)) 
                && (startPos.label != node.label) ) {
        print("222 node label : ${node.label}");
        endPos.add(OffsetXY(startPos.OffsetLeft, startPos.OffsetBottom, startPos.Diamension, startPos.widgetKey, startPos.label));
        endPos.add(OffsetXY(startPos.OffsetLeft, startPos.OffsetTop, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( (startPos.OffsetTop == node.OffsetBottom) && (startPos.OffsetLeft == node.OffsetLeft)  && (startPos.OffsetRight == node.OffsetRight) &&  (startPos.label != node.label) ) {
        print("4444 node label : ${node.label}");
        endPos.add(OffsetXY(node.OffsetLeft, node.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( (startPos.OffsetBottom == node.OffsetBottom) && (startPos.OffsetLeft == node.OffsetRight) && (startPos.label != node.label) ) {
        print("333 node label : ${node.label}");
        for(DrawCanvasNode node2 in FieldController.nodes) { 
          if( ((node.OffsetLeft < node2.OffsetRight) && (node.OffsetRight > node2.OffsetLeft))
              && (node.OffsetBottom == node2.OffsetTop) && (node.label != node2.label) ) {
            print("333-1 node2 label : ${node2.label}");
            endPos.add(OffsetXY(node2.OffsetRight, node2.OffsetTop, node2.Diamension, node2.widgetKey, node2.label));
            endPos.add(OffsetXY(node2.OffsetRight, node2.OffsetBottom, node2.Diamension, node2.widgetKey, node2.label));
            
            return endPos;
          }
        }
        endPos.add(OffsetXY(startPos.OffsetLeft, startPos.OffsetBottom, startPos.Diamension, startPos.widgetKey, startPos.label));
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( (startPos.OffsetBottom == node.OffsetTop) && ((startPos.OffsetLeft < node.OffsetRight) && (startPos.OffsetRight > node.OffsetRight))
                && (startPos.label != node.label) ) {
        print("7777 node label : ${node.label}");
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetTop, node.Diamension, node.widgetKey, node.label));
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( (startPos.OffsetBottom == node.OffsetTop) && ((startPos.OffsetLeft < node.OffsetLeft) && (startPos.OffsetLeft < node.OffsetRight))
                && ((startPos.OffsetLeft < node.OffsetRight) && (startPos.OffsetRight > node.OffsetRight)) ) {
        print("6666 node label : ${node.label}");
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetTop, node.Diamension, node.widgetKey, node.label));
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( (startPos.OffsetLeft == node.OffsetRight) && (startPos.OffsetTop > node.OffsetTop) && (startPos.OffsetTop < node.OffsetBottom)) {
        print("555 node label : ${node.label}");
        endPos.add(OffsetXY(startPos.OffsetLeft, startPos.OffsetBottom, startPos.Diamension, startPos.widgetKey, startPos.label));
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( (startPos.OffsetTop == node.OffsetTop) && (startPos.OffsetBottom > node.OffsetBottom) 
                && (startPos.label != node.label) ) {
        print("8888 node label : ${node.label}");
        endPos.add(OffsetXY(startPos.OffsetLeft, startPos.OffsetBottom, startPos.Diamension, startPos.widgetKey, startPos.label));
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( ((startPos.OffsetTop < node.OffsetTop) && (startPos.OffsetBottom > node.OffsetTop)) 
                && ((startPos.OffsetBottom > node.OffsetBottom)&&(startPos.OffsetTop < node.OffsetBottom))
                && (startPos.label != node.label) ) {
        print("9999 node label : ${node.label}");
        endPos.add(OffsetXY(startPos.OffsetLeft, startPos.OffsetBottom, startPos.Diamension, startPos.widgetKey, startPos.label));
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( ((startPos.OffsetTop < node.OffsetTop) && (startPos.OffsetBottom > node.OffsetTop)) 
                && ((startPos.OffsetBottom < node.OffsetBottom) && (startPos.OffsetLeft == node.OffsetRight))
                && (startPos.label != node.label) ) {
        print("1010101010 node label : ${node.label}");
        endPos.add(OffsetXY(startPos.OffsetLeft, startPos.OffsetBottom, startPos.Diamension, startPos.widgetKey, startPos.label));
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( (startPos.OffsetTop == node.OffsetTop)  
                && ((startPos.OffsetBottom > node.OffsetTop)&&(startPos.OffsetBottom < node.OffsetBottom))
                && (startPos.label != node.label) ) {
        print("11 11 11 11 node label : ${node.label}");
        endPos.add(OffsetXY(startPos.OffsetLeft, startPos.OffsetBottom, startPos.Diamension, startPos.widgetKey, startPos.label));
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( (startPos.OffsetTop == node.OffsetBottom) && (startPos.OffsetLeft == node.OffsetLeft) 
          && ((startPos.OffsetRight < node.OffsetRight)&& (startPos.OffsetRight > node.OffsetLeft)) &&  (startPos.label != node.label) ) {
        print("12 12 12 12  node label : ${node.label}");
        endPos.add(OffsetXY(startPos.OffsetLeft, startPos.OffsetBottom, startPos.Diamension, startPos.widgetKey, startPos.label));
        endPos.add(OffsetXY(node.OffsetLeft, node.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        break;
      }
    }
    return endPos;
  }

  EachOffsetPoint SerarchBottomPoint(EachOffsetPoint T ) {
    int overlapCnt = 0;
    while(T.startingPoint.label != T.endYPointing.label) {
      ListOffsetFunc.offsetPoint = GetCoordinateBottomPos(T.startingPoint, ListOffsetFunc.offsetPoint);

      if(ListOffsetFunc.offsetPoint.last.label != T.startingPoint.label ) {
        for(DrawCanvasNode node3 in FieldController.nodes) {
          if(ListOffsetFunc.offsetPoint.last.label == node3.label) {
            T.startingPoint = node3;
            print("----SerarchBottomPoint.label : ${T.startingPoint.label}");
         //   overlapCnt =0;
            break;
            //return T;
          }
        }
      }
      if(T.startingPoint.OffsetBottom == T.endYPointing.OffsetBottom) {
        print("T.startingPoint.label[${T.startingPoint.OffsetBottom}] == T.endYPointing.label[${T.endYPointing.OffsetBottom}]");
        ListOffsetFunc.offsetPoint.add(OffsetXY(T.startingPoint.OffsetRight, T.startingPoint.OffsetBottom, T.startingPoint.Diamension, T.startingPoint.widgetKey, T.startingPoint.label));
        T.flagEndY = true;
        T.flagEndX = true;
      }
      overlapCnt++;
      if(overlapCnt == FieldController.nodes.length) {
        print("SerarchBottomPoint End ================");
        overlapCnt =0;
        ListOffsetFunc.offsetPoint.add(OffsetXY(T.startingPoint.OffsetRight, T.startingPoint.OffsetBottom, T.startingPoint.Diamension, T.startingPoint.widgetKey, T.startingPoint.label));
        T.flagEndY = true;
        break;
      }
      
    }
    return T;
  }
  EachOffsetPoint SerarchRightPoint(EachOffsetPoint T ) {
    int overlapCnt = 0;
    while(T.startingPoint.label != T.endXPointing.label) {
      ListOffsetFunc.offsetPoint = GetCoordinateRightPos(T.startingPoint, ListOffsetFunc.offsetPoint);
      if(ListOffsetFunc.offsetPoint.last.label != T.startingPoint.label ) {
        for(DrawCanvasNode node3 in FieldController.nodes) {
          if(ListOffsetFunc.offsetPoint.last.label == node3.label) {
            T.startingPoint = node3;
            print("----SerarchRightPoint.label : ${T.startingPoint.label}");
            overlapCnt =0;
          }
        }
      }
      if(T.startingPointX.label == T.startingPointY.label) {
        print("T.startingPointX[${T.startingPointX.label}] == T.startingPointY[${T.startingPointY.label}]");
        ListOffsetFunc.offsetPoint.add(OffsetXY(T.startingPoint.OffsetRight, T.startingPoint.OffsetTop, T.startingPoint.Diamension, T.startingPoint.widgetKey, T.startingPoint.label));
        break;
      }

      overlapCnt++;
      if(overlapCnt == FieldController.nodes.length) {
        print("SerarchRightPoint error ================");
   //     ListOffsetFunc.offsetPoint.add(OffsetXY(T.startingPoint.OffsetRight, T.startingPoint.OffsetTop, T.endXPointing.Diamension, T.endXPointing.widgetKey, T.endXPointing.label));
        overlapCnt =0;
        break;
      }
    }
    if(T.startingPoint.OffsetRight == T.endXPointing.OffsetRight) {
      print("T.startingPoint.OffsetRight == T.endXPointing.OffsetRight  ${T.startingPoint.OffsetRight} == ${T.endXPointing.OffsetRight}");
      ListOffsetFunc.offsetPoint.add(OffsetXY(T.startingPoint.OffsetRight, T.startingPoint.OffsetTop, T.startingPoint.Diamension, T.startingPoint.widgetKey, T.startingPoint.label));
      T.flagEndX = true;
      
      if(T.startingPoint.OffsetBottom == T.endYPointing.OffsetBottom) {
        print("T.startingPoint.OffsetBottom == T.endYPointing.OffsetBottom  ${T.startingPoint.OffsetBottom} == ${T.endYPointing.OffsetBottom}");
        ListOffsetFunc.offsetPoint.add(OffsetXY(T.startingPoint.OffsetRight, T.startingPoint.OffsetBottom, T.startingPoint.Diamension, T.startingPoint.widgetKey, T.startingPoint.label));  
        T.flagEndY = true;
      }
    }
    return T;
  }

  EachOffsetPoint SerarchTopPoint(EachOffsetPoint T ) {
    int overlapCnt = 0;
    bool flag = false;

    while(T.startingPoint.label != T.startingPointY.label) {
      ListOffsetFunc.offsetPoint = GetCoordinatePosTop(T.startingPoint, ListOffsetFunc.offsetPoint);
      if(ListOffsetFunc.offsetPoint.last.label != T.startingPoint.label ) {
        for(DrawCanvasNode node3 in FieldController.nodes) {
          if(ListOffsetFunc.offsetPoint.last.label == node3.label) {
            T.startingPoint = node3;
            print("----SerarchTopPoint.label : ${T.startingPoint.label}");
            overlapCnt =0;
            flag = true;
            //return T;
          }
        }
      }

      overlapCnt++;
      if(overlapCnt == FieldController.nodes.length) {
        print("error ================");
        overlapCnt =0;
        break;
      }
      if(T.startingPoint.OffsetTop == T.startingPointY.OffsetTop) {
        print('label[${T.startingPoint.label}] T.startingPoint.OffsetTop[${T.startingPoint.OffsetTop}] == T.startingPointY.OffsetTop[${T.startingPointY.OffsetTop}]');
      //  ListOffsetFunc.offsetPoint.add(OffsetXY(T.startingPoint.OffsetRight, T.startingPoint.OffsetTop, T.startingPoint.Diamension, T.startingPoint.widgetKey, T.startingPoint.label));  
        T.flagStartY = true;
      }
      if( (flag == true) && (T.startingPoint.OffsetTop == T.startingPointY.OffsetTop) && (T.startingPoint.OffsetLeft == T.startingPointX.OffsetLeft) ) {
        print("Complete StartPointX");
        T.flagStartX = true;
      }
    }
    
    return T;
  }
  List<OffsetXY> GetCoordinatePosTop(DrawCanvasNode startPos, List<OffsetXY> endPos) {
    print("GetCoordinatePosTop start label : ${startPos.label}");
    for(DrawCanvasNode node in FieldController.nodes) { 
   //   if(mapLabelCheck[node.label] == true) continue;
      if( (startPos.OffsetTop > node.OffsetTop) && (startPos.OffsetTop == node.OffsetBottom) && 
          ((startPos.OffsetLeft < node.OffsetLeft) && (startPos.OffsetRight > node.OffsetLeft)) && (startPos.widgetKey != node.widgetKey) ) {
        print("111 node.label : ${node.label}");
        endPos.add(OffsetXY(node.OffsetLeft, node.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        endPos.add(OffsetXY(node.OffsetLeft, node.OffsetTop, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( ((startPos.OffsetTop > node.OffsetTop) && (startPos.OffsetTop == node.OffsetBottom)) && (startPos.OffsetLeft == node.OffsetLeft)
        && (startPos.widgetKey != node.widgetKey) ) {
        print("222 node label : ${node.label}");
        endPos.add(OffsetXY(node.OffsetLeft, node.OffsetTop, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( (startPos.OffsetTop > node.OffsetTop) && (startPos.OffsetRight == node.OffsetLeft) && (startPos.widgetKey != node.widgetKey) ) {
        print("3333 node label : ${node.label}");
        endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetTop, startPos.Diamension, startPos.widgetKey, startPos.label));
        endPos.add(OffsetXY(node.OffsetLeft, node.OffsetTop, node.Diamension, node.widgetKey, node.label));
        //endPos.add(OffsetXY(node.OffsetRight, node.OffsetTop, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( ((startPos.OffsetTop > node.OffsetTop) && (startPos.OffsetTop == node.OffsetBottom)) &&  ((startPos.OffsetLeft > node.OffsetLeft) && (startPos.OffsetRight > node.OffsetRight))
            && (startPos.widgetKey != node.widgetKey)) {
        print("4444 node label : ${node.label}");
        endPos.add(OffsetXY(node.OffsetLeft, node.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        endPos.add(OffsetXY(node.OffsetLeft, node.OffsetTop, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( (startPos.OffsetTop == node.OffsetTop) && (startPos.OffsetRight == node.OffsetLeft) && (startPos.widgetKey != node.widgetKey) ) {
        print("555 node Label : ${node.label}");
        DrawCanvasNode tmpNode;
        var Result = ListOffsetFunc.listOffsetTop.firstWhere((element) => node.OffsetTop > element.Offset, orElse: () => OffsetPoint2(node.OffsetRight, node.label));
        print(" 5555- Result : ${Result.Label} ${Result.Offset}");
        for(DrawCanvasNode node2 in FieldController.nodes) { 
          if(Result.Label == node2.label) {
            tmpNode = node2;

            if( (tmpNode.OffsetBottom == node.OffsetTop) && (tmpNode.OffsetLeft > node.OffsetLeft) && (tmpNode.OffsetLeft < node.OffsetRight)
                && (tmpNode.label != node.label) ) {
                  print("5555-1 node label : ${tmpNode.label}");
                  endPos.add(OffsetXY(tmpNode.OffsetLeft, tmpNode.OffsetBottom, tmpNode.Diamension, tmpNode.widgetKey, tmpNode.label));
                  endPos.add(OffsetXY(tmpNode.OffsetLeft, tmpNode.OffsetTop, tmpNode.Diamension, tmpNode.widgetKey, tmpNode.label));
            }
            break;
          }
        }
      }
      else if( (startPos.OffsetTop > node.OffsetTop) && (startPos.OffsetTop == node.OffsetBottom) && 
          ((startPos.OffsetLeft > node.OffsetLeft) && (startPos.OffsetRight > node.OffsetLeft))
          &&((startPos.OffsetLeft < node.OffsetRight) && (startPos.OffsetRight < node.OffsetRight))
         && (startPos.widgetKey != node.widgetKey) ) {
        print("66666 node.label : ${node.label}");
        endPos.add(OffsetXY(node.OffsetLeft, node.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        endPos.add(OffsetXY(node.OffsetLeft, node.OffsetTop, node.Diamension, node.widgetKey, node.label));
        break;
      }
    

    }
    return endPos;
  }

  List<OffsetXY> GetCoordinateBottomPos(DrawCanvasNode startPos, List<OffsetXY> endPos) {
    print("GetCoordinateBottomPos startPos : ${startPos.label}, ${startPos.OffsetTop}, ${startPos.OffsetRight}");

    for(DrawCanvasNode node in FieldController.nodes) { 
      if( (startPos.OffsetRight == node.OffsetRight) && (startPos.OffsetBottom == node.OffsetTop) && (startPos.widgetKey != node.widgetKey) ) {
        print("111 node label : ${node.label}");
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        
        for(int i=0; i<ListOffsetFunc.listOffsetRight.length; i++) {
          for(DrawCanvasNode node2 in FieldController.nodes) { 
            if( ((node.OffsetBottom == node2.OffsetTop) && (ListOffsetFunc.listOffsetRight[i].Offset == node.OffsetRight) && (ListOffsetFunc.listOffsetRight[i].Offset == node2.OffsetRight)) && (ListOffsetFunc.listOffsetRight[i].Label != node2.widgetKey) ) {
              print("ListOffsetFunc.listOffsetRight[i].label : ${ListOffsetFunc.listOffsetRight[i].Label}");
              print("111-2 node label : ${node2.label}");
              endPos.add(OffsetXY(node2.OffsetRight, node2.OffsetBottom, node2.Diamension, node2.widgetKey, node2.label));
              return endPos;
            }    
          }
        }
        break;
      }
      else if( ((startPos.OffsetLeft > node.OffsetLeft)&&(startPos.OffsetLeft < node.OffsetRight)) 
                && ((startPos.OffsetRight > node.OffsetRight) && (startPos.OffsetLeft < node.OffsetRight) )
                &&(startPos.OffsetBottom == node.OffsetTop) && (startPos.widgetKey != node.widgetKey) ) {
        print("22222 node label : ${node.label}");
        endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetBottom, startPos.Diamension, startPos.widgetKey, startPos.label));
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetTop, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( (startPos.OffsetRight == node.OffsetLeft) 
                && ((startPos.OffsetTop < node.OffsetTop)&&(startPos.OffsetBottom>node.OffsetTop)) 
                && (startPos.OffsetBottom < node.OffsetBottom) && (startPos.label != node.label)) {
        print("3333 node label : ${node.label}");
        endPos.add(OffsetXY(node.OffsetLeft, node.OffsetTop, node.Diamension, node.widgetKey, node.label));
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetTop, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( (startPos.OffsetBottom == node.OffsetTop)
                && ((startPos.OffsetLeft < node.OffsetLeft)&&(startPos.OffsetRight > node.OffsetLeft))
                && (startPos.OffsetRight < node.OffsetRight) &&(startPos.label != node.label) ) {
        print("44444 node label : ${node.label}");
        endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetBottom, startPos.Diamension, startPos.widgetKey, startPos.label));
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetTop, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( (startPos.OffsetBottom == node.OffsetTop)
                && ((startPos.OffsetLeft < node.OffsetLeft)&&(startPos.OffsetRight > node.OffsetLeft))
                && ((startPos.OffsetLeft < node.OffsetRight)&& (startPos.OffsetRight > node.OffsetRight)) &&(startPos.label != node.label) ) {
        print("555555 node label : ${node.label}");
        endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetBottom, startPos.Diamension, startPos.widgetKey, startPos.label));
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetTop, node.Diamension, node.widgetKey, node.label));
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( (startPos.OffsetBottom == node.OffsetTop)
                && ((startPos.OffsetLeft > node.OffsetLeft)&&(startPos.OffsetRight > node.OffsetLeft))
                && ((startPos.OffsetLeft < node.OffsetRight)&& (startPos.OffsetRight < node.OffsetRight)) &&(startPos.label != node.label) ) {
        print("66666 node label : ${node.label}");
        endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetBottom, startPos.Diamension, startPos.widgetKey, startPos.label));
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetTop, node.Diamension, node.widgetKey, node.label));
      //  endPos.add(OffsetXY(node.OffsetRight, node.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( ((startPos.OffsetTop < node.OffsetTop) && (startPos.OffsetBottom > node.OffsetTop)) 
                && ((startPos.OffsetBottom < node.OffsetBottom) && (startPos.OffsetLeft == node.OffsetRight))
                && (startPos.label != node.label) ) {
        print("777777 node label : ${node.label}");
        endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetBottom, startPos.Diamension, startPos.widgetKey, startPos.label));
        endPos.add(OffsetXY(startPos.OffsetLeft, startPos.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( (startPos.OffsetBottom == node.OffsetTop) && ((startPos.OffsetLeft < node.OffsetRight) && (startPos.OffsetRight > node.OffsetRight))
                && (startPos.label != node.label) ) {
        print("88888 node label : ${node.label}");
        endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetBottom, startPos.Diamension, startPos.widgetKey, startPos.label));
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetTop, node.Diamension, node.widgetKey, node.label));
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( (startPos.OffsetBottom == node.OffsetTop) 
              && ((startPos.OffsetLeft == node.OffsetLeft) && (startPos.OffsetRight > node.OffsetLeft))
              && ((startPos.OffsetLeft < node.OffsetRight) && (startPos.OffsetRight < node.OffsetRight))
                && (startPos.label != node.label) ) {
        print("9999 node label : ${node.label}");
        endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetBottom, startPos.Diamension, startPos.widgetKey, startPos.label));
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetTop, node.Diamension, node.widgetKey, node.label));
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        break;
      }
    }
    return endPos;
  }
  List<OffsetXY> GetCoordinateRightPos(DrawCanvasNode startPos, List<OffsetXY> endPos) {
    print("GetCoordinateRightPos startPos : ${startPos.label}, ${startPos.OffsetTop}, ${startPos.OffsetRight} ");
    flagExit = false;
    
    for(DrawCanvasNode node in FieldController.nodes) { 
      if( ((startPos.OffsetTop == node.OffsetTop) && (startPos.OffsetRight == node.OffsetLeft)) && (startPos.widgetKey != node.widgetKey) ) {
        print("111 node label : ${node.label}");
        endPos.add(OffsetXY(node.OffsetRight, node.OffsetTop, node.Diamension, node.widgetKey, node.label));
      //  endPos.add(OffsetXY(node.OffsetRight, node.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        
        break;
      }
      else if ( ((startPos.OffsetTop > node.OffsetTop) && (startPos.OffsetBottom > node.OffsetBottom)) && (startPos.OffsetRight == node.OffsetLeft) 
            && (startPos.widgetKey != node.widgetKey)) {
        print("222 node label : ${node.label}");
        endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetTop, startPos.Diamension, startPos.widgetKey, startPos.label));
        endPos.add(OffsetXY(node.OffsetLeft, node.OffsetTop, node.Diamension, node.widgetKey, node.label));
        break;

      }
      else if(((startPos.OffsetTop < node.OffsetTop) && (startPos.OffsetBottom > node.OffsetTop))&& (startPos.OffsetRight == node.OffsetLeft) && (startPos.widgetKey != node.widgetKey)) {
        print("333 node label : ${node.label}");
        endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetTop, startPos.Diamension, startPos.widgetKey, startPos.label));
        endPos.add(OffsetXY(node.OffsetLeft, node.OffsetTop, node.Diamension, node.widgetKey, node.label));
      //  endPos.add(OffsetXY(node.OffsetRight, node.OffsetTop, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( (startPos.OffsetBottom == node.OffsetTop) 
            && ( (startPos.OffsetLeft < node.OffsetLeft) && (startPos.OffsetRight > node.OffsetLeft) )
            && (startPos.OffsetRight < node.OffsetRight) && (startPos.widgetKey != node.widgetKey) ) {
        print("444 node label : ${node.label}");
        for(DrawCanvasNode node2 in FieldController.nodes) { 
          if( (node.OffsetTop == node2.OffsetTop) && (startPos.OffsetBottom == node.OffsetTop) && (node.label != node2.label) ) {
            endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetTop, node.Diamension, node.widgetKey, node.label));
            endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetBottom, node.Diamension, node.widgetKey, node.label));
            return endPos;
          }
        }
        
        var Result = ListOffsetFunc.listOffsetRight.firstWhere((element) => node.OffsetRight < element.Offset, orElse: () => OffsetPoint2(node.OffsetRight, node.label));
        DrawCanvasNode? temp;
        if(Result.Label != node.label) {
          print("Result Label : ${Result.Label}");
          
          endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetTop, node.Diamension, node.widgetKey, node.label));
          for(DrawCanvasNode node2 in FieldController.nodes) { 
            if(Result.Label == node2.label) {
              temp = node2;
              break;
            }
          }
          var Result2 = ListOffsetFunc.listOffsetRight.firstWhere((element) =>  temp!.OffsetRight > element.Offset);
          print(" Result2 : ${Result2.Label}");
          if(temp!.label == Result2.Label) {
            if( (startPos.OffsetTop == temp.OffsetBottom)
                  && ( (startPos.OffsetLeft < temp.OffsetLeft) && (startPos.OffsetRight > temp.OffsetLeft) )
                  && (startPos.OffsetRight < temp.OffsetRight) && (startPos.widgetKey != temp.widgetKey) ) {
                endPos.add(OffsetXY(temp.OffsetLeft, temp.OffsetBottom, temp.Diamension, temp.widgetKey, temp.label));      
                endPos.add(OffsetXY(temp.OffsetLeft, temp.OffsetTop, temp.Diamension, temp.widgetKey, temp.label));      
            } 
            else if( (startPos.OffsetRight == temp.OffsetLeft) && (startPos.widgetKey != temp.widgetKey)
                  &&((startPos.OffsetTop < temp.OffsetBottom) && (startPos.OffsetBottom > temp.OffsetBottom)) ) {
              endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetTop, startPos.Diamension, startPos.widgetKey, startPos.label));
              endPos.add(OffsetXY(temp.OffsetLeft, temp.OffsetTop, temp.Diamension, temp.widgetKey, temp.label));      
            }
          }
          else {
            print("Result.Label == Result2.Label [${Result2.Label}]");
            for(DrawCanvasNode node2 in FieldController.nodes) { 
              if(Result2.Label == node2.label) {
                temp = node2;
                print("temp : ${temp.label}");
                break;
              }
            }
            endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetBottom, temp!.Diamension, temp.widgetKey, temp.label));
         //   endPos.add(OffsetXY(temp!.OffsetRight, temp.OffsetTop, temp.Diamension, temp.widgetKey, temp.label));
          }
        }
        else {
          print("else");
          endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetTop, node.Diamension, node.widgetKey, node.label));
          endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        }
        break;
      }
      else if( (startPos.OffsetBottom == node.OffsetTop) && (startPos.OffsetRight == node.OffsetLeft) && (startPos.widgetKey != node.widgetKey) ) {
        print(" 555 node label : ${node.label}");
        endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetTop, startPos.Diamension, startPos.widgetKey, startPos.label));
        endPos.add(OffsetXY(node.OffsetLeft, node.OffsetTop, node.Diamension, node.widgetKey, node.label));
     //  endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetBottom, startPos.Diamension, startPos.widgetKey, startPos.label));
        break;
      }
      else if((startPos.OffsetBottom == node.OffsetTop) && (startPos.OffsetLeft == node.OffsetLeft) && (startPos.widgetKey != node.widgetKey)) {
        print("666 node label : ${node.label}");
        endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetTop, startPos.Diamension, startPos.widgetKey, startPos.label));
        for(DrawCanvasNode node2 in FieldController.nodes) { 
          if( (startPos.OffsetTop < node2.OffsetTop) && (startPos.OffsetBottom > node2.OffsetTop) && (startPos.OffsetRight == node2.OffsetLeft)) {
            print("6667 node label : ${node2.label}");
            endPos.add(OffsetXY(node2.OffsetLeft, node2.OffsetTop, node2.Diamension, node2.widgetKey, node2.label));
          //  endPos.add(OffsetXY(node2.OffsetRight, node2.OffsetTop, node2.Diamension, node2.widgetKey, node2.label));
            return endPos;
          }
        }
        for(int i=0; i< ListOffsetFunc.listOffsetRight.length; i++) {
        //  if(ListOffsetFunc.listOffsetRight[i].Label == startPos.label) continue;
          for(DrawCanvasNode node2 in FieldController.nodes) { 
            if(/* (ListOffsetFunc.listOffsetRight[i].Offset == startPos.OffsetRight) 
                &&*/ (((ListOffsetFunc.listOffsetRight[i].Offset == node2.OffsetLeft) && (node.OffsetTop < node2.OffsetTop) 
                && (node.OffsetBottom > node2.OffsetTop) )) 
                && (ListOffsetFunc.listOffsetRight[i].Label != node2.label) ) {
              print("66668 node label : ${node2.label}");
              endPos.add(OffsetXY(node2.OffsetLeft, node2.OffsetTop, node2.Diamension, node2.widgetKey, node2.label));
              i = ListOffsetFunc.listOffsetRight.length;
              //break;
              return endPos;
            }    
          }
        
        }
        endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetBottom, node.Diamension, node.widgetKey, node.label));
        break;
      }
      else if( (startPos.OffsetBottom == node.OffsetTop) && ((startPos.OffsetLeft > node.OffsetLeft) && (startPos.OffsetLeft < node.OffsetRight))
          && ((startPos.OffsetRight > node.OffsetLeft) && (startPos.OffsetRight < node.OffsetRight))
          && (startPos.widgetKey != node.widgetKey) ) {
          print(" 7777 node label : ${node.label}");
          endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetTop, startPos.Diamension, startPos.widgetKey, startPos.label));
          endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetBottom, node.Diamension, node.widgetKey, node.label));
         //endPos.add(OffsetXY(startPos.OffsetRight, startPos.OffsetBottom, startPos.Diamension, startPos.widgetKey, startPos.label));
      }
      
    }
    
    return endPos;
  }
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
    path.addRect(Rect.fromCenter(center: Offset(nodelist.OffsetX/*+(nodelist.sizeX/2)*/, nodelist.offsetY/*+(nodelist.sizeY/2)*/), width: nodelist.SizeX, height: nodelist.SizeY));
    path.close();
    canvas.drawPath(path, oulinePaint);

    canvas.drawLine(Offset(nodelist.OffsetX-200, nodelist.offsetY), Offset(nodelist.OffsetX+200, nodelist.offsetY), oulinePaint2);
    canvas.drawLine(Offset(nodelist.OffsetX, nodelist.offsetY-200), Offset(nodelist.OffsetX, nodelist.offsetY+200), oulinePaint2);
  }

  void _drawNodes(Canvas canvas, DrawCanvasNode nodelist) {
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 10,
    );
    Path path = Path();
    path.addRect(Rect.fromCenter(center: Offset(nodelist.OffsetX, nodelist.OffsetY), width: nodelist.SizeX, height: nodelist.SizeY));
    path.close();
    canvas.drawPath(path, nodePaint);
    
   
    _drawText(canvas,nodelist.offsetX, nodelist.offsetY, "(${nodelist.label})", textStyle);
    if(viewSetting.viewAll) {
      _drawText(canvas, nodelist.offsetX-(nodelist.SizeX/2), nodelist.offsetY-(nodelist.SizeY/2), ("가로:${(nodelist.offsetX-(nodelist.SizeX/2)).toStringAsFixed(1)} \n 세로:${(nodelist.offsetY-(nodelist.SizeY/2)).toStringAsFixed(1)}"),  textStyle);
      _drawText(canvas, nodelist.offsetX+(nodelist.SizeX/2), nodelist.offsetY+(nodelist.SizeY/2), ("가로:${(nodelist.offsetX+(nodelist.SizeX/2)).toStringAsFixed(1)} \n 세로:${(nodelist.offsetY+(nodelist.SizeY/2)).toStringAsFixed(1)}}"), textStyle);
    }
    
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

    // PathOperation aaava;  
    for(DrawCanvasNode nodelist in FieldController.nodes) {
      _drawNodes(canvas, nodelist);

      // canvas.drawPath(Path.combine(aaava, path1, path2));
      if(nodelist.isSelect) {
        _drawOutline(canvas, nodelist);
        _drawText(canvas,nodelist.offsetX, nodelist.offsetY-10, "(${nodelist.offsetX.toStringAsFixed(1)}, ${nodelist.offsetY.toStringAsFixed(1)})", textStyle);
      
      /* if(nodelist.overlapXLine) {
        //print("nodelist.overlapXLine : ${nodelist.overlapXLine}, $verifyNode");
          canvas.drawLine(Offset(nodelist.offsetX-(nodelist.SizeX/2), nodelist.offsetY-200), Offset(nodelist.offsetX-(nodelist.SizeX/2), nodelist.offsetY+200), overlapPaint);
          nodelist.ChangedPosition_X(verifyNode);
          nodelist.overlapXLine = false;
        }*/
        if(nodelist.overlapXLine) {
        //  print("nodelist.overlapXLine : ${nodelist.overlapXLine}, $verifyNode");
          canvas.drawLine(Offset(nodelist.OffsetLeft, nodelist.offsetY-200), Offset(nodelist.OffsetLeft, nodelist.offsetY+200), overlapPaint);
          nodelist.ChangedPosition_X(verifyNode);
        // FieldController.ChangedPositionX(verifyNode, nodelist.widgetKey);
          nodelist.overlapXLine = false;
        }
        if(nodelist.overlapXLine2) {
      //  print("nodelist.overlapXLine2 : ${nodelist.overlapXLine2} $verifyNode");
          canvas.drawLine(Offset(nodelist.OffsetRight, nodelist.offsetY-200), Offset(nodelist.OffsetRight, nodelist.offsetY+200), overlapPaint);
          nodelist.ChangedPosition_X(verifyNode);
          nodelist.overlapXLine2 = false;
        }
        if(nodelist.overlapXLine3) {
      //  print("nodelist.overlapXLine3 : ${nodelist.overlapXLine3} $verifyNode");
          canvas.drawLine(Offset(nodelist.OffsetRight, nodelist.offsetY-200), Offset(nodelist.OffsetRight, nodelist.offsetY+200), overlapPaint);
          nodelist.ChangedPosition_X(verifyNode);
          nodelist.overlapXLine3 = false;
        }
        if(nodelist.overlapXLine4) {
          canvas.drawLine(Offset(nodelist.OffsetLeft, nodelist.offsetY-200), Offset(nodelist.OffsetLeft, nodelist.offsetY+200), overlapPaint);
          nodelist.ChangedPosition_X(verifyNode);
          nodelist.overlapXLine4 = false;
        }

        if(nodelist.overlapYLine ) {
        //print("nodelist.overlapXLine : ${nodelist.overlapXLine}");
          canvas.drawLine(Offset(nodelist.offsetX-200, nodelist.OffsetTop), Offset(nodelist.offsetX+200, nodelist.OffsetTop), overlapPaint);
          nodelist.ChangedPosition_Y(verifyNode2);
          nodelist.overlapYLine = false;
        }
        if(nodelist.overlapYLine2) {
      //  print("nodelist.overlapYLine2 : ${nodelist.overlapYLine2} $verifyNode2");
          canvas.drawLine(Offset(nodelist.offsetX-200, nodelist.OffsetBottom), Offset(nodelist.offsetX+nodelist.sizeX+200, nodelist.OffsetBottom), overlapPaint);
          nodelist.ChangedPosition_Y(verifyNode2);
          nodelist.overlapYLine2 = false;
        }
        if(nodelist.overlapYLine3) {
        //print("nodelist.overlapYLine3 : ${nodelist.overlapYLine3} $verifyNode2");
          canvas.drawLine(Offset(nodelist.offsetX-200, nodelist.OffsetBottom), Offset(nodelist.offsetX+nodelist.sizeX+200, nodelist.OffsetBottom), overlapPaint);
          nodelist.ChangedPosition_Y(verifyNode2);
          nodelist.overlapYLine3 = false;
        }
        if(nodelist.overlapYLine4 ) {
    //    print("nodelist.overlapXLine4 : ${nodelist.overlapYLine4}");
          canvas.drawLine(Offset(nodelist.offsetX-200, nodelist.OffsetTop), Offset(nodelist.offsetX+200, nodelist.OffsetTop), overlapPaint);
          nodelist.ChangedPosition_Y(verifyNode2);
          nodelist.overlapYLine4 = false;
        }
      }
    }
    if (viewSetting.viewLine){
      _drawViewLine(canvas);
    }
     
  }
  @override
  void paint(Canvas canvas, Size size) {
    _drawCanvas(canvas);
    if(viewSetting.viewLine) {
   //   for(DrawCanvasNode nodelist in FieldController.nodes) {
   //     _drawViewLine(canvas, nodelist);
   //   }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}

/*
//        if(eachOffsetPoint.loopCnt == 0) {
          if(eachOffsetPoint.flagEndX ==false || eachOffsetPoint.flagEndX == false) {
            print("eachOffsetPoint.flagEndX ==false && eachOffsetPoint.flagEndX == false");
            eachOffsetPoint = SerarchTopPoint(eachOffsetPoint);
            eachOffsetPoint = SerarchRightPoint(eachOffsetPoint);
          }
          if(eachOffsetPoint.flagEndY == false) {
            eachOffsetPoint = SerarchBottomPoint(eachOffsetPoint);
          }
          print("eachOffsetPoint.flagEndX ==${eachOffsetPoint.flagEndX} && eachOffsetPoint.flagEndY == ${eachOffsetPoint.flagEndY} && eachOffsetPoint.flagStartX == ${eachOffsetPoint.flagStartX}");
          if(eachOffsetPoint.flagEndX ==true && eachOffsetPoint.flagEndY == true && eachOffsetPoint.flagStartX == false) {
            
            eachOffsetPoint = SerarchLeftPoint(eachOffsetPoint);
          }

        print("startingPoint : ${eachOffsetPoint.startingPoint.label}");
        */