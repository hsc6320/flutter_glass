
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:glassapp/EstiamtePage/CustomPainter_2D.dart';
import 'package:image_picker/image_picker.dart';


ShapeChoiceArea shapeArea = ShapeChoiceArea(AreaX: '', AreaY: '', sports: '', );
ShapeChoiceArea shapeAddArea = ShapeChoiceArea(AreaX: '', AreaY: '', sports: '', );
class EstimatePage extends StatefulWidget {
  
  EstimatePage({Key? key, /*required this.PickedImages,*/}) : super(key: key);

  @override
  State<EstimatePage> createState() => _EstimatePageState();
}

class _EstimatePageState extends State<EstimatePage> {
  //final _formKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormBuilderState>();
  
  //final List<UniqueKey> _uniqueKey = [ UniqueKey(), UniqueKey(), UniqueKey() ];

  final List<widgetControl> _widgetControl = [
      widgetControl (
        uniqueKey: UniqueKey(),
      ),
      widgetControl (
        uniqueKey: UniqueKey(),
      ),
      widgetControl (
        uniqueKey: UniqueKey(),
      ),
      widgetControl (
        uniqueKey: UniqueKey(),
      ),
  ];
  
  //final GlobalKey<_NewImageFieldState> _customWidgetKey = GlobalKey<_NewImageFieldState>();

  String Name = "";
  String Mail = "";
  String PhoneNumer = " ";
  String Address = "";
  String Target = "";
  String beforeTarget = "";
  List<String> Setup = [];
  String Date = " ";
  String SetupCount = "";
  String etcInquiry = "";
  String Area_X = "";
  String Area_Y = "";
  String TextInputText = '';
  String categoryTarget = '';
  List<XFile?> PickedImages = [];

  List<XFile?> CustomerImage = [];
  TextEditingController TargetController = TextEditingController();
  TextEditingController TaggetCountController = TextEditingController();

  List<SportChoiceArea> sports = const [
    SportChoiceArea(height: '120', width: '90', sports: '축구장'),
    SportChoiceArea(height: '42', width: '25', sports: '풋살장'),
    SportChoiceArea(height: '20', width: '50', sports: '육상장'),
    SportChoiceArea(height: '36', width: '18', sports: '테니스장'),
    SportChoiceArea(height: '', width: '', sports: '기타 다목적 구장'),
  ];

  late SportChoiceArea selectedForwardCurve, selectedReverseCurve;

  final List<Widget> fields = [];
  final List<Widget> fields2 = [];
  final List<Widget> fields3 = [];
  

  int _newTextFieldId = 0, _newImageFieldId =0;
  int _newTextFieldId2 = 0;
  //bool _tartgetHasError = false;
  String category = '';
  var FirsttargetOptions = ['스포츠', '조경'];
  var SecondtargetOptions = [CategoryLandscapeGroup().cafe, CategoryLandscapeGroup().pansion, CategoryLandscapeGroup().petPansion, CategoryLandscapeGroup().home];
  var ThirdtargetOptions = [CategorySportsGroup().soccerField, CategorySportsGroup().footballField, CategorySportsGroup().runningField, 
                            CategorySportsGroup().tennisField, CategorySportsGroup().etcField];



   @override
  void initState() {
    super.initState();
    //selectedForwardCurve = sports[0];
  }

  @override
  void dispose() {
    super.dispose();
  }

  String CalculAreaX(String? a, String target) {
    String b = '';
    print("CalculAreaX () a : $a, SetupCount : $SetupCount , target : $target");

    if(a == null) {
      print('return b');
      return b;
    }
    if(target == '축구장') {
      b = (int.parse(sports[0].width)*(int.parse(SetupCount))).toString();
    }
    else if(target == '풋살장') {
      b = (int.parse(sports[1].width)*(int.parse(SetupCount))).toString();
    }
    else if(target == '육상장') {
      b = (int.parse(sports[2].width)*(int.parse(SetupCount))).toString();
    }
    else if(target == '테니스장') {
      b = (int.parse(sports[3].width)*(int.parse(SetupCount))).toString();
    }
    
    return b;
  }

