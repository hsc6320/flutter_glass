
import 'package:flutter/material.dart';
import 'package:glassapp/EstiamtePage/CustomPainter_2D.dart';
import 'package:glassapp/EstiamtePage/EstimatePostModel.dart';
import 'package:glassapp/Utills/ImageSelection.dart';
import 'package:image_picker/image_picker.dart';



final List<Estimate_Property?> _EstimatePost_property = [];

class EstimatePage extends StatefulWidget {
  
  EstimatePage({Key? key, /*required this.PickedImages,*/}) : super(key: key);

  @override
  State<EstimatePage> createState() => _EstimatePageState();
}

class _EstimatePageState extends State<EstimatePage> {
  final _formKey = GlobalKey<FormState>();

  String Name = "";
  String Mail = "";
  String PhoneNumer = " ";
  String Address = "";
  String Target = "";
  String Setup = "";
  String Date = " ";
  String etcInquiry = "";
  String Area = "";
  List<XFile?> PickedImages = [];

  List<XFile?> CustomerImage = [];

   @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

   // SystemChrome.setPreferredOrientations([]);
  return Scaffold(
      appBar: AppBar(
        title: Text("FORM 작성"),//Text(PostingList[Index]!.PostingTitle),
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: AutofillGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...[
                    //const Text('기업이 보는 견적서를 작성해보세요 '),
                    const Text('내용 작성'),
                    TextFormField(
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: '홍길동',
                        labelText: '이 름',
                      ),
                      autofillHints: const [AutofillHints.givenName],
                      onSaved:(value) {
                        Name = value!;
                      },
                    ),
                    TextFormField(
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
                    TextFormField(
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
                    TextFormField(
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
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: '스포츠/조경 등',
                        labelText: '목적 및 용도',
                      ),
                      onSaved:(value) {
                        Target = value!;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: '그물망/펜스 등',
                        labelText: '악세서리 설치 유무',
                      ),
                      onSaved:(value) {
                        Setup = value!;
                      },
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'YY/MM/DD',
                        labelText: '희망 날짜',
                      ),
                      onSaved:(value) {
                        Date = value!;
                      },
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: '그외 하실 말씀들...',
                        labelText: '기타 문의 사항',
                      ),
                      onSaved:(value) {
                        etcInquiry = value!;
                      },
                    ),
                    Container(
                      //alignment: Alignment.bottomLeft,
                      width:  MediaQuery.of(context).size.width*0.4,
                      height: MediaQuery.of(context).size.height*0.075,
                      child : TextFormField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              //hintText: '100',
                              labelText: '가로 길이(단위 : M)',
                            ),
                            onSaved:(value) {
                              Area = value!;
                            },
                          ),
                       /*   Spacer(
                            flex: 1,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              //hintText: '100',
                              labelText: '세로 길이(단위 : M)',
                            ),
                            onSaved:(value) {
                              Area = value!;
                            },
                          ), */
                        
                    ),
                   // FiledImageUploader(PickedImages: PickedImages, aaa: '시공 할 현장 사진을 올려주세요',),
                    SizedBox (
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 139, 231, 181),  
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
                          if(_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

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
                                              Date, etcInquiry, Area, CustomerImage, _EstimatePost_property);
                            aaa.PostUpdate();

                            await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => CustomPaint2D()),
                            );

                          }
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}