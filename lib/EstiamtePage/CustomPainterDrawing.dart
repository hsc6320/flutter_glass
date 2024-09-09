
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glassapp/EstiamtePage/CustomPainterDrawing_2Page.dart';
import 'package:glassapp/Utills/ShowBottomSheet.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:glassapp/EstiamtePage/CanvasController.dart';
import 'package:glassapp/EstiamtePage/CanvasNode.dart';
import 'package:infinite_canvas/infinite_canvas.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'dart:ui' as ui;


Map DrawMap_KeyName = {};
DrawMapInputValue mapInputValue = DrawMapInputValue(100, 100, 1 , 1);

List<NewTextSizeFieldList> listNewTextField = [];
Map<UniqueKey, int> mapShapeIndex = {};
CanvasController controller  = CanvasController();


int listInputValueIndex =0;
int _newTextFieldId2 =10;
double xoffsetPos =0, yoffsetPos =0;
int panIdx =0;
String label = '';
bool colorVal = false;
final List<Widget> fields2 = [];
final List<Widget> fields3 = [];
final List<widgetControl> _widgetControl = [];
String newTextfieldName = '';
double sliderValue0 = 1.0;
DrawViewSettings viewSetting = DrawViewSettings(viewAll: false, viewLine: false, viewX: false, viewY: false);

class Drawing2D extends StatefulWidget {
  @override
  State<Drawing2D> createState() => _Drawing2DState();
}

class _Drawing2DState extends State<Drawing2D> {
  final _formKey = GlobalKey<FormBuilderState>();
  late CanvasController  FieldController;
  late InfiniteCanvasController ccc;
  final List<Widget> fields = [];
  final color = Colors.red;
  bool vx = false, vy = false, vall = false, vline = false;
  
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
  
