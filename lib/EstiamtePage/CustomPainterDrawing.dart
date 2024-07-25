
//import 'dart:html';
//import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:glassapp/EstiamtePage/CanvasController.dart';
import 'package:glassapp/EstiamtePage/CanvasNode.dart';
import 'package:infinite_canvas/infinite_canvas.dart';
import 'package:zoom_widget/zoom_widget.dart';


Map DrawMap_KeyName = {};
DrawMapInputValue mapInputValue = DrawMapInputValue(100, 100, 1 , 1);

List<NewTextSizeFieldList> listNewTextField = [];
Map<UniqueKey, int> mapShapeIndex = {};
CanvasController controller  = CanvasController();


int listInputValueIndex =0;
int _newTextFieldId2 =10;
bool _trigger = false;
double xoffsetPos =0, yoffsetPos =0;
int panIdx =0;
bool colorVal = false;
final List<Widget> fields2 = [];
final List<Widget> fields3 = [];
final List<widgetControl> _widgetControl = [];
String newTextfieldName = '';
double sliderValue0 = 1.0;


Map<UniqueKey , TextEditingController> _textEditController = {};
Map<UniqueKey , TextEditingController> _textEditController2 = {};
Map<UniqueKey , TextEditingController> _textEditController3 = {};
Map<UniqueKey , TextEditingController> _textEditController5 = {};



class Drawing2D extends StatefulWidget {
  /*ChangeNotifierProvider(
      // 기본 생성자를 사용하여 변경 알림 값 생성
      create: (_) => CanvasController(),
      child: const MaterialApp(
        home: ConsumerTestPage(),
      ),
  ),*/
  @override
  State<Drawing2D> createState() => _Drawing2DState();
}

class _Drawing2DState extends State<Drawing2D> {
  final _formKey = GlobalKey<FormBuilderState>();
  
  late InfiniteCanvasController ccc;
  final List<Widget> fields = [];
  