  String CalculAreaY(String? a, String target) {
    String b = '';
    if(a == null) {
      return b;
    }
    print("CalculAreaY() a : $a, SetupCount : $SetupCount , target : $target");
    if(target == '축구장') {
      b = (int.parse(sports[0].height)*(int.parse(SetupCount))).toString();
    }
    else if(target == '풋살장') {
      b = (int.parse(sports[1].height)*(int.parse(SetupCount))).toString();
    }
    else if(target == '육상장') {
      b = (int.parse(sports[2].height)*(int.parse(SetupCount))).toString();
    }
    else if(target == '테니스장') {
      b = (int.parse(sports[3].height)*(int.parse(SetupCount))).toString();
    }
    return b;
  }
  Widget RowColumnArea(String setupCnt, String b) {
    setupCnt.length > 0 ? SetupCount=setupCnt : SetupCount = '0';
    //print("RowColumnArea ($SetupCount),($Target)");
    return Row(
      children : <Widget> [
        Container (
          //alignment: Alignment.bottomLeft,
          width:  MediaQuery.of(context).size.width*0.4,
          height: MediaQuery.of(context).size.height*0.075,
          child : FormBuilderTextField (
              name: 'widtharea',
              textInputAction: TextInputAction.next,
              style : TextStyle(fontSize : 20,),
              controller: TaggetCountController = TextEditingController(
                text: Target == '축구장' ? CalculAreaX(SetupCount,Target) : //(int.parse(sports[0].width)*(int.parse(SetupCount))).toString() : ////sports[0].width : 
                (Target == '풋살장') ?  CalculAreaX(SetupCount,Target)://sports[1].width :
                (Target == '육상장') ?  CalculAreaX(SetupCount,Target) : //sports[2].width :
                (Target == '테니스장') ?  CalculAreaX(SetupCount,Target) :
                (Target == '기타 다목적 구장') ? shapeArea.AreaX :
                (Target == '카페') ? shapeArea.AreaX :
                (Target == '펜션') ? shapeArea.AreaX :
                (Target == '애견카페') ? shapeArea.AreaX :
                (Target == '주택') ? shapeArea.AreaX : null
              ),
              decoration: InputDecoration(
                //hintText: '100',
                labelText: '가로 길이(단위 : M)',
              ),
              onSaved:(value) {
                Area_X = value!;
              },
            ),
          
        ),
        Spacer(
          flex: 1,
        ),
        Container(
          width:  MediaQuery.of(context).size.width*0.4,
          height: MediaQuery.of(context).size.height*0.075,
          child : FormBuilderTextField(
            name: 'heightarea',
            textInputAction: TextInputAction.next,
            style : TextStyle(fontSize : 20,),
            controller: TargetController = TextEditingController(
                  text: Target == '축구장' ? CalculAreaY(SetupCount,Target) :
                  (Target == '풋살장') ? CalculAreaY(SetupCount,Target) :
                  (Target == '육상장') ? CalculAreaY(SetupCount,Target) : //sports[2].height :
                  (Target == '테니스장') ? CalculAreaY(SetupCount,Target) :
                  (Target == '기타 다목적 구장') ? shapeArea.AreaY : 
                  (Target == '카페') ? shapeArea.AreaY :
                  (Target == '펜션') ? shapeArea.AreaY :
                  (Target == '애견카페') ? shapeArea.AreaY :
                  (Target == '주택') ? shapeArea.AreaY : null
              ),
            decoration: InputDecoration(
              //hintText: '100',
              labelText: '세로 길이(단위 : M)',
            ),
            onSaved:(value) {
              Area_Y = value!;
            },
          ),
        ),
      ],
    );
  }
  Widget landscapeCategory() {
    //print("landscapeCategory($Target), ($categoryTarget)");
    beforeTarget = Target;
    return Container (
      child :SizedBox (
        width: double.infinity,
        height: 70,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 139, 231, 181),  
              surfaceTintColor: Color.fromARGB(255, 3, 199, 90),  
              foregroundColor: Colors.black,
          ),
          child: Text(
            "면적 선택",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 20,
            ),
          ),
          onPressed: () async {
            var result;
            result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => OptionChoicepage()),
            );
            setState(() {
              if(result != null) {
                shapeArea = result;
              };
          
              final newImagedName = 'name2_${_newImageFieldId++}';
              final newImageKey = ValueKey(_newImageFieldId);
              final newImageKey2 = ValueKey(_newImageFieldId);
            
              fields3.removeWhere((e) => e.key == newImageKey2);
              _newImageFieldId =0;
          
              fields3.add( NewImageField(
                selectedOption: shapeArea.sports.toString(),
                key: newImageKey2,
                name: newImagedName,
                Target: Target,
                onDelete : () {
                  setState(() {
                    fields3.removeWhere((e) => e.key == newImageKey2);
                    _newImageFieldId =0;
                  });
                }, 
              ));
            });

          },
        ),
      ),
    );
  }
  Widget sportsCategory () {
    print("sportsCategory($Target), ($categoryTarget)");
    beforeTarget = Target;
    return Container (
        child : Column (
          children : [
           Visibility (
            visible: Target != '기타 다목적 구장',
            child : FormBuilderTextField(
              name: 'setupcount',
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '구장 개수',
              ),
            //   controller: TaggetCountController = TextEditingController (
            //     text: SetupCount = '1',
            //   ),
              onSaved:(val) {
                print("구장 개수 : $SetupCount");
                SetupCount = val!;
              },
              onChanged: (val) {
                setState(() {
                  SetupCount = val!;
                  print("onChanged : $SetupCount");
                });
              },
            ),
          ),
    // ...fields2,
          
           Visibility(
            visible: Target == '기타 다목적 구장',
            child: SizedBox (
              width: double.infinity,
              height: 70,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 139, 231, 181),  
                    surfaceTintColor: Color.fromARGB(255, 3, 199, 90),  
                    foregroundColor: Colors.black,
                ),
                child: Text(
                  "면적 선택",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                  ),
                ),
                onPressed: () async {
                  var result;
                  result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => OptionChoicepage()),
                  );
                  setState(() {
                    if(result != null) {
                      shapeArea = result;
                    };
                
                    final newImagedName = 'name2_${_newImageFieldId++}';
                    final newImageKey = ValueKey(_newImageFieldId);
                    final newImageKey2 = ValueKey(_newImageFieldId);
                  
                    fields2.removeWhere((e) => e.key == newImageKey2);
                    _newImageFieldId =0;
                
                    fields2.add( NewImageField(
                      selectedOption: shapeArea.sports.toString(),
                      key: newImageKey,
                      name: newImagedName,
                      Target: Target,
                      onDelete : () {
                        setState(() {
                          fields2.removeWhere((e) => e.key == newImageKey);
                          _newImageFieldId =0;
                        });
                      }, 
                    ));
                  });

                },
              ),
            ),
          ),
          ],  
    )
    );
  }
  @override
  Widget build(BuildContext context) {

   // SystemChrome.setPreferredOrientations([]);
    return Scaffold(
      appBar: AppBar(
        title: Text("FORM 작성"),//Text(PostingList[Index]!.PostingTitle),
      ),
      body: FormBuilder(
        key: _formKey,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
         //   child: AutofillGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...[
                    //const Text('기업이 보는 견적서를 작성해보세요 '),
                    const Text('내용 작성'),
                    FormBuilderTextField(
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      name: 'name',
                      validator: FormBuilderValidators.required(),
                      decoration: const InputDecoration(
                        hintText: '홍길동',
                        label: Text('이름'),
                    ),
                      onSaved:(value) {
                        Name = value!;
                      },
                    ),
                    FormBuilderTextField(
                      name: 'email',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'foo@example.com',
                        labelText: 'Email',
                      ),
                      autofillHints: [AutofillHints.email],
                      onSaved:(value) {
                        Mail = value!;
                      },
                    ),
                    FormBuilderTextField(
                      name: 'Phone',
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: '(010) 456-7890',
                        labelText: '연락처',
                      ),
                      autofillHints: [AutofillHints.telephoneNumber],
                      onSaved:(value) {
                        PhoneNumer = value!;
                      },
                    ),
                    FormBuilderTextField(
                      name: 'address',
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: '서울 강남구 테헤란로',
                        labelText: '주소',
                      ),
                      autofillHints: [AutofillHints.streetAddressLine1],
                      onSaved:(value) {
                        Address = value!;
                      },
                    ),
                    FormBuilderTextField(
                      name: 'date',
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'YY/MM/DD',
                        labelText: '희망 날짜',
                      ),
                      onSaved:(value) {
                        Date = value!;
                      },
                    ),
                    FormBuilderDropdown<String> (
                      name: 'firstchoicetarget', //category
                      itemHeight: 50,
                      decoration: InputDecoration(
                        labelText: '시공 카테고리를 선택하세요',
                      ),
                      items: FirsttargetOptions.map((target) => DropdownMenuItem(
                            alignment: AlignmentDirectional.center,
                            value: target,
                            child: Text(target),
                          )).toList(), 
                      onChanged: (val) {
                        setState(() {
                          print(val);
                            categoryTarget = val!;
                            print("categoryTarget : $categoryTarget");
                            //_tartgetHasError = !(_formKey.currentState?.fields['choicetarget']!.validate() ?? true);
                        });
                      },
                    ),
                    FormBuilderDropdown<String> (
                      onTap: () {
                        final newImageKey2 = ValueKey(_newImageFieldId);
                          setState(() {
                            fields2.removeWhere((e) => e.key == newImageKey2);
                            _newImageFieldId =0;

                            fields3.removeWhere((e) => e.key == newImageKey2);
                            _newImageFieldId =0;
                          });
                      },
                      name: 'choicetarget',
                      itemHeight: 50,
                      decoration: InputDecoration (
                        labelText: '종목을 선택하세요',
                        /*suffix: _tartgetHasError
                            ? const Icon(Icons.error)
                            : const Icon(Icons.check),*/
                        suffix: IconButton(
                          onPressed: () {
                            HelpDialogs().openDialog(context);
                          },
                          alignment: Alignment.bottomCenter,
                          icon: Icon(Icons.help_outline),
                          iconSize: 35,
                          tooltip: '도움말',
                          color: const Color.fromARGB(255, 133, 80, 80),),
                          hintText: 'Select Target',
                      ),
                      validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
                      items: categoryTarget == '스포츠' ? ThirdtargetOptions.map((target) => DropdownMenuItem (
                            alignment: AlignmentDirectional.center,
                            value: target,
                            child: Text(target),
                          )).toList() 
                          :
                          SecondtargetOptions.map((target) => DropdownMenuItem(
                            alignment: AlignmentDirectional.center,
                            value: target,
                            child: Text(target),
                          )).toList(), 
                      onChanged: (val) {
                        setState(() {
                          print(val);
                            Target = val!;
                            print("Target : " +Target);
                            //_tartgetHasError = !(_formKey.currentState?.fields['choicetarget']!.validate() ?? true);
                        });
                        //valueTransformer: (val) => val?.toString(),

                        final newImagedName = 'name2_${_newImageFieldId++}';
                        final newImageKey = ValueKey(_newImageFieldId);
                        final newImageKey2 = ValueKey(_newImageFieldId);
                        if(categoryTarget == '스포츠') {
                          print("이전 Target : " +beforeTarget);
                          if( (beforeTarget == CategoryLandscapeGroup().cafe) || (beforeTarget == CategoryLandscapeGroup().home) || (beforeTarget == CategoryLandscapeGroup().pansion)
                              || (beforeTarget == CategoryLandscapeGroup().petPansion) ) {
                            
                              fields3.removeWhere((e) => e.key == newImageKey2);
                              _newImageFieldId =0;

                              fields2.add( NewImageField(
                              selectedOption: shapeArea.sports.toString(),
                              key: newImageKey,
                              name: newImagedName,
                              Target: Target,
                              onDelete : () {
                                setState(() {
                                  fields2.removeWhere((e) => e.key == newImageKey);
                                  _newImageFieldId =0;
                                });
                              }, 
                            ));
                          }
                          else {
                              fields2.removeWhere((e) => e.key == newImageKey);
                              _newImageFieldId =0;

                              fields2.add( NewImageField(
                              selectedOption: shapeArea.sports.toString(),
                              key: newImageKey,
                              name: newImagedName,
                              Target: Target,
                              onDelete : () {
                                setState(() {
                                  fields2.removeWhere((e) => e.key == newImageKey);
                                  _newImageFieldId =0;
                                });
                              }, 
                            ));
                          }
                        }
                        else {
                          if( (beforeTarget == CategorySportsGroup().etcField) || (beforeTarget == CategorySportsGroup().footballField) || (beforeTarget == CategorySportsGroup().runningField)
                              || (beforeTarget == CategorySportsGroup().soccerField) ||  (beforeTarget == CategorySportsGroup().tennisField) ) {
                            
                              fields2.removeWhere((e) => e.key == newImageKey);
                              _newImageFieldId =0;

                              fields3.add( NewImageField(
                              selectedOption: shapeArea.sports.toString(),
                              key: newImageKey2,
                              name: newImagedName,
                              Target: Target,
                              onDelete : () {
                                setState(() {
                                  fields3.removeWhere((e) => e.key == newImageKey2);
                                  _newImageFieldId =0;
                                });
                              }, 
                            ));
                          }
                           else {
                              fields3.removeWhere((e) => e.key == newImageKey2);
                              _newImageFieldId =0;

                              fields3.add( NewImageField(
                              selectedOption: shapeArea.sports.toString(),
                              key: newImageKey2,
                              name: newImagedName,
                              Target: Target,
                              onDelete : () {
                                setState(() {
                                  fields3.removeWhere((e) => e.key == newImageKey2);
                                  _newImageFieldId =0;
                                });
                              }, 
                            ));
                          }
                        }
                      },
                    ),
                     
                    categoryTarget == '스포츠' ? sportsCategory() : landscapeCategory(),
                    ...fields2,
                    ...fields3,
                    RowColumnArea(SetupCount,Target),

                    FormBuilderCheckboxGroup<String>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                          labelText: '악세서리 설치'),
                      name: 'Accessory',
                      // initialValue: const ['Dart'],
                      options: const [
                        FormBuilderFieldOption(value: '그물망'),
                        FormBuilderFieldOption(value: '풋살 휄스'),
                        FormBuilderFieldOption(value: '비구방지 휀스'),
                        FormBuilderFieldOption(value: '비구방지휀스 +그물망 혼합'),
                        FormBuilderFieldOption(value: '조명'),
                        FormBuilderFieldOption(value: '벽보호대'),
                      ],
                      onChanged: (val) {
                        setState(() {
                            Setup = List<String>.from(val!);
                            print(Setup);
                        });
                      },
                      separator: const VerticalDivider(
                        width: 10,
                        thickness: 5,
                        color: Colors.red,
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.minLength(1),
                        FormBuilderValidators.maxLength(5),
                      ]),
                    ),
                    FormBuilderTextField(
                      name: 'etc',
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: '그외 하실 말씀들...',
                        labelText: '기타 문의 사항',
                      ),
                      onSaved:(value) {
                        etcInquiry = value!;
                      },
                    ),
                    ...fields,
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child : ElevatedButton (
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 139, 231, 181),  
                          surfaceTintColor: Color.fromARGB(255, 3, 199, 90),  
                          foregroundColor: Colors.white,  
                          shape: RoundedRectangleBorder(  
                            borderRadius: BorderRadius.circular(20),  
                          ),  
                        ),
                        child : Text(
                          '추가 시공 면적',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () async {
                          final newTextFieldName = 'name2_${_newTextFieldId2}';
                          var result;
                          _newTextFieldId2 >2 ? MessageBoxDialogs(text: '추가 면적은 3곳을 넘어갈수 없습니다.').NoticeMsg(context)
                          :
                          result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => OptionChoicepage()),
                          );
                          if(result != null) {
                            shapeAddArea = result;
                          }

                          _newTextFieldId2 >2 ? null : 
                          setState(() {
                            print("$newTextFieldName $_newTextFieldId2");
                            
                            fields.add (NewTextField (
                              key: _widgetControl[_newTextFieldId2].uniqueKey,
                              name: newTextFieldName,
                              onDelete : () {
                                setState(() {
                                  _newTextFieldId2--;
                                  fields.removeWhere((e) => e.key == _widgetControl[_newTextFieldId2].uniqueKey);
                                  //fields.removeWhere((e) => e.key == e.
                                });
                              },
                            ));
                            _newTextFieldId2++;
                          });
                        },
                      ), 
                    ),
                   // FiledImageUploader(PickedImages: PickedImages, aaa: '시공 할 현장 사진을 올려주세요',),
                    SizedBox (
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 3, 199, 90),  
                            surfaceTintColor: Color.fromARGB(255, 3, 199, 90),  
                            foregroundColor: Colors.black,  
                        ),
                        child: Text(
                          "NEXT",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () async {
                    //      if(_formKey.currentState!.validate()) {
                    //        _formKey.currentState?.save();
/*
                            if(PickedImages.isNotEmpty) {
                              //SelectedImage = [];
                              CustomerImage.addAll(PickedImages);
                              PickedImages = [];
                            }
                            else {
                              PickedImages.add(null);
                              CustomerImage.add(PickedImages[0]);
                              PickedImages = [];
                            }
                            ConstructSpotImage aaa = ConstructSpotImage (Name, Mail, PhoneNumer, Address, Target, Setup, 
                                              Date, etcInquiry, Area_X, Area_Y, CustomerImage, _EstimatePost_property);
                            //aaa.PostUpdate();
*/
                            await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => OptionChoicepage()/*CustomPaint2D(EstimateInfo: aaa,)*/),
                            );

                      //    }
                        },
                      ),
                    ),
                  ].expand(
                    (widget) => [
                      widget,
                      const SizedBox(
                        height: 24,
                      )
                    ],
                  ),
                ],
              ),
        //    ),
          ),
        ),
      ),
    );
  }
}