  void AddShapeButton(CanvasController ControllerField) {
     print("도형 추가 렝스 : ${ControllerField.nodes.length}, newTextfieldName : $newTextfieldName");
    newTextfieldName = 'keyname3_${_newTextFieldId2++}';
    _widgetControl.add(widgetControl(uniqueKey: UniqueKey()));
  
    DrawMap_KeyName[_widgetControl[listInputValueIndex].uniqueKey] = newTextfieldName;
    mapShapeIndex[_widgetControl[listInputValueIndex].uniqueKey] = setIndex;
    setIndex++;
    
    mapInputValue.aa[_widgetControl[listInputValueIndex].uniqueKey] = DrawSizeInputValue(100,100,100,100);
    listInputValueIndex++;

    listNewTextField.add (
      NewTextSizeFieldList(
        Changecolor: colorVal, 
        index: mapShapeIndex[_widgetControl[listInputValueIndex-1].uniqueKey]!, 
        key: _widgetControl[listInputValueIndex-1].uniqueKey,
        name: newTextfieldName,
      )
    );
    final node = DrawCanvasNode(
      key: UniqueKey(), 
      widgetKey: _widgetControl[listInputValueIndex-1].uniqueKey,
      isSelect: false,
      offsetX: mapInputValue.mapKeyPositionX[_widgetControl[listInputValueIndex-1].uniqueKey]= Random().nextDouble() * 200 + 50, 
      offsetY: mapInputValue.mapKeyPositionY[_widgetControl[listInputValueIndex-1].uniqueKey]=Random().nextDouble() * 200 + 50,
      sizeX : mapInputValue.maptotalSizeX[_widgetControl[listInputValueIndex-1].uniqueKey] = 100,
      sizeY : mapInputValue.maptotalSizeY[_widgetControl[listInputValueIndex-1].uniqueKey] = 100,
      
      label: listInputValueIndex.toString(), 
    );
    ControllerField.add(node);
    //controller.add(node);
    print("사각형 추가 ${node.label}");
  }
  @override
  void initState() {
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    final test = context.watch<CanvasController>();
    return Consumer<CanvasController> (builder: (_, provider, child ) {
      FieldController = provider;

      List<Widget> buttonList = <Widget>[
        TextButton(onPressed: () { AddShapeButton(FieldController); }, child: Text("도형 추가")),
        TextButton(
          child: Text("좌표보기"),
          onPressed: () { 
            setState(() {
              vall = !vall; 
              viewSetting.viewAll= vall;
              print("_viewAll : ${viewSetting.viewAll}"); 
            });
          },
        ),
        TextButton(
          child: Text("라인보기"),
          onPressed: () { 
            setState(() {
              vline = !vline;
              viewSetting.viewLine = vline;
              print("_viewLine : ${viewSetting.viewLine}"); 
            });
          }
        ),
        TextButton(
          child: Text("이미지화"),
          onPressed: () { 
           // convertCanvasToImage();
            setState(() {
              print("_viewLine : ${viewSetting.viewLine}"); 
            });
          }
        ),
      ];

      return Scaffold (
      body : FormBuilder (
        key: _formKey,
        child : SafeArea (
          minimum: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 1),
    //   child: Scrollbar(
    //      child: SingleChildScrollView(
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
                    "< 줌비상태 >"
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 3, right: 3),
                  child : Row (
                    children: <Widget>[
                      Text(
                        textAlign: TextAlign.center,
                        style : TextStyle(fontSize : 15,),
                        "SCALE\n${sliderValue0.toStringAsFixed(1)}",
                      ),
                      Expanded(
                        child : Row (
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child : Slider(
                                value: sliderValue0, 
                                max: 10,
                                onChanged:(value) {
                                  setState(() {
                                    sliderValue0 = value;
                                    provider.ChangedScale(sliderValue0.toStringAsFixed(1));
                                  });
                                },
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 15),
                              ),
                              child: Text("NEXT"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => DrawDisplay_2Page(/*SizeX: double.parse(AreaX), SizeY: double.parse(AreaY),)*/)), //Example()),
                                );
                              },
                            ),
                          ]
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible (
                  fit: FlexFit.tight,
                //  child : Column (
                //    children: [
                       child :Container (
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        //margin: EdgeInsets.only(left : 5,right: 5),
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
                              print("onPanUpPosition");
                              for(DrawCanvasNode node in provider.nodes) {
                                if(node.isSelect == true) {
                                  label = node.label;
                                }
                                node.isSelect = false;
                               // print("label : ${node.label}, key ${node.widgetKey}, ${node.offsetX} ${node.SizeX}, ${node.OffsetLeft}, ${node.OffsetRight}");
                               // node.canvasNodePrint();
                              }
                              panIdx =0;
                            });
                          },
                          child: FittedBox(
                            fit: BoxFit.cover,
                              child: DrawDisplay(ControllerField2: provider, sliderInputScale: sliderValue0,),
                          ),
                        ),
                      ),
                 //   ],
                 // ),
                ),
          Expanded(
          child: Container(
         //   color: const Color.fromARGB(255, 218, 210, 210),
          child :  Scrollbar(
          child: SingleChildScrollView(
          child : Container (
          //margin: EdgeInsets.only(top: 1),
          child : Column (
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            
            children: <Widget> [
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
                  return TextInputFieldState(
                    index: index, 
                    // aaa: listNewTextField[index], 
                    fieldControl: provider,
                    onDelete: () {
                      print("onDelete");
                      setState(() {
                        var tempkey;
                        if(DrawMap_KeyName.containsKey(FieldController.nodes[index].widgetKey)) {
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
                        DrawMap_KeyName.remove(tempkey);
                        if(DrawMap_KeyName.isEmpty) {
                          listInputValueIndex =0;
                          setIndex =0;
                          _newTextFieldId2 =10;
                        }
                      });
                    },
                  );
                })
              ),
        /*      TextButton(
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
*/
              ],),),),),),),

            ],
          ],
          ),
        ),
   //   ),
   //       ),
        ),
      
    ),

    floatingActionButton: FloatingActionButton.extended(
     // icon: Icon(Icons.settings),
      label : Text('  View\nSetting'),
      onPressed: () {
        showModalBottomSheet<void>(
          showDragHandle: true,
          context: context,
          constraints: const BoxConstraints(maxWidth: 640),
          builder: (context) {
            return SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: buttonList,
                ),
              ),
            );
          },
        );
      }
    ),
    //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  );
  });
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
    TextEditingController textControllerPosY = TextEditingController(text: widget.fieldControl.nodes[widget.index].offsetY.toStringAsFixed(1));  
    TextEditingController textControllerPosX = TextEditingController(text: widget.fieldControl.nodes[widget.index].offsetX.toStringAsFixed(1));  
    TextEditingController textControllerSizeX = TextEditingController(text: widget.fieldControl.nodes[widget.index].sizeX.toStringAsFixed(1));  
    TextEditingController textControllerSizeY = TextEditingController(text: widget.fieldControl.nodes[widget.index].sizeY.toStringAsFixed(1));  
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
                                  widget.fieldControl.ChangedOffset(widget.fieldControl.nodes[widget.index], widget.fieldControl.nodes[widget.index].OffsetX, widget.fieldControl.nodes[widget.index].OffsetX);
                                  mapInputValue.maptotalSizeX[key] = double.parse(val.toString());

                                  //if(mapInputValue.maptotalSizeY[key]== null) { mapInputValue.maptotalSizeY[key] =100;}
                                  //if(mapInputValue.mapKeyPositionX[key]== null) { mapInputValue.mapKeyPositionX[key] =50;}
                                  //if(mapInputValue.mapKeyPositionY[key]== null) { mapInputValue.mapKeyPositionY[key] =50;}

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
                                 // widget.fieldControl.nodes[widget.index].ChangedScaleOffset(widget.fieldControl.nodes[widget.index].OffsetX, widget.fieldControl.nodes[widget.index].OffsetY);
                                 widget.fieldControl.ChangedOffset(widget.fieldControl.nodes[widget.index], widget.fieldControl.nodes[widget.index].OffsetX, widget.fieldControl.nodes[widget.index].OffsetX);
                                  mapInputValue.maptotalSizeY[key] = double.parse(val.toString());

                              //    if(mapInputValue.maptotalSizeX[key]== null) { mapInputValue.maptotalSizeX[key] =100;}
                              //    if(mapInputValue.mapKeyPositionX[key]== null) { mapInputValue.mapKeyPositionX[key] =50;}
                              //    if(mapInputValue.mapKeyPositionY[key]== null) { mapInputValue.mapKeyPositionY[key] =50;}

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
                                  widget.fieldControl.nodes[widget.index].ChangedScaleOffset(widget.fieldControl.nodes[widget.index].OffsetX, widget.fieldControl.nodes[widget.index].OffsetY);
                                  mapInputValue.mapKeyPositionX[key] = double.parse(val.toString());

                               //   if(mapInputValue.maptotalSizeX[key]== null) { mapInputValue.maptotalSizeX[key] =100;}
                               //   if(mapInputValue.maptotalSizeY[key]== null) { mapInputValue.maptotalSizeY[key] =100;}
                               //   if(mapInputValue.mapKeyPositionY[key]== null) { mapInputValue.mapKeyPositionY[key] =50;}

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
                                  
                                  widget.fieldControl.nodes[widget.index].ChangedScaleOffset(widget.fieldControl.nodes[widget.index].OffsetX, widget.fieldControl.nodes[widget.index].OffsetY);
                                  mapInputValue.mapKeyPositionY[key] = double.parse(val.toString());

                             //     if(mapInputValue.maptotalSizeX[key]== null) { mapInputValue.maptotalSizeX[key] =100;}
                             //     if(mapInputValue.maptotalSizeY[key]== null) { mapInputValue.maptotalSizeY[key] =100;}
                             //     if(mapInputValue.mapKeyPositionX[key]== null) { mapInputValue.mapKeyPositionX[key] =50;}

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
    required this.ControllerField2,
    required this.sliderInputScale,
  });
  final CanvasController ControllerField2;
  final double sliderInputScale;
 
  @override
  State<DrawDisplay> createState() => _DrawDisplayState(ControllerField: ControllerField2);
}