  final color = Colors.red;
  int idx =0;
  int setIndex =0;
  void SetShapeIndex(CanvasController field) {
    setState(() {
      print("SetShapeIndex() ");
    //  if(mapShapeIndex.length > 0) {
        setIndex =1;
        //for(DrawCanvasNode list in field.nodes) {
        mapShapeIndex.forEach((key, value) {
          field.ChangedLabel(setIndex.toString(), key);
          setIndex++;
        });
      });
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //controller = CanvasController();
    final test = context.watch<CanvasController>();
    //print("Scaffold111");
    return //Consumer<CanvasController> (builder: (_, CanvasController, child ) =>
      Scaffold (
      body : 
      Consumer<CanvasController> (builder: (_, provider, child ) {
       CanvasController FieldController = provider;
       return FormBuilder (
        key: _formKey,
        child : SafeArea (
          minimum: EdgeInsets.all(10),

        child: Scrollbar(
          child: SingleChildScrollView(
          child : Container (
          margin: EdgeInsets.only(top: 1),
          
          child : Column (
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            
            children: <Widget> [
              ...[
                Container(
                  child : Text(
                    textAlign: TextAlign.left,
                    "*줌의 사항"
                  ),
                ),
                Slider(
                  value: sliderValue0, 
                  max: 3,
                  onChanged:(value) {
                    setState(() {
                      sliderValue0 = value;
                    });
                  },
                ),
                Flexible (
                  fit: FlexFit.loose,
                  child : Column (
                    children: [
                       Container (
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(right: 0),
                    //    decoration: BoxDecoration (
                     //     border: Border.symmetric(horizontal: BorderSide(color: const Color.fromARGB(255, 130, 96, 96), width: 2), vertical : BorderSide(color: Colors.black, width: 2))
                    //    ),
                        child : Zoom (
                          scrollWeight : 20,
                          opacityScrollBars : 2,
                          onTap: () {
                            print("줌 클릭");
                            setState(() {

                            });
                          },
                          onPanUpPosition :(details) {
                            setState(() {
                              for(DrawCanvasNode node in provider.nodes) {
                                node.isSelect = false;
                                print("onPanUpPosition : ${details.dx}, ${details.dy}");
                              }
                               panIdx =0;
                            });
                          },
                          child: FittedBox(
                            fit: BoxFit.cover,
                              child: DrawDisplay(ControllerField: provider, sliderInputScale: sliderValue0,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.08,
                      height: MediaQuery.of(context).size.height*0.08,
                    ),
                    Container(
                      width:  MediaQuery.of(context).size.width*0.10,
                    //  height: MediaQuery.of(context).size.height*0.075,
                      child : Text(
                        textAlign: TextAlign.center,
                        "가로\n(미터)"
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.1,
                    ),
                    Container(
                      width:  MediaQuery.of(context).size.width*0.1,
                     // height: MediaQuery.of(context).size.height*0.075,
                      child : Text(
                        textAlign: TextAlign.center,
                        "세로\n(미터)"
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.1,
                    ),
                    Container(
                      width:  MediaQuery.of(context).size.width*0.1,
                  //    height: MediaQuery.of(context).size.height*0.075,
                      child : Text(
                        textAlign: TextAlign.center,
                        "가로\n(좌표)"
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.09,
                    ),
                    Container(
                      width:  MediaQuery.of(context).size.width*0.1,
                   //   height: MediaQuery.of(context).size.height*0.075,
                      child : Text(
                        textAlign: TextAlign.center,
                        "세로\n(좌표)"
                      ),
                    ),
                  ],
                ),
                Column(
                  children : List.generate(provider.nodes.length,(index) {
                    return TextInputFieldState(index: index, 
                           // aaa: listNewTextField[index], 
                            fieldControl: provider,
                            onDelete: () {
                              print("onDelete");
                                setState(() {
                                  var tempkey;
                                 // for(DrawCanvasNode list in FieldController.nodes) {
                                    //for (var entry in DrawMap_KeyName.entries) {
                                    if(DrawMap_KeyName.containsKey(FieldController.nodes[index].widgetKey)) {
                                    //if(entry.value == newTextfieldName) {
                                      print("삭제 유니크 키 : ${FieldController.nodes[index].widgetKey} ");
                                      
                                      mapShapeIndex.remove(FieldController.nodes[index].widgetKey);
                                      SetShapeIndex(FieldController);
                                    
                                      print("remove ${mapInputValue.maptotalSizeY[FieldController.nodes[index].widgetKey]}");
                                      mapInputValue.mapKeyPositionX.remove(FieldController.nodes[index].widgetKey);
                                      mapInputValue.mapKeyPositionY.remove(FieldController.nodes[index].widgetKey);
                                      mapInputValue.maptotalSizeX.remove(FieldController.nodes[index].widgetKey);
                                      mapInputValue.maptotalSizeY.remove(FieldController.nodes[index].widgetKey);
                                      mapInputValue.aa.remove(FieldController.nodes[index].widgetKey);
                                      
                                      _widgetControl.removeWhere((a) => a.uniqueKey == FieldController.nodes[index].widgetKey,);
                                      print("111111${FieldController.nodes[index].widgetKey}");

                                      tempkey = FieldController.nodes[index].widgetKey;
                                      listNewTextField.removeWhere((element) => element.key == FieldController.nodes[index].widgetKey);
                                      
                                      provider.delete(FieldController.nodes[index]);
                                      listInputValueIndex--;
                                    
                                    }
                                //  }
                                  DrawMap_KeyName.remove(tempkey);
                                  if(DrawMap_KeyName.isEmpty) {
                                    listInputValueIndex =0;
                                    setIndex =0;
                                    _newTextFieldId2 =10;
                                  }
                                  //   listInputValueIndex--;
                                });
                            },
                        );
                  })
                ),
             
           //   ...fields2,
              TextButton(
                child: const Text('도형 추가'),
                onPressed: () {
                  //final newTextfieldName;
                  newTextfieldName = 'keyname3_${_newTextFieldId2++}';
                  setState(() {
                    print("도형 추가 렝스 : ${provider.nodes.length}, newTextfieldName : $newTextfieldName");
                    //fields2.removeWhere((e) => e.key == newTextfieldKey);
                    _widgetControl.add(widgetControl(uniqueKey: UniqueKey()));
                  
                    DrawMap_KeyName[_widgetControl[listInputValueIndex].uniqueKey] = newTextfieldName;
                 
                    
                    mapShapeIndex[_widgetControl[listInputValueIndex].uniqueKey] = setIndex;
                    setIndex++;
                    
                    mapInputValue.aa[_widgetControl[listInputValueIndex].uniqueKey] = DrawSizeInputValue(100,100,50,30);
                    mapInputValue.mapKeyPositionY[_widgetControl[listInputValueIndex].uniqueKey] = 50;
                    mapInputValue.mapKeyPositionX[_widgetControl[listInputValueIndex].uniqueKey] = 50;
                    mapInputValue.maptotalSizeX[_widgetControl[listInputValueIndex].uniqueKey] = 100;
                    mapInputValue.maptotalSizeY[_widgetControl[listInputValueIndex].uniqueKey] = 100;
                    listInputValueIndex++;
                    provider.NodeCount();
                  
                    print("도형 추가 됨 위젯키 : ${_widgetControl[listInputValueIndex-1].uniqueKey}");
                    listNewTextField.add (
                      NewTextSizeFieldList(
                        Changecolor: colorVal, 
                        index: mapShapeIndex[_widgetControl[listInputValueIndex-1].uniqueKey]!, 
                        key: _widgetControl[listInputValueIndex-1].uniqueKey,
                        name: newTextfieldName,
                      )
                    );
                  /*  fields2.add( NewTextSizeFieldList(
                      key: _widgetControl[listInputValueIndex-1].uniqueKey,
                      name: newTextfieldName,
                      index: mapShapeIndex[_widgetControl[listInputValueIndex-1].uniqueKey]!, //listInputValueIndex
                      Changecolor: colorVal,
                      onDelete : () {
                        var tempkey;
                        setState(() {
                          print("델리트 fieldname : $newTextfieldName");

                          for (var entry in DrawMap_KeyName.entries) {
                            if(entry.value == newTextfieldName) {
                              print("유니크 키 : ${entry.key} listInputValueIndex : ${DrawMap[entry.key]}");
                              fields2.removeWhere((e) => e.key == entry.key/*_widgetControl[listInputValueIndex].uniqueKey*/);
                            //  fields3.removeWhere((e) => e.key == entry.key/*_widgetControl[listInputValueIndex].uniqueKey*/);
                             
                              mapShapeIndex.remove(entry.key);
                              SetShapeIndex();
                            
                              mapInputValue.mapKeyPositionX.remove(entry.key);
                              mapInputValue.mapKeyPositionY.remove(entry.key);
                              mapInputValue.maptotalSizeX.remove(entry.key);
                              mapInputValue.maptotalSizeY.remove(entry.key);
                              print("remove ${mapInputValue.maptotalSizeY[entry.key]}");
                              mapInputValue.aa.remove(entry.key);

                              print("key : ${_widgetControl[idx].uniqueKey}");
                              _widgetControl.removeWhere((a) => a.uniqueKey == entry.key,);
                              print("111111${entry.key}, ${DrawMap[entry.key]}");

                              tempkey = entry.key;
                              DrawMap.remove(entry.key);
                              listInputValueIndex--;
                            
                              break;
                            }
                          }
                          DrawMap_KeyName.remove(tempkey);
                          if(DrawMap_KeyName.isEmpty) {
                            listInputValueIndex =0;
                            setIndex =0;
                            _newTextFieldId2 =10;
                          }
                       //   listInputValueIndex--;
                        });
                      },
                    )); */
                    final node = DrawCanvasNode(
                      key: UniqueKey(), 
                      widgetKey: _widgetControl[listInputValueIndex-1].uniqueKey,
                      isSelect: false,
                      offsetX: mapInputValue.mapKeyPositionX[_widgetControl[listInputValueIndex-1].uniqueKey]=50, 
                      offsetY: mapInputValue.mapKeyPositionY[_widgetControl[listInputValueIndex-1].uniqueKey]=50,
                      sizeX : mapInputValue.maptotalSizeX[_widgetControl[listInputValueIndex-1].uniqueKey] = 100,
                      sizeY : mapInputValue.maptotalSizeY[_widgetControl[listInputValueIndex-1].uniqueKey] = 100,
                        //Random().nextDouble() * 200 + 100,
                        //Random().nextDouble() * 200 + 100,
                      label: listInputValueIndex.toString(), 
                    );
                    provider.add(node);
                    //controller.add(node);
                    print("사각형 추가 ${node.label}");
                  });
                }
              ),

            ],
          ],
          ),
        ),
        
      ),
          ),
        ),
      
    );
    }),
        
  );
  }
}

