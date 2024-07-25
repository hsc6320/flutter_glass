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
  int nodeCnt = -1;

  void GetChild(DrawCanvasNode child) {
    if(!nodes.contains(child.widgetKey) ) {
      print("GetChild() nodes length : ${nodes.length}");
      nodes.add(child);
    }

  }

  void NodeCount() {
    nodeCnt++;
    notifyListeners();
  }

  void add(DrawCanvasNode child) {
    nodes.add(child);
    print("nodes length : ${nodes.length} ${child.key} ${child.widgetKey}");
    notifyListeners();
  }

  void delete(DrawCanvasNode child) {
    print("before delete nodes length : ${nodes.length}, ${child.key}, ${child.widgetKey}");
    nodes.removeWhere((element) => element.key == child.key);
    print("after delete nodes length : ${nodes.length} ");
    notifyListeners();
  }

  void ChangedSizeX (double sizeX, UniqueKey unikey) {
    print("list.ChangedSizeX $unikey, ${nodes.length}");
    for(DrawCanvasNode list in nodes) {
      print("${list.widgetKey}, $unikey");
      if(list.widgetKey == unikey)
        list.ChangedSize_X(sizeX);
        print("list.ChangedSizeX : ${list.ChangedSizeX}");
    }
    notifyListeners();
  }

  void ChangedSizeY (double sizeY, UniqueKey unikey) {
        print("list.ChangedSizeX ");
    for(DrawCanvasNode list in nodes) {
      if(list.widgetKey == unikey)
        list.ChangedSize_Y(sizeY);
        print("list.ChangedSizeX : ${list.ChangedSizeY}");
    }
    notifyListeners();
  }

  void ChangedPositionX (double poX, UniqueKey unikey) {
     for(DrawCanvasNode list in nodes) {
      if(list.widgetKey == unikey)
        list.ChangedPosition_X(poX);
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