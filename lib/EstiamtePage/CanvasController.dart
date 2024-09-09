import 'package:flutter/material.dart';
import 'package:glassapp/EstiamtePage/CanvasNode.dart';

typedef NodeFormatter = void Function(DrawCanvasNode);

class CanvasController extends ChangeNotifier {
 /* CanvasController({
    List<DrawCanvasNode> nodes = const [],
  }){
    if (nodes.isNotEmpty) {
      this.nodes.addAll(nodes);
    }
  }*/
  //@override
  List<DrawCanvasNode> nodes = [];
  double _scale = 1;

  void GetChild(DrawCanvasNode child) {
    if(!nodes.contains(child.widgetKey) ) {
      print("GetChild() nodes length : ${nodes.length}");
      nodes.add(child);
    }

  }


  void add(DrawCanvasNode child) {
    nodes.add(child);
    SetScale(this._scale.toString());
    SetOffsetScale();
    print("nodes length : ${nodes.length} ${child.key} ${child.widgetKey}");
    notifyListeners();
  }

  void delete(DrawCanvasNode child) {
    print("before delete nodes length : ${nodes.length}, ${child.key}, ${child.widgetKey}");
    nodes.removeWhere((element) => element.key == child.key);
    print("after delete nodes length : ${nodes.length} ");
    notifyListeners();
  }
  void SetScale (String scale) {
    for(DrawCanvasNode list in nodes) {
      list.ChangedScale(double.parse(scale));
      print("SetScale list.ChangedScale : $scale");
    }
    this._scale = double.parse(scale);
  }
  void SetOffsetScale () {
    for(DrawCanvasNode list in nodes) {
      list.ChangedScaleOffset(list.offsetX, list.offsetY);
      print("SetOffsetScale : ${list.offsetX} ${list.offsetY}");
    }
    notifyListeners();
  }

  void ChangedOffset (DrawCanvasNode node, double offsetX, double offsetY) {
   // print("Controller ChangedOffset : label(${node.label}), $offsetX, $offsetY");
    node.ChangedScaleOffset(offsetX, offsetY);
    notifyListeners();
  }

  void ChangedOffset2 (DrawCanvasNode node, double offsetX, double offsetY) {
    print("Controller ChangedOffset22 : label(${node.label}), nodeKey : ${node.key}/${node.widgetKey}, $offsetX");
    node.ChangedScaleOffset(offsetX, offsetY);
  //  notifyListeners();
    
  }
  void onPanUpdateOffset(DrawCanvasNode node, double poX, double poY){
    node.ChangedPosition_X(poX);
    node.ChangedPosition_Y(poY);
    notifyListeners();
  }

  void ChangedScale (String scale) {
    for(DrawCanvasNode list in nodes) {
      list.ChangedScale(double.parse(scale));
      print("list.ChangedScale : $scale");
    }
    this._scale = double.parse(scale);
    notifyListeners();
  }
  

  void ChangedSizeX (double sizeX, UniqueKey unikey) {
    print("list.ChangedSizeX $unikey, ${nodes.length}");
    for(DrawCanvasNode list in nodes) {
      print("${list.widgetKey}, $unikey");
      if(list.widgetKey == unikey)
        list.ChangedSize_X(sizeX);
        print("list.ChangedSizeX : ${list.SizeX}");
    }
    notifyListeners();
  }

  void ChangedSizeY (double sizeY, UniqueKey unikey) {
        print("list.ChangedSizeX ");
    for(DrawCanvasNode list in nodes) {
      if(list.widgetKey == unikey)
        list.ChangedSize_Y(sizeY);
        print("list.ChangedSizeX : ${list.SizeY}");
    }
    notifyListeners();
  }

  void ChangedPositionX (double poX, UniqueKey unikey) {
    for(DrawCanvasNode list in nodes) {
      if(list.widgetKey == unikey)
        list.ChangedPosition_X(poX);
        print("widgetkey : ${list.widgetKey} list.ChangedPosition_X : ${list.OffsetX}");
    }
    notifyListeners();
  }

  void ChangedPositionY (double poY, UniqueKey unikey) {
    for(DrawCanvasNode list in nodes) {
      if(list.widgetKey == unikey) {
        list.ChangedPosition_Y(poY);
      }
    }
    notifyListeners();
  }

  void ChangedLabel (String label, UniqueKey unikey) {
    for(DrawCanvasNode list in nodes) {
      if(list.widgetKey == unikey) {
        list.Changed_Label(label);
      }
    }
    notifyListeners();
  }

}