typedef PositionX = double?;
typedef PositionY = double?;
typedef MapPosX = Map<UniqueKey, PositionX> ;
typedef MapPosY = Map<UniqueKey, PositionY> ;

typedef SizeX = double?;
typedef SizeY = double?;
typedef MapSizeX = Map<UniqueKey, SizeX> ;
typedef MapSizeY = Map<UniqueKey, SizeY> ;

class DrawSizeInputValue {
  double? totalSizeX;
  double? totalSizeY;
  double? PositionX;
  double? PositionY;

  
  //DrawSizeInputValue({required this.totalSizeX, required this.totalSizeY});
  DrawSizeInputValue(double? totalSizeX, double? totalSizeY, double? PositionX, double? PositionY) {
    this.totalSizeX = totalSizeX;
    this.totalSizeY = totalSizeY;
    this.PositionX = PositionX;
    this.PositionY = PositionY;
  }

}

class DrawMapInputValue extends DrawSizeInputValue {
  Map<UniqueKey , DrawSizeInputValue > aa = {};

  MapPosX mapKeyPositionX = {};
  MapPosY mapKeyPositionY = {};
  MapSizeX maptotalSizeX = {};
  MapSizeY maptotalSizeY = {};
  Map<UniqueKey, bool> inputValue_isChoice = {};

