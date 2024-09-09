
import 'package:flutter/material.dart';
import 'package:glassapp/EstiamtePage/CanvasController.dart';
import 'package:glassapp/EstiamtePage/CanvasNode.dart';
import 'package:glassapp/EstiamtePage/CustomPaintFunc.dart';


class OffsetTBLR {
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

class CombineSurface {
  
  listOffsetTBLR ListOffsetFunc;
   CanvasController FieldController;

  CombineSurface(this.ListOffsetFunc, this.FieldController);

  listOffsetTBLR CombineSurfaceBottom(listOffsetTBLR listFunc, DrawCanvasNode fieldCtrl) {
    print('CombineSurfaceBottom() ${listFunc.listOffsetPoint.length}, fieldCtrl : ${fieldCtrl.label}');

    listFunc.listOffsetPoint.sort((a, b) => a.offsetX.compareTo(b.offsetX));

    var Result2 = listFunc.listOffsetPoint.firstWhere((element) => element.offsetX == fieldCtrl.OffsetLeft, orElse: () =>  OffsetPoint(-1, -1, false ));
    print("Result2 Val : ${Result2.offsetX}");
    if(Result2.offsetX != -1) {
      listFunc.listOffsetPoint.removeAt(0);
      
    }
    else {
      ListOffsetFunc.listOffsetPoint.insert(0, OffsetPoint(fieldCtrl.OffsetLeft, fieldCtrl.OffsetBottom, true));
      
    }

    var Result = listFunc.listOffsetPoint.lastWhere((element) => element.offsetX >= fieldCtrl.OffsetRight, orElse: () =>  OffsetPoint(-1, -1, false ));
    print("Result Val : ${Result.offsetX}");
    if(Result.offsetX == -1) {
      ListOffsetFunc.listOffsetPoint.add(OffsetPoint(fieldCtrl.OffsetRight, fieldCtrl.OffsetBottom, false));
     
    }
    else {
      listFunc.listOffsetPoint.removeLast();
    }

    listFunc.listOffsetPoint.forEach((element) {
      print(" Complete Sort : ${element.offsetX}, ${element.offsetY}");
    });
     
    return listFunc;
  }

  listOffsetTBLR CombineSurfaceTop(listOffsetTBLR listFunc, DrawCanvasNode fieldCtrl) {
    print('CombineSurfaceTop() ${listFunc.listOffsetPoint.length}, fieldCtrl : ${fieldCtrl.label}');

    listFunc.listOffsetPoint.sort((a, b) => a.offsetX.compareTo(b.offsetX));


    var Result2 = listFunc.listOffsetPoint.firstWhere((element) => element.offsetX > fieldCtrl.OffsetLeft, orElse: () =>  OffsetPoint(-1, -1, false ));
    print("Result2 Val : ${Result2.offsetX}");
    if(Result2.offsetX != -1) {
      ListOffsetFunc.listOffsetPoint.insert(0, OffsetPoint(fieldCtrl.OffsetLeft, fieldCtrl.OffsetTop, true));
    }

    var Result = listFunc.listOffsetPoint.lastWhere((element) => element.offsetX >= fieldCtrl.OffsetRight, orElse: () =>  OffsetPoint(-1, -1, false ));
    print("Result Val : ${Result.offsetX}");
    
    if(Result.offsetX != -1) {
      listFunc.listOffsetPoint.removeLast();
      //ListOffsetFunc.listOffsetPoint.add(OffsetPoint(fieldCtrl.OffsetRight, fieldCtrl.OffsetTop, false));
      print("return true;");
    }
    else {
      ListOffsetFunc.listOffsetPoint.add(OffsetPoint(fieldCtrl.OffsetRight, fieldCtrl.OffsetTop, false));
    }
    return listFunc;
  }

  listOffsetTBLR CombineSurfaceLeft(listOffsetTBLR listFunc, DrawCanvasNode fieldCtrl) {
    print('CombineSurfaceLeft() ${listFunc.listOffsetPoint.length}, fieldCtrl : ${fieldCtrl.label}');

    listFunc.listOffsetPoint.sort((a, b) => a.offsetY.compareTo(b.offsetY));

   var Result2 = listFunc.listOffsetPoint.firstWhere((element) => element.offsetY == fieldCtrl.OffsetTop, orElse: () =>  OffsetPoint(-1, -1, false ));
    print("Result2 Val : ${Result2.offsetX}");
    if(Result2.offsetX != -1) {
      listFunc.listOffsetPoint.removeAt(0);
      
    }
    else {
      ListOffsetFunc.listOffsetPoint.insert(0, OffsetPoint(fieldCtrl.OffsetLeft, fieldCtrl.OffsetTop, true));
      
    }

    var Result = listFunc.listOffsetPoint.lastWhere((element) => element.offsetY >= fieldCtrl.OffsetBottom, orElse: () =>  OffsetPoint(-1, -1, false ));
    print("Result Val : ${Result.offsetY}");
    if(Result.offsetY == -1) {
      ListOffsetFunc.listOffsetPoint.add(OffsetPoint(fieldCtrl.OffsetLeft, fieldCtrl.OffsetBottom, false));
    }
    else {
      listFunc.listOffsetPoint.removeLast();
    }
    listFunc.listOffsetPoint.sort((a, b) => a.offsetY.compareTo(b.offsetY));
    listFunc.listOffsetPoint.forEach((element) {
      print(" Complete Sort : ${element.offsetX}, ${element.offsetY}");
    });
    return listFunc;
  }

  listOffsetTBLR CombineSurfaceRight(listOffsetTBLR listFunc, DrawCanvasNode fieldCtrl) {
    print('CombineSurfaceRight() ${listFunc.listOffsetPoint.length}, fieldCtrl : ${fieldCtrl.label}');

    listFunc.listOffsetPoint.sort((a, b) => a.offsetY.compareTo(b.offsetY));

    var Result2 = listFunc.listOffsetPoint.firstWhere((element) => element.offsetY == fieldCtrl.OffsetTop, orElse: () =>  OffsetPoint(-1, -1, false ));
    print("Result2 Val : ${Result2.offsetX}");
    if(Result2.offsetX != -1) {
      listFunc.listOffsetPoint.removeAt(0);
    }
    else {
      ListOffsetFunc.listOffsetPoint.insert(0, OffsetPoint(fieldCtrl.OffsetRight, fieldCtrl.OffsetTop, true));
    }

    var Result = listFunc.listOffsetPoint.lastWhere((element) => element.offsetY >= fieldCtrl.OffsetBottom, orElse: () =>  OffsetPoint(-1, -1, false ));
    print("Result Val : ${Result.offsetY}");
    if(Result.offsetY == -1) {
      ListOffsetFunc.listOffsetPoint.add(OffsetPoint(fieldCtrl.OffsetRight, fieldCtrl.OffsetBottom, false));
      
    }
    else {
      listFunc.listOffsetPoint.removeLast();
    }

    listFunc.listOffsetPoint.sort((a, b) => a.offsetY.compareTo(b.offsetY));
    listFunc.listOffsetPoint.forEach((element) {
      print(" Complete Sort : ${element.offsetX}, ${element.offsetY}");
    });
    return listFunc;
  }
      
}