class _DrawDisplayState extends State<DrawDisplay> with SingleTickerProviderStateMixin {
  _DrawDisplayState ({
    required this.ControllerField,
  });
  final CanvasController ControllerField;
  late AnimationController _animationController; // 애니메이션의 시간과 동작을 제어하는 컨트롤러
  late Animation<double> _animation; // 애니메이션 값을 보간하는 객체
  
  double Top=10, Left =0;
  double verifyOffsetX =0, verifyOffsetY =0;
  int tempidx =0, tempidx2 =0;
  UniqueKey? tempWidgetKey;


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

  void convertCanvasToImage() async {  
    ui.Image image = await captureCanvasToImage();  
    // Use the image here as needed, such as displaying it in an `Image` widget or saving it to a file  
  }  

  Future<ui.Image> captureCanvasToImage() async {  
    final pictureRecorder = ui.PictureRecorder();  
    final canvas = Canvas(pictureRecorder);  
    
    // Create the custom widget or draw on the canvas using a CustomPainter  
    final widget = Drawing_Cad2D(/*node: controller.nodes, */FieldController: ControllerField, 
                                              verifyNode: verifyOffsetX, verifyNode2: verifyOffsetY, viewSetting: viewSetting, );
    widget.paint(canvas, Size(200, 200)); // Set the size of the canvas to match the custom widget size  
    
    final recordedPicture = pictureRecorder.endRecording();  
    return await recordedPicture.toImage(200, 200); // Set the image size, should match the canvas size  
  }

