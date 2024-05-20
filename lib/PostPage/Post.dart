import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'PostModel.dart';


final List<Posting_Property?> _posting_property = [];

class CreatePostThread extends StatefulWidget {
  const CreatePostThread({super.key});

  @override
  State<CreatePostThread> createState() => _CreatePostThreadState();
}

class _CreatePostThreadState extends State<CreatePostThread> {
  //final _formkey = GlobalKey<FormState>();
  final List<XFile> _pickedImages = [];
  String title = '';
  String description = '';
  String PhoneNumber = '';
  String Url = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text("게시글 작성"),
        // 뒤로가기 버튼
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_back),
          onPressed: () {
            Navigator.pop(context, _posting_property);
          },
        ),
      ),
      body: Form(
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
                            labelText: '제 목',
                          ),
                          onChanged: (value) {
                          //  setState(() {
                              title = value;
                           // });
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            hintText: 'Enter a description...',
                            labelText: '소 개',
                          ),
                          onChanged: (value) {
                            description = value;
                          },
                          maxLines: 10,
                        ),
                        TextFormField (
                          onChanged: (value) {
                            PhoneNumber = value;
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
                          onChanged: (value) {
                            Url = value;
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.insert_link ,color: Colors.blueAccent,),
                            border: OutlineInputBorder(),
                            filled: true,
                            hintText: 'Enter a description...',
                            labelText: '링 크',
                          ),
                        ),
                        _FormImageUploader (PickedImages: _pickedImages,),    
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
                              print("kakakakak " + title + description);
                              _posting_property.add(Posting_Property(title, description, PhoneNumber, Url, _pickedImages));
                              print("ITEM COUNT : ");
                              print(_posting_property.length);
                              print("\n")
;                              Navigator.pop(context, _posting_property);
                            },
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

class _FormImageUploader extends StatefulWidget {
 final List<XFile?> PickedImages;

  const _FormImageUploader({Key? key, required this.PickedImages}) : super(key: key);
  @override
  State<_FormImageUploader> createState() => _FormImageUploaderState(PickedImages: PickedImages);
  //State<_FormImageUploader> createState() => _FormImageUploaderState();
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
            label: const Text('회사 소개 이미지 가져오기'),
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
/* child : ListView.builder(
        itemCount: PickedImages.length,
        itemBuilder: (context, index) {
          //final image = PickedImages[index];
          return Feed(imageFile: [PickedImages[index]],);
          Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.file(
                File(PickedImages.path),
                fit: BoxFit.cover,
              )
            ],

          );  
          */
