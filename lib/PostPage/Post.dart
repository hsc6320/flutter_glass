import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassapp/Utills/ImageSelection.dart';
import 'package:image_picker/image_picker.dart';

import 'PostModel.dart';

final List<Posting_Property?> _posting_property = [];


class ContentPage extends StatelessWidget {
  final int Index;
  final List<Posting_Property?> PostingList;
  final List<XFile> SelectedImage;

  const ContentPage({Key? key, required this.Index, required this.PostingList, required this.SelectedImage, }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(PostingList[Index]!.PostingTitle),
      ),
      body: Center(
        child: Text(PostingList[Index]!.PostingMainText),
      ),
    );
  }
}

class CreatePostThread extends StatefulWidget {
//  final List<XFile> SelectedImage;

  const CreatePostThread({super.key, /*required this.SelectedImage*/});
  
  @override
  State<CreatePostThread> createState() => _CreatePostThreadState();
}

class _CreatePostThreadState extends State<CreatePostThread> {

  //_CreatePostThreadState({super.key, required this.pickedImages});
  //final _formkey = GlobalKey<FormState>();
  late List<XFile?> pickedImages = [];
  final _formKey = GlobalKey<FormState>();

  String title = '';
  String description = '';
  String PhoneNumber = '';
  String Url = '';

  Posting_Property? aaa;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text("견적 내기"),
        // 뒤로가기 버튼
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_back),
          onPressed: () {
            Navigator.pop(context, _posting_property);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: Align(
            alignment: Alignment.topCenter,
      //      child : Card(
              child : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child : ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: double.infinity),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...[
                        TextFormField(
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: 'Enter a tittle',
                            labelText: 'NAME',
                          ),
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if(value!.isEmpty) {
                              return '반드시 입력 해야 합니다.';
                            }
                            return null;
                          },
                          onSaved:(value) {
                            setState(() {
                              title = value!;
                            });
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            hintText: 'Enter a description...',
                            labelText: '소개 및 실적',
                          ),
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if(value!.isEmpty) {
                              return '반드시 입력 해야 합니다.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            description = value!;
                          },
                    //      maxLines: 10,
                        ),
                        TextFormField (
                          onSaved: (value) {
                            PhoneNumber = value!;
                          },
                          decoration: const InputDecoration (
                          prefixIcon: Icon(Icons.phone_android ,color: Colors.blueAccent,),
                           border: OutlineInputBorder(),
                           filled: true,
                           hintText: '연락처',
                           labelText: '연락처',
                          ),
                        ),
                        TextFormField(
                          onSaved: (value) {
                            Url = value!;
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.insert_link ,color: Colors.blueAccent,),
                            border: OutlineInputBorder(),
                            filled: true,
                            hintText: 'www.foo.co.kr',
                            labelText: '링크',
                          ),
                        ),
                       // _FormImageUploader (PickedImages: _pickedImages,), 
                        FiledImageUploader(PickedImages: pickedImages, aaa: "회사를 소개할 사진이나 실적 사진을 올려주세요."),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            child: Text(
                              "올리기",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () {
                              if(_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                print(title + description);
                                _posting_property.add(Posting_Property(title, description, PhoneNumber, Url, ));
                                if(pickedImages.isNotEmpty) {
                                  //SelectedImage = [];
                                  SelectedImage.addAll(pickedImages);
                                  pickedImages = [];
                                }
                                else {
                                  pickedImages.add(null);
                                  SelectedImage.add(pickedImages[0]);
                                  pickedImages = [];
                                  //SelectedImage = List.from(pickedImages);
                                }
                                print("ITEM COUNT : ");
                                print(_posting_property.length);
                                print("\n")
  ;                              Navigator.pop(context, _posting_property, );
                              }
                            }
                          ),
                        )
                      ].expand(
                          (widget) => [
                            widget,
                            const SizedBox(
                              height: 35,
                            )
                          ],
                        ),
                    ],
                  ),
                ),
              ),
       //     ),
          ),
        ),
      ),
    );
  }
}


/*
class _FormImageUploader extends StatefulWidget {
 final List<XFile?> PickedImages;

  const _FormImageUploader({Key? key, required this.PickedImages}) : super(key: key);
  @override
  State<_FormImageUploader> createState() => _FormImageUploaderState(PickedImages: PickedImages);
}

class _FormImageUploaderState extends State<_FormImageUploader> {

  _FormImageUploaderState({required this.PickedImages});
  final List<XFile?> PickedImages;
  final ImagePicker _picker = ImagePicker();  
  // 카메라, 갤러리에서 이미지 1개 불러오기
  // ImageSource.galley , ImageSource.camera 
  void getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      print('이미지가 선택되었습니다.');
    } else {
      print('아무것도 선택하지 않았습니다.');
    }
    setState(() {
      PickedImages.add(image!);
    });
  }
  
  // 이미지 여러개 불러오기
  void getMultiImage() async {
    final List<XFile>? images = await _picker.pickMultiImage();

    if (images != null) {
      setState(() {
        PickedImages.addAll(images);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [        
        _imageLoadButtons(),
      //  const SizedBox(height: 1),
        _GridPhoto(),
      ],

    );
  }


  // 화면 상단 버튼
  Widget _imageLoadButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
      /*    SizedBox(
            child: ElevatedButton(
              onPressed: () => getImage(ImageSource.camera),
              child: const Text('Camera'),
            ),
          ),*/
        /*  const SizedBox(width: 10,),
          IconButton(
            onPressed: () => getMultiImage(),
            icon: Icon(Icons.collections, size: 50, color: Colors.blueAccent)
          ),
          */
          TextButton.icon(
            label: const Text('회사를 소개할 사진이나 실적 사진을 올려주세요.'),
            icon: Icon(Icons.image, size: 50,),
            style: TextButton.styleFrom(foregroundColor: Colors.blueGrey),
            onPressed : () =>getMultiImage(),            
          ),
          const SizedBox(width: 5),          
        ],
      ),
    );
  }
  
  // 불러온 이미지 gridView
  Widget _GridPhoto() { 
    return Container(
      margin: EdgeInsets.all(10),
      child: GridView.builder(padding: EdgeInsets.all(0),
        shrinkWrap: true,
        itemCount: PickedImages.length, //보여줄 item 개수. images 리스트 변수에 담겨있는 사진 수 만큼.
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, //1 개의 행에 보여줄 사진 개수
          childAspectRatio:
          1 / 1, //사진 의 가로 세로의 비율
          mainAxisSpacing: 10, //수평 Padding
          crossAxisSpacing: 5, //수직 Padding
        ),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image:
                    DecorationImage(
                        fit: BoxFit.cover,  //사진을 크기를 상자 크기에 맞게 조절
                        image: FileImage(File(PickedImages[index]!.path   // images 리스트 변수 안에 있는 사진들을 순서대로 표시함
                        ))
                    )
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
*/