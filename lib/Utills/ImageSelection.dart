
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


// ignore: must_be_immutable
class FiledImageUploader extends StatefulWidget {
  
  final List<XFile?> PickedImages;
  String aaa = '';
  FiledImageUploader({Key? key, required this.PickedImages, required this.aaa}) : super(key: key);


  @override
  State<FiledImageUploader> createState() => _FiledImageUploaderState( PickedImages: PickedImages, ImageDescription: aaa, );
  //State<_FiledImageUploader> createState() => _FiledImageUploaderState();
}

class _FiledImageUploaderState extends State<FiledImageUploader> {

  _FiledImageUploaderState({required this.PickedImages, required this.ImageDescription});

  final List<XFile?> PickedImages;
  final ImagePicker _picker = ImagePicker();  
  final String ImageDescription;
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
      PickedImages.add(image);
    });
  }
  
  // 이미지 여러개 불러오기
  void getMultiImage() async {
   final List<XFile>? images = await _picker.pickMultiImage();
   // File file = File('glassapp/assets/image/No_image.png');
    //XFile files = XFile(file.path);

    if (images != null) {
      setState(() {
        PickedImages.addAll(images);
      });
    }
    else {
      setState(() {
      print("선택된 이미지 없음");
      PickedImages.add("" as XFile?);
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
            label: Text(/*'회사를 소개할 사진이나 실적 사진을 올려주세요.*/ImageDescription),
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
                        )),
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