  DrawMapInputValue(double totalSizeX, double totalSizeY, double PositionX, double PositionY) 
    : super(totalSizeX, totalSizeY, PositionX, PositionY) {
    }
  
}

class widgetControl {
  final UniqueKey uniqueKey;
  
  widgetControl({
    required this.uniqueKey,
  });
}


class TextInputFieldState extends StatefulWidget {
  TextInputFieldState({
    required this.index,
    required this.fieldControl,
    required this.onDelete,
  });

  final index;
  final VoidCallback? onDelete;
  final CanvasController fieldControl;
  
  @override
  State<TextInputFieldState> createState() => _TextInputFieldStateState();
}

class _TextInputFieldStateState extends State<TextInputFieldState> {
  TextEditingController textController = TextEditingController();
  
  int mapIndex =0, setIndex =0;
  void initState() {
    super.initState();
    // myController에 리스너 추가
    print("initSater");
    
  }

  // _MyCustomFormState가 제거될 때 호출
  @override
  void dispose() {
    // 텍스트에디팅컨트롤러를 제거하고, 등록된 리스너도 제거된다.
    
    super.dispose();
  }
  void SetShapeIndex() {
    setState(() {
      print("SetShapeIndex() ");
      if(mapShapeIndex.length > 0) {
        mapIndex =0;
        mapShapeIndex.forEach((key, value) {
          mapShapeIndex[key] = mapIndex;
          print("추가 인덱스 확인 : ${key}, $mapIndex");
          mapIndex++;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    //print("_TextInputFieldStateState()");
    double temp = 0;
    TextEditingController textControllerPosY = TextEditingController(text: widget.fieldControl.nodes[widget.index].ChangedPositionY.toStringAsFixed(1));  
    TextEditingController textControllerPosX = TextEditingController(text: widget.fieldControl.nodes[widget.index].ChangedPositionX.toStringAsFixed(1));  
    TextEditingController textControllerSizeY = TextEditingController(text: widget.fieldControl.nodes[widget.index].ChangedSizeY.toStringAsFixed(1));  
    TextEditingController textControllerSizeX = TextEditingController(text: widget.fieldControl.nodes[widget.index].ChangedSizeX.toStringAsFixed(1));  
     return FormBuilder(
    //key: _formKey,
    child : Padding(
      padding: const EdgeInsets.only(top: 1),
      
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children : <Widget> [
           Text(
              textAlign: TextAlign.left,
              style : TextStyle(fontSize : 15,),
              "(${widget.fieldControl.nodes[widget.index].label})"
              //""
            ),
            SizedBox(
              width: 10,
            ),
            Container (
              //alignment: Alignment.bottomLeft,
              width:  MediaQuery.of(context).size.width*0.17,
              height: MediaQuery.of(context).size.height*0.07,
              child : TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                ),
               child : Text(textControllerSizeX.text),
                onPressed: () async {
                  print("onPressed");
                  await showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(textControllerSizeX.text),
                        content: FormBuilderTextField(
                          name: '가로 미터',
                          textAlign: TextAlign.left,
                          textInputAction: TextInputAction.next,
                          style : TextStyle(fontSize : 20,),
                          decoration: InputDecoration(
                            //labelText: 'X 길이',
                          ),
                          onChanged: (val) {
                            setState(() {
                              try {
                                mapInputValue.maptotalSizeX.forEach((key, value) {
                                if(key == widget.fieldControl.nodes[widget.index].widgetKey) {
                                  temp = double.parse(val!);
                                  widget.fieldControl.ChangedSizeX(temp, widget.fieldControl.nodes[widget.index].widgetKey);
                                  mapInputValue.maptotalSizeX[key] = double.parse(val.toString());

                                  if(mapInputValue.maptotalSizeY[key]== null) { mapInputValue.maptotalSizeY[key] =100;}
                                  if(mapInputValue.mapKeyPositionX[key]== null) { mapInputValue.mapKeyPositionX[key] =50;}
                                  if(mapInputValue.mapKeyPositionY[key]== null) { mapInputValue.mapKeyPositionY[key] =50;}

                                  mapInputValue.aa[key] = DrawSizeInputValue(
                                    mapInputValue.maptotalSizeX[key]!, 
                                    mapInputValue.maptotalSizeY[key]!,
                                    mapInputValue.mapKeyPositionX[key]!, 
                                    mapInputValue.mapKeyPositionY[key]!
                                  );
                                }
                              });
                              } on FormatException catch (e) {
                                print("FormatException inside => $e");   
                              }
                            });
                          },
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, temp);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    }
                  );
                }
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Container(
              width:  MediaQuery.of(context).size.width*0.17,
              height: MediaQuery.of(context).size.height*0.07,
              child : TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                ),
                child : Text(textControllerSizeY.text),
                onPressed: () async {
                  print("onPressed");
                  await showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(textControllerSizeY.text),
                        content: FormBuilderTextField(
                          name: '세로 미터',
                          textAlign: TextAlign.left,
                          textInputAction: TextInputAction.go,
                          style : TextStyle(fontSize : 20,),
                          decoration: InputDecoration(
                            //labelText: 'Y 길이',
                          ),
                          onChanged: (val) {
                            setState(() {
                              try {
                                mapInputValue.maptotalSizeY.forEach((key, value) {
                                if(key == widget.fieldControl.nodes[widget.index].widgetKey) {
                                  temp = double.parse(val!);
                                  widget.fieldControl.ChangedSizeY(temp, widget.fieldControl.nodes[widget.index].widgetKey);
                                  mapInputValue.maptotalSizeY[key] = double.parse(val.toString());

                                  if(mapInputValue.maptotalSizeX[key]== null) { mapInputValue.maptotalSizeX[key] =100;}
                                  if(mapInputValue.mapKeyPositionX[key]== null) { mapInputValue.mapKeyPositionX[key] =50;}
                                  if(mapInputValue.mapKeyPositionY[key]== null) { mapInputValue.mapKeyPositionY[key] =50;}

                                  mapInputValue.aa[key] = DrawSizeInputValue(
                                    mapInputValue.maptotalSizeX[key]!, 
                                    mapInputValue.maptotalSizeY[key]!,
                                    mapInputValue.mapKeyPositionX[key]!, 
                                    mapInputValue.mapKeyPositionY[key]!
                                  );
                                }
                              });
                              } on FormatException catch (e) {
                                print("FormatException inside => $e");   
                              }
                            });
                          },
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, temp);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    }
                  );
                }
              ),
            ),
            Spacer(
             flex: 1,
            ),
            Container(
              width:  MediaQuery.of(context).size.width*0.17,
              height: MediaQuery.of(context).size.height*0.07,
              child : TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                ),
               child : Text(textControllerPosX.text),
                onPressed: () async {
                  print("onPressed");
                  await showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(textControllerPosX.text),
                        content: FormBuilderTextField(
                          name: 'X좌표',
                          textAlign: TextAlign.left,
                          textInputAction: TextInputAction.next,
                          style : TextStyle(fontSize : 20,),
                          decoration: InputDecoration(
                            //labelText: 'X 좌표',
                          ),
                          onChanged: (val) {
                            setState(() {
                              try {
                                mapInputValue.mapKeyPositionX.forEach((key, value) {
                                if(key == widget.fieldControl.nodes[widget.index].widgetKey) {
                                  temp = double.parse(val!);
                                  widget.fieldControl.ChangedPositionX(temp, widget.fieldControl.nodes[widget.index].widgetKey);
                                  mapInputValue.mapKeyPositionX[key] = double.parse(val.toString());

                                  if(mapInputValue.maptotalSizeX[key]== null) { mapInputValue.maptotalSizeX[key] =100;}
                                  if(mapInputValue.maptotalSizeY[key]== null) { mapInputValue.maptotalSizeY[key] =100;}
                                  if(mapInputValue.mapKeyPositionY[key]== null) { mapInputValue.mapKeyPositionY[key] =50;}

                                  mapInputValue.aa[key] = DrawSizeInputValue(
                                    mapInputValue.maptotalSizeX[key]!, 
                                    mapInputValue.maptotalSizeY[key]!,
                                    mapInputValue.mapKeyPositionX[key]!, 
                                    mapInputValue.mapKeyPositionY[key]!
                                  );
                                }
                              });
                              } on FormatException catch (e) {
                                print("FormatException inside => $e");   
                              }
                            });
                          },
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, temp);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    }
                  );
                }
              ),
            ),
          Spacer(
           flex: 1,
          ),
          Container(
            width:  MediaQuery.of(context).size.width*0.17,
            height: MediaQuery.of(context).size.height*0.07,
            child : TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 15),
              ),
              child : Text(textControllerPosY.text),
              onPressed: () async {
                  await showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(textControllerPosY.text),
                        content: FormBuilderTextField(
                          name: 'Y좌표',
                          textAlign: TextAlign.left,
                          textInputAction: TextInputAction.go,
                          style : TextStyle(fontSize : 20,),
                          decoration: InputDecoration(
                            //labelText: 'Y 좌표',
                          ),
                          onChanged: (val) {
                            setState(() {
                              try {
                                mapInputValue.mapKeyPositionY.forEach((key, value) {
                                if(key == widget.fieldControl.nodes[widget.index].widgetKey) {
                                  temp = double.parse(val!);
                                  widget.fieldControl.ChangedPositionY(temp, widget.fieldControl.nodes[widget.index].widgetKey);
                                  mapInputValue.mapKeyPositionY[key] = double.parse(val.toString());

                                  if(mapInputValue.maptotalSizeX[key]== null) { mapInputValue.maptotalSizeX[key] =100;}
                                  if(mapInputValue.maptotalSizeY[key]== null) { mapInputValue.maptotalSizeY[key] =100;}
                                  if(mapInputValue.mapKeyPositionX[key]== null) { mapInputValue.mapKeyPositionX[key] =50;}

                                  mapInputValue.aa[key] = DrawSizeInputValue(
                                    mapInputValue.maptotalSizeX[key]!, 
                                    mapInputValue.maptotalSizeY[key]!,
                                    mapInputValue.mapKeyPositionX[key]!, 
                                    mapInputValue.mapKeyPositionY[key]!
                                  );
                                }
                              });
                              } on FormatException catch (e) {
                                print("FormatException inside => $e");   
                              }
                            });
                          },
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, temp);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    }
                  );
              }
            ),
          ),  
            Spacer(
              flex: 1,
            ),
            IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: widget.onDelete,
            ),
          ],
        ),
    ),
    );
  }
}