class SportChoiceArea {
  final String width;
  final String height;
  final String sports;
  
  const SportChoiceArea({required this.width, required this.height, required this.sports});
}

class CategorySportsGroup {
  String soccerField = '축구장';
  String footballField = '풋살장';
  String runningField = '육상장';
  String tennisField = '테니스장';
  String etcField = '기타 다목적 구장';
}

class CategoryLandscapeGroup {
  String cafe = '카페';
  String pansion ='펜션';
  String petPansion = '애견카페';
  String home = '주택';
}

class widgetControl {
  final UniqueKey uniqueKey;
  
  widgetControl({
    required this.uniqueKey,
  });
}

class MessageBoxDialogs {
  final String text;
  MessageBoxDialogs({required this.text,});
  bool NoticeMsg(BuildContext context) {
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('NOTICE'),
          content: Text(
              text,
              ),
          actions: <Widget>[
            FilledButton(
              child: const Text('Okay'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
      return false;
    }
}

class HelpDialogs {
  void openDialog(BuildContext context) {
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('도움말'),
          content: const Text(
              '정규 규격에 맞춘 도면입니다. 기타를 선택하면 직접 면적과 넓이를 선택 하게 됩니다. '),
          actions: <Widget>[
            FilledButton(
              child: const Text('Okay'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
}

class NewImageField extends StatefulWidget {
  const NewImageField({
    super.key,
    required this.selectedOption,
    required this.name,
    required this.Target,
    this.onDelete,
  });

  final String name;
  final VoidCallback? onDelete;
  final String Target;
  final String? selectedOption;

  @override
  State<NewImageField> createState() => _NewImageFieldState();
}

class _NewImageFieldState extends State<NewImageField> {
  Widget MultipleTaget () {
   // print("MultipleTaget() 기타 다목적 구장 ${shapeArea.sports}");
    
    return CustomPaint (
      foregroundPainter : (shapeArea.sports == 'Options.option1') ? SqurePaint() :
      (shapeArea.sports == 'Options.option2') ? Rectanglepaint():
      (shapeArea.sports == 'Options.option3') ? OvalPaint() : 
      null,
    ); 
  }

  @override
  Widget build(BuildContext context) {
   // print("ddfwew3244 " + widget.name + shapeArea.sports);
    return Padding(
      padding: const EdgeInsets.only(left: 10),
        child : Row (
          children: [
            Container (
              width: MediaQuery.of(context).size.width*0.78,
              height: (shapeArea.sports == 'Options.option1') ? MediaQuery.of(context).size.height*0.30 : MediaQuery.of(context).size.height*0.20 ,
              child : widget.Target =='풋살장' ? Image.asset('assets/image/football.png') :
              (widget.Target == '축구장') ? Image.asset('assets/image/soccer.png') :
              (widget.Target == '육상장') ? Image.asset('assets/image/running.png') :
              (widget.Target == '테니스장') ? Image.asset('assets/image/tennis.png') : 
              (widget.Target == '기타 다목적 구장') ? MultipleTaget() :
              (widget.Target == '카페') ? MultipleTaget() :
              (widget.Target == '펜션') ? MultipleTaget() :
              (widget.Target == '애견카페') ? MultipleTaget() :
              (widget.Target == '주택') ? MultipleTaget() : null,
            ),
            IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: widget.onDelete,
            ),
          ]
        ),
    );
  }
}

class NewTextField extends StatelessWidget {
  const NewTextField({
    super.key,
    required this.name,
    this.onDelete,
  });
  final String name;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    TextEditingController TaggetCountController = TextEditingController();
    print(this.key);
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Row(
        children : [
          Container (
            //alignment: Alignment.bottomLeft,
            width:  MediaQuery.of(context).size.width*0.4,
            height: MediaQuery.of(context).size.height*0.075,
            child : FormBuilderTextField(
              name: name,
              textInputAction: TextInputAction.next,
              style : TextStyle(fontSize : 20,),
              controller: TaggetCountController = TextEditingController(
                text: shapeAddArea.AreaX
              ),
              decoration: InputDecoration(
                labelText: '가로 길이(단위 : M)',
              ),
              onSaved:(value) {
              //  AreaX = value!;
              },
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Container(
            width:  MediaQuery.of(context).size.width*0.4,
            height: MediaQuery.of(context).size.height*0.075,
            child : FormBuilderTextField(
              name: name,
              textInputAction: TextInputAction.next,
              style : TextStyle(fontSize : 20,),
              controller: TaggetCountController = TextEditingController (
                text: shapeAddArea.AreaY,
              ),
              decoration: InputDecoration(
                labelText: '세로 길이(단위 : M)',
              ),
              onSaved:(value) {
             //   AreaY = value!;
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }

}