  @override
  Widget build(BuildContext context) {
    //print("_DrawDisplayState() ${widget.ControllerField.nodes.length}");
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: const Color.fromARGB(255, 130, 96, 96), width: 3), vertical : BorderSide(color: Colors.black, width: 3)
        )
      ),
      child : GestureDetector(
        onPanDown :(details) {
          setState(() {
            print("onPanDown");
            for(DrawCanvasNode node in ControllerField.nodes) {
              //print("panIdx : $panIdx, ${node.offsetX}, ${details.localPosition.dx}, ${node.offsetY},  ${details.localPosition.dy}, ${node.sizeX}, ${node.sizeY}");
              if( ((node.OffsetLeft < details.localPosition.dx) && ((node.OffsetRight) > details.localPosition.dx)) 
                  && ((node.OffsetTop < details.localPosition.dy) && ((node.OffsetBottom) > details.localPosition.dy)) ) {
                  //panIdx++;
                  node.isSelect = true;
                  break;
              }
            }
            for(DrawCanvasNode node3 in ControllerField.nodes) {
              if(node3.isSelect == true){
                continue;
              }
              else {
                node3.isSelect = false;
              }
            }
          });
        },
        onPanEnd: (details) {
          print("onPanEnd");
          setState(() {
          });
        },
        onPanUpdate: (details) {
          setState(() {
            xoffsetPos = details.localPosition.dx ;
            yoffsetPos = details.localPosition.dy ;
            for(DrawCanvasNode node in ControllerField.nodes) {
              if(node.isSelect == true) {
                print("onPanUpdate");
                ControllerField.ChangedOffset(node, xoffsetPos, yoffsetPos);
               // node.ChangedScaleOffset(xoffsetPos, yoffsetPos);
                //print("label : ${node.label}, OffsetLeft : ${node.OffsetLeft}, OffsetRight : ${node.OffsetRight}");

                for(DrawCanvasNode node2 in ControllerField.nodes) {
                  if( ( (node.OffsetLeft+3 >= node2.OffsetLeft) && (node.OffsetLeft-3 <= node2.OffsetLeft) ) && (node.widgetKey != node2.widgetKey) ) {
                    node.overlapXLine = true;
                  //  print("node.overlapXLine : ${node.OffsetLeft}, ${node2.OffsetLeft}, ${node.key}/${node.widgetKey}, ${node2.key}/${node2.widgetKey}  ,${node2.offsetX} ${node2.OffsetLeft+(node.SizeX/2)}");
                    verifyOffsetX = node2.OffsetLeft+(node.SizeX/2);
                    tempidx++;
                  }
                  else if( ( (node.OffsetRight+3 >= node2.OffsetLeft) && (node.OffsetRight-3 <= node2.OffsetLeft) ) && (node.widgetKey != node2.widgetKey) ) {
                    node.overlapXLine2 = true;
                  //  print("node.overlapXLine2 : ${node.overlapXLine2} , ${node2.offsetX-(node2.SizeX/2)-(node.SizeX/2) }");
                    verifyOffsetX = node2.OffsetLeft-(node.SizeX/2);
                    tempidx++;
                  }
                  else if( ( (node.OffsetRight+3 >= node2.OffsetRight) && (node.OffsetRight-3 <= node2.OffsetRight) ) && (node.widgetKey != node2.widgetKey) ) {
                    node.overlapXLine3 = true;
                  //  print("node.overlapXLine3 : ${node.OffsetRight}, ${node2.OffsetRight}, ${node2.offsetX}, ${node.SizeX}, ${node2.OffsetRight-(node.SizeX/2)}");
                    verifyOffsetX = node2.OffsetRight-(node.SizeX/2);
                    tempidx++;
                  }
                  else if( ( (node.OffsetLeft+3 >= node2.OffsetRight) && (node.OffsetLeft-3 <= node2.OffsetRight) ) && (node.widgetKey != node2.widgetKey) ) {
                    node.overlapXLine4 = true;
                  //  print("node.overlapXLine4 : ${node.overlapXLine4} ${node2.offsetX+(node2.SizeX/2) + (node.SizeX/2)}");
                    verifyOffsetX = node2.offsetX+(node2.SizeX/2) + (node.SizeX/2);
                    tempidx++;
                    
                    if( ((node2.OffsetTop <= node.OffsetTop) && (node2.OffsetBottom >= node.OffsetBottom)) || ((node2.OffsetTop >= node.OffsetTop) && (node2.OffsetBottom <= node.OffsetBottom)) ) {
                      print("${node.verticalLength} > ${node2.verticalLength} ");
                      print("diamension : ${node.diagramDimension}, ${node2.diagramDimension}");
                    }
                  }
                  
                  if( ( (node.OffsetTop+3 >= node2.OffsetTop) && (node.OffsetTop-3 <= node2.OffsetTop) ) && (node.widgetKey != node2.widgetKey) ) {
                    node.overlapYLine = true;
                //    print("node.overlapYLine : ${node.overlapYLine} ${node2.label}, node.OffsetTop : ${node.OffsetTop}");
                    verifyOffsetY = node2.OffsetTop + (node.SizeY/2);
                    tempidx2++;
                  }
                  else if( ( (node.OffsetBottom+3 >= node2.OffsetTop) &&(node.OffsetBottom-3 <= node2.OffsetTop) ) && (node.widgetKey != node2.widgetKey) ) {
                    node.overlapYLine2 = true;
                  //  print("node.overlapYLine2 : ${node.overlapYLine2} ${node2.offsetY-(node2.SizeY/2) - (node.SizeY/2)}, ${node2.offsetY}");
                    verifyOffsetY = node2.OffsetTop - (node.SizeY/2);
                    tempidx2++;
                  }
                  else if( ( (node.OffsetBottom+3 >= node2.OffsetBottom) && (node.OffsetBottom-3 <= node2.OffsetBottom) ) && (node.widgetKey != node2.widgetKey) ) {
                    node.overlapYLine3 = true;
                  //  print("node.overlapYLine3 : ${node.overlapYLine3}, ${node2.offsetY+(node2.SizeY/2) - (node.SizeY/2)}");
                    verifyOffsetY = node2.OffsetBottom - (node.SizeY/2);
                    tempidx2++;
                  }
                  else if( ( (node.OffsetTop+3 >= node2.OffsetBottom) && (node.OffsetTop-3 <= node2.OffsetBottom) ) && (node.widgetKey != node2.widgetKey) ) {
                    node.overlapYLine4 = true;
                  //  print("node.overlapYLine4 : ${node.overlapYLine4}, ${node2.OffsetBottom - (node.SizeY/2)}");
                    verifyOffsetY = node2.OffsetBottom + (node.SizeY/2);
                    tempidx2++;
                  }
                }
              };
            }
          });
        },
        child : Container( 
          color: Color.fromRGBO(254, 254, 254, 1.0),
          width: 50, 
          height: 50, //tempkey != null ? mapInputValue.maptotalSizeY[tempkey]! : 50,
          child : CustomPaint (
            foregroundPainter: Drawing_Cad2D(/*node: controller.nodes,*/FieldController: ControllerField, 
                                            verifyNode: verifyOffsetX, verifyNode2: verifyOffsetY, viewSetting: viewSetting, ), 
          ),
        ),
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