class DrawDisplay extends StatefulWidget {
  const DrawDisplay ({
    super.key,
    required this.ControllerField,
    required this.sliderInputScale,
  });
  final CanvasController ControllerField;
  final double sliderInputScale;
 
/*  DrawDisplay({
   // super.key,
    required this.sizeInputValue,
    required this.mapInputValue,
 //   required this.name,
  //  required this.Listindex,
 //   this.onDelete,
  });
 // final String name;
 // final int Listindex;
 // final VoidCallback? onDelete;
*/
  @override
  State<DrawDisplay> createState() => _DrawDisplayState();
}

class _DrawDisplayState extends State<DrawDisplay> with SingleTickerProviderStateMixin {
  
  late AnimationController _animationController; // 애니메이션의 시간과 동작을 제어하는 컨트롤러
  late Animation<double> _animation; // 애니메이션 값을 보간하는 객체

  double Top=10, Left =0;
  double verifyOffsetX =0, verifyOffsetY =0;
  int tempidx =0, tempidx2 =0;

  @override
  void initState() {
    super.initState();
    // AnimationController 초기화: 반복 애니메이션으로 설정.
    _animationController = AnimationController(
      duration: const Duration(seconds: 500), // 애니메이션 지속 시간을 1초로 설정
      vsync: this,
    );//..repeat(reverse: true); // 애니메이션을 뒤집어서 반복 실행

    // 애니메이션의 진행 곡선을 설정.
    _animation = Tween<double>(begin: 0, end: 1)
      .chain(CurveTween(curve: Curves.easeInOut))
      .animate(_animationController);
    
  }

