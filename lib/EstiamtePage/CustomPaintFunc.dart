

import 'package:flutter/material.dart';
import 'package:glassapp/EstiamtePage/CanvasController.dart';
import 'package:glassapp/EstiamtePage/CanvasNode.dart';

class OffsetPoint2 {
  double _offset =0;
  String _label ="";
  
  OffsetPoint2(this._offset,this._label);

  double get Offset => _offset;
  String get Label => _label;
  
}

class OffsetXY {
  double _offsetX =0;
  double _offsetY =0;
  double _diamension =0;
  UniqueKey? uniKey;
  String? label;

  OffsetXY(this._offsetX, this._offsetY, this._diamension, this.uniKey, this.label);

  double get OffsetX => _offsetX;
  double get OffsetY => _offsetY;
  double get Diamension => _diamension;
}


class OffsetLineXY {
  double _offsetX =0;
  double _offsetY =0;
  bool allowMove = false;
  String? label;

  OffsetLineXY(this._offsetX, this._offsetY, this.allowMove, this.label);

  double get OffsetX => _offsetX;
  double get OffsetY => _offsetY;
}


class OffsetPoint {
  double offsetX = 0;
  double offsetY =0;
  bool allowMove =false;

  OffsetPoint(this.offsetX, this.offsetY, this.allowMove);
}


class listOffsetTBLR {
  /*
  List<OffsetXY> listOffset2 = [];
  List<OffsetXY> listOffset3 = [];
  List<OffsetPoint2> listOffsetTop = [];
  List<OffsetPoint2> listOffsetLeft = [];
  List<OffsetPoint2> listOffsetRight = [];
  //List<OffsetXY> offsetPoint = [];  */
  //Map<String ,Map<double, double>> mapOffsetPoint = {};

  List<OffsetPoint> listOffsetPoint = [];
  

  List<OffsetLineXY> offsetLinePoint = [];
  List<OffsetXY> offsetPoint = [];
  List<OffsetPoint2> listOffsetLeft = [];
  List<OffsetPoint2> listOffsetBottom = [];
  List<OffsetPoint2> listOffsetRight= [];
  List<OffsetPoint2> listOffsetTop = [];
  Map<double, double> mapOffset = {};
  Map<String, String> mapfieldCtrl = {};
}

class CalculateRowAxis {
  
  CanvasController FieldController;
  
  CalculateRowAxis(
    this.FieldController,
  );
  
  double _rightOffset = 0, _bottomOffset =0;
  double _leftOffset =0, _topOffset =0;
  String _label ="";

  String get Label {
    return _label;
  }
  set Label(String value) { 
    _label = value;
  }

  double get leftOffset {
    return _leftOffset;
  }
  set leftOffset(double value) { 
    _leftOffset = value;
  }
  double get topOffset {
    return _topOffset;
  }
  set topOffset(double value) { 
    _topOffset = value;
  }

  double get rightOffset {
    return _rightOffset;
  }
  set rightOffset(double value) { 
    _rightOffset = value;
  }

  double get bottomOffset {
    return _bottomOffset;
  }
  set bottomOffset(double value) { 
    _bottomOffset = value;
  }

  DrawCanvasNode CalculateStartingPointY() {
    listOffsetTBLR ListOffsetFunc = new listOffsetTBLR();
    DrawCanvasNode? StartPointing;

    for(DrawCanvasNode node in FieldController.nodes) {
      ListOffsetFunc.listOffsetTop.add(OffsetPoint2(node.OffsetTop, node.label));
    }
    ListOffsetFunc.listOffsetTop.sort((a, b) => a.Offset.compareTo(b.Offset));
    topOffset =  ListOffsetFunc.listOffsetTop.first.Offset;
    Label = ListOffsetFunc.listOffsetTop.first.Label;


    for(DrawCanvasNode node in FieldController.nodes) {
      if( (node.OffsetTop == topOffset) && (node.label == Label) ) {
        StartPointing = node;
        break;
      }
    }

    return  StartPointing!;
  }