  @override
  Widget build(BuildContext context) {
    //print("_DrawDisplayState() ${widget.ControllerField.nodes.length}");
    _trigger = false;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: const Color.fromARGB(255, 130, 96, 96), width: 3), vertical : BorderSide(color: Colors.black, width: 3))
      ),
      child : GestureDetector(
        onPanDown :(details) {
          setState(() {
            //print("onPanDown ${mapInputValue.mapKeyPositionX[_widgetControl[0].uniqueKey]!}, ${mapInputValue.mapKeyPositionY[_widgetControl[0].uniqueKey]!}");
            for(DrawCanvasNode node in widget.ControllerField.nodes) {
              //print("panIdx : $panIdx, ${node.offsetX}, ${details.localPosition.dx}, ${node.offsetY},  ${details.localPosition.dy}, ${node.sizeX}, ${node.sizeY}");
              if( ((node.offsetX-(node.sizeX/2) < details.localPosition.dx) && ((node.offsetX+(node.sizeX/2)) > details.localPosition.dx)) 
                  && ((node.offsetY-(node.sizeY/2) < details.localPosition.dy) && ((node.offsetY+(node.sizeY/2)) > details.localPosition.dy)) ) {
                  node.isSelect = true;
              }
              else {
                node.isSelect = false;
                panIdx++;
              }
            }
          });
        },
        onPanEnd: (details) {
          setState(() {
          });
        },
        onPanUpdate: (details) {
          setState(() {
            xoffsetPos = details.localPosition.dx ;
            yoffsetPos = details.localPosition.dy ;
            for(DrawCanvasNode node in widget.ControllerField.nodes) {
              if(node.isSelect == true) {
                node.offsetX = xoffsetPos;
                node.offsetY = yoffsetPos;
              //  widget.ControllerField.nodes[panIdx].offsetX = xoffsetPos;
              //  widget.ControllerField.nodes[panIdx].offsetY = yoffsetPos;
                mapInputValue.mapKeyPositionX[node.widgetKey] = xoffsetPos;
                mapInputValue.mapKeyPositionY[node.widgetKey] = yoffsetPos;

                //widget.ControllerField.ChangedPositionY(yoffsetPos, widget.ControllerField.nodes[panIdx].key);
                //widget.ControllerField.ChangedPositionX(xoffsetPos, widget.ControllerField.nodes[panIdx].key);
                widget.ControllerField.ChangedPositionY(yoffsetPos, node.key);
                widget.ControllerField.ChangedPositionX(xoffsetPos, node.key);

                for(DrawCanvasNode node2 in widget.ControllerField.nodes) {

                  if( ( (node.offsetX-(node.sizeX/2)+4 >= node2.offsetX-(node2.sizeX/2)) && (node.offsetX-(node.sizeX/2)-4 <= node2.offsetX-(node2.sizeX/2)) ) && (node.widgetKey != node2.widgetKey) ) {
                    node.overlapXLine = true;
               //     print("node.overlapXLine : ${node.overlapXLine} , ${node2.offsetX-(node2.sizeX/2)+(node.sizeX/2)}");
                    print("${node2.offsetX}, ${node.sizeX/2}");
                    verifyOffsetX = node2.offsetX-(node2.sizeX/2)+(node.sizeX/2);
                    tempidx++;
                //    break;
                  }
                  else if( ( (node.offsetX+(node.sizeX/2)+4 >= node2.offsetX-(node2.sizeX/2)) && (node.offsetX+(node.sizeX/2)-4 <= node2.offsetX-(node2.sizeX/2)) ) && (node.widgetKey != node2.widgetKey) ) {
                    node.overlapXLine2 = true;
                    print("node.overlapXLine2 : ${node.overlapXLine2} , ${node2.offsetX-(node2.sizeX/2)-(node.sizeX/2) }");
                    verifyOffsetX = node2.offsetX-(node2.sizeX/2)-(node.sizeX/2);
                    tempidx++;
              //      break;
                  }
                  else if( ( (node.offsetX+(node.sizeX/2)+4 >= node2.offsetX+(node2.sizeX/2)) && (node.offsetX+(node.sizeX/2)-4 <= node2.offsetX+(node2.sizeX/2)) ) && (node.widgetKey != node2.widgetKey) ) {
                    node.overlapXLine3 = true;
               //     print("node.overlapXLine3 : ${node.overlapXLine3} ${node2.offsetX+(node2.sizeX/2)-(node.sizeX/2)}");
                    verifyOffsetX = node2.offsetX+(node2.sizeX/2)-(node.sizeX/2);
                    tempidx++;
                //    break;
                  }
                  else if( ( (node.offsetX-(node.sizeX/2)+4 >= node2.offsetX+(node2.sizeX/2)) && (node.offsetX-(node.sizeX/2)-4 <= node2.offsetX+(node2.sizeX/2)) ) && (node.widgetKey != node2.widgetKey) ) {
                    node.overlapXLine4 = true;
             //       print("node.overlapXLine4 : ${node.overlapXLine4} ${node2.offsetX+(node2.sizeX/2) + (node.sizeX/2)}");
                    verifyOffsetX = node2.offsetX+(node2.sizeX/2) + (node.sizeX/2);
                    tempidx++;
               //     break;
                  }

                  if( ( (node.offsetY-(node.sizeY/2)+4 >= node2.offsetY-(node2.sizeY/2)) && (node.offsetY-(node.sizeY/2)-4 <= node2.offsetY-(node2.sizeY/2)) ) && (node.widgetKey != node2.widgetKey) ) {
                    node.overlapYLine = true;
              //      print("node.overlapYLine : ${node.overlapYLine} ${node2.label}");
                    verifyOffsetY = (node2.offsetY-(node2.sizeY/2)) + (node.sizeY/2);
                    tempidx2++;
                  }
                  else if( ( (node.offsetY+(node.sizeY/2)+4 >= node2.offsetY-(node2.sizeY/2)) &&(node.offsetY+(node.sizeY/2)-4 <= node2.offsetY-(node2.sizeY/2)) ) && (node.widgetKey != node2.widgetKey) ) {
                    node.overlapYLine2 = true;
               //     print("node.overlapYLine2 : ${node.overlapYLine2} ${node2.offsetY-(node2.sizeY/2) - (node.sizeY/2)}, ${node2.offsetY}");
                    verifyOffsetY = node2.offsetY-(node2.sizeY/2) - (node.sizeY/2);
                    tempidx2++;
                  }
                  else if( ( (node.offsetY+(node.sizeY/2)+4 >= node2.offsetY+(node2.sizeY/2)) && (node.offsetY+(node.sizeY/2)-4 <= node2.offsetY+(node2.sizeY/2)) ) && (node.widgetKey != node2.widgetKey) ) {
                    node.overlapYLine3 = true;
                //    print("node.overlapYLine3 : ${node.overlapYLine3}, ${node2.offsetY+(node2.sizeY/2) - (node.sizeY/2)}");
                    verifyOffsetY = node2.offsetY+(node2.sizeY/2) - (node.sizeY/2);
                    tempidx2++;
                  }
                  else if( ( (node.offsetY-(node.sizeY/2)+4 >= node2.offsetY+(node2.sizeY/2)) && (node.offsetY-(node.sizeY/2)-4 <= node2.offsetY+(node2.sizeY/2)) ) && (node.widgetKey != node2.widgetKey) ) {
                    node.overlapYLine4 = true;
                //    print("node.overlapYLine4 : ${node.overlapYLine4}, ${node2.offsetY+(node2.sizeY/2) - (node.sizeY/2)}");
                    verifyOffsetY = node2.offsetY+(node2.sizeY/2) + (node.sizeY/2);
                    tempidx2++;
                  }
               /*    if(tempidx > 1) {
                    node.overlapYLine = false;
                    node.overlapYLine2 = false;
                    node.overlapYLine3 = false;
                    node.overlapYLine4 = false;
                    print("tempidx 초과 : $tempidx");
                  //  verifyOffsetX=0;
                    tempidx =0;
                  }
                  if(tempidx2 > 1) {
                    node.overlapXLine = false;
                    node.overlapXLine2 = false;
                    node.overlapXLine3 = false;
                    node.overlapXLine4 = false;
                    print("tempidx2 초과 : $tempidx2");
                  //  verifyOffsetY =0;
                    tempidx2 = 0;
                  }*/
                }
              };
            }
           
          });
        },
     //   child : AnimatedBuilder(
     //     animation: _animation,
     //     builder: (context, _) {
      //    return Container( 
          child : Container( 
            color: Color.fromRGBO(254, 254, 254, 1.0),
            width: 50, 
            height: 50, //tempkey != null ? mapInputValue.maptotalSizeY[tempkey]! : 50,
            child : CustomPaint (
              foregroundPainter: Drawing_Cad2D(node: controller.nodes, FieldController: widget.ControllerField, verifyNode: verifyOffsetX, verifyNode2: verifyOffsetY, 
                                  aniMation: _animation.value, anyTriger: _trigger, sliderScale: widget.sliderInputScale, ), 
            ),
          ),
       // })
      ),
    );
  }
}

class NewTextSizeFieldList {
  const NewTextSizeFieldList({
    required this.key,
    required this.name,
    required this.index,
    required this.Changecolor,
  });
  final UniqueKey key;
  final String name;
  final int index;
  final bool Changecolor;
}

class InlineCustomPainter extends CustomPainter {
  const InlineCustomPainter({
    required this.brush,
    required this.builder,
    this.isAntiAlias = true,
  });
  final Paint brush;
  final bool isAntiAlias;
  final void Function(Paint paint, Canvas canvas, Rect rect) builder;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    brush.isAntiAlias = isAntiAlias;
    canvas.save();
    builder(brush, canvas, rect);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}