  DrawCanvasNode CalculateStartingPointX() {
    listOffsetTBLR ListOffsetFunc = new listOffsetTBLR();
    
    for(DrawCanvasNode node in FieldController.nodes) {
      ListOffsetFunc.mapOffset[node.OffsetLeft] = node.OffsetTop;
    }
    
    Map<double, double> sortedMap = Map.fromEntries(
      ListOffsetFunc.mapOffset.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key))
    );

    Map<double, double> sortedMap2 = Map.fromEntries(
      ListOffsetFunc.mapOffset.entries.toList()..sort((e1, e2) => e1.value.compareTo(e2.value))
    );

    double keyy =0, val =0, keyy2 =0, val2 =0;
  
    keyy = sortedMap.keys.toList().first;
    val = sortedMap.values.toList().first;
    //print("keyy : $keyy, val : $val");
    keyy2 = sortedMap2.keys.toList().first;
    val2 = sortedMap2.values.toList().first;
   // print("keyy2 : $keyy2, val2 : $val2");

    if(keyy == keyy2) {
      leftOffset = keyy2;
      topOffset = val2;
    }
    else {
      leftOffset = keyy;
      topOffset = val;
    }
    DrawCanvasNode? StartPointing;
    for(DrawCanvasNode node in FieldController.nodes) {
      if( (node.OffsetTop == topOffset) && (node.OffsetLeft == leftOffset) ) {
        StartPointing = node;
        break;
      }
    }
    //Ret.add(OffsetXY(leftOffset, topOffset, 0, null , "0"));
    return StartPointing!;
  }

  DrawCanvasNode CalculateEndYPoint () {
    List<OffsetPoint2> offsetBLabel = [];
    DrawCanvasNode? endYPointing;

    offsetBLabel = Calculate_Y();
    for(DrawCanvasNode node in FieldController.nodes) {
      if( (node.OffsetBottom == offsetBLabel.first.Offset) && (node.label == offsetBLabel.first.Label) ) {
        endYPointing = node;
      }
    }
    return endYPointing!;
  }

  DrawCanvasNode CalculateEndXPoint () {
    List<OffsetXY> offsetRB = [];
    DrawCanvasNode? endXPointing;

    offsetRB = Calculate_X();
    for(DrawCanvasNode node in FieldController.nodes) {
      if(node.OffsetRight == offsetRB.first.OffsetX && node.OffsetBottom == offsetRB.first.OffsetY) {
        endXPointing = node;
      }
    }
    return endXPointing!;
  }

  List<OffsetPoint2> Calculate_Y () {
    listOffsetTBLR ListOffsetFunc = new listOffsetTBLR();
    double bott =0;
    String label;
    List<OffsetPoint2> Ret = [];

    for(DrawCanvasNode node in FieldController.nodes) {
      ListOffsetFunc.listOffsetBottom.add(OffsetPoint2(node.OffsetBottom, node.label));
    }
    ListOffsetFunc.listOffsetBottom.sort((a, b) => a.Offset.compareTo(b.Offset));
    bott =  ListOffsetFunc.listOffsetBottom.last.Offset;
    label = ListOffsetFunc.listOffsetBottom.last.Label;
    Ret.add(OffsetPoint2(bott, label));
   // print("Calculate_Y : $bott[$label]");
    return Ret;
  }

  List<OffsetXY> Calculate_X () {
    List<OffsetXY> Ret = [];
    double val=0, val2 =0;
    double keyy =0, keyy2 =0;
    
    int idx =0;
    listOffsetTBLR ListOffsetFunc = new listOffsetTBLR();

    for(DrawCanvasNode node in FieldController.nodes) {
      ListOffsetFunc.mapOffset[node.OffsetRight] = node.OffsetBottom;
    }
    
    Map<double, double> sortedMap = Map.fromEntries(
      ListOffsetFunc.mapOffset.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key))
    );

    Map<double, double> sortedMap2 = Map.fromEntries(
      ListOffsetFunc.mapOffset.entries.toList()..sort((e1, e2) => e1.value.compareTo(e2.value))
    );

    sortedMap.forEach((key, value) {
      if(idx == sortedMap.length-1) {
        keyy = key;
        val = value;
      }
      idx++;
    });
    idx =0;
    sortedMap2.forEach((key, value) {
      if(idx == sortedMap2.length-1) {
        keyy2 = key;
        val2 = value;
      }
      idx++;
    });

    if(keyy == keyy2) {
      rightOffset = keyy2;
      bottomOffset = val2;
    }
    else {
      rightOffset = keyy;
      bottomOffset = val;
    }

    Ret.add(OffsetXY(rightOffset, bottomOffset, 0, null , "0"));
   // print("Calculate_X, ${_rightOffset}, ${_bottomOffset}");
    return Ret;
  }
}

class OffsetFunc {
  OffsetFunc({
    required this.FieldController,
  });

  final CanvasController FieldController;
  

  bool findOverlapEndPoint(DrawCanvasNode tmpNode) {
    print("findOverlapEndPoint()");
    for(DrawCanvasNode node in FieldController.nodes) {
      if(  (tmpNode.OffsetTop == node.OffsetBottom) && (tmpNode.label != node.label)) {
          print("1111");
          return true;
      }
      else if( (tmpNode.OffsetTop == node.OffsetBottom) && (tmpNode.OffsetLeft == node.OffsetRight) && (tmpNode.OffsetLeft == node.OffsetLeft) && (tmpNode.label != node.label)) {
        print("2222");
          return true;
      }
      else if( ((tmpNode.OffsetTop < node.OffsetBottom) &&(tmpNode.OffsetTop > node.OffsetTop))  && ((tmpNode.OffsetLeft == node.OffsetRight) || (tmpNode.OffsetLeft == node.OffsetLeft)) && (tmpNode.label != node.label)) {
        print("66665");
        return true;
      }
      else if( (tmpNode.OffsetTop == node.OffsetBottom) && (tmpNode.OffsetRight == node.OffsetRight) && (tmpNode.OffsetRight == node.OffsetLeft) && (tmpNode.label != node.label)) {
        print("3333");
        return true;
      }
      else if( (tmpNode.OffsetBottom == node.OffsetBottom) && (tmpNode.label != node.label) ) {
        print("4444");
        return true;
      }
      else {
        print("55555");
      }
    }
    return false;
  }
}