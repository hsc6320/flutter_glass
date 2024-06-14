import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassapp/PostPage/Post.dart';
import 'package:image_picker/image_picker.dart';

import '../PostPage/PostModel.dart';

String title = '';
String description = '';
String PhoneNumber = '';
String Url = '';
List<Posting_Property?> PosttingList = [];
List<XFile?> SelectedImage = [];
PostingImage aaa = PostingImage(title, description, PhoneNumber, Url, SelectedImage, PosttingList);


class Businesspage extends StatefulWidget/*ConsumerStatefulWidget*/ {

  Businesspage({Key? key, }) : super(key: key);

  @override
  State<Businesspage> createState() => _BusinesspageState();
  //_BusinesspageState createState() => _BusinesspageState();
}

class _BusinesspageState extends State<Businesspage>/*ConsumerState<Businesspage>*/ {
  final GlobalKey<_CustomWidgetState> _customWidgetKey = GlobalKey<_CustomWidgetState>();

  int currentPageIndex =0, postingListIndex =0;
  
  ScrollController scrollController = ScrollController();
  
  List<XFile?> UploadImages = [];

 @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void ScrollToTop() {
    var controller = PrimaryScrollController.of(context);
    setState(() {
      controller.animateTo(0,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }
  
  Widget PostingDisplay() {
    return Scrollbar(
        child: Align(
          child : Container(
            color: Color.fromARGB(255, 201, 238, 193),
            alignment: Alignment.topLeft, 
            child: SingleChildScrollView(
              primary: true,
              child: Container(
                margin: EdgeInsets.only(top: 5),
              // color: Color.fromARGB(255, 31, 31, 30),
                child : Column (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      //color: Color.fromARGB(255, 16, 237, 16),
                      child: ListView.separated (//ListView.builder(\
                        controller: scrollController,
                        itemCount: aaa.PosttingList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index){
                          return Container (
                            padding: EdgeInsets.all(10),
                            color: Color.fromARGB(255, 227, 240, 230),
                            child : GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute( builder: (context) => ContentPage(Index: index, PostingList: aaa.PosttingList, SelectedImage: aaa.PosttingList[index]!.SelectingImage,))
                                );
                                postingListIndex = index;
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 150,
                                    width: 90,
                                     child: aaa.PosttingList[index]?.SelectingImage[0] == null ? Image.asset('assets/image/No_image.png') 
                                        : Image(image: FileImage(File(aaa.PosttingList[index]!.SelectingImage[0]!.path))),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left:15),
                                      child: Column (
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: Text(
                                                aaa.PosttingList[index]!.PostingTitle,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                aaa.PosttingList[index]!.PostingMainText,
                                                maxLines: 5,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ))
                                ],
                              ),
                            ),
                          );
                        }, separatorBuilder: (BuildContext context, int index) => const Divider(),
                      ),
                    ),
                  ],
                )
              ),
            ),
          ),
        ),
      );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("게시글 페이지 "),),
        body: PostingDisplay(),
        floatingActionButton: Stack (
        children: <Widget> [
          Align(
            alignment: Alignment(Alignment.bottomRight.x, Alignment.bottomRight.y-0.2),
            child: FloatingActionButton(
              heroTag: 'edit',
              onPressed: () async {
                  // + 버튼 클릭시 게시글 생성 페이지로 이동
                  final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CreatePostThread()),
                );
                setState(() {
                  if(result != null) {
                    aaa = result;
                  };
                });
              },
              child: Icon(Icons.edit),
              elevation: 10,
            ), 
          ),
          Align (
            alignment: Alignment.bottomRight,
            child : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              heroTag: 'top',
              onPressed: () { ScrollToTop(); },
              elevation: 10,
            ), 
          ), 
        ]
      ),
      );
  //  );
  }
}


class CustomWidget extends StatefulWidget {
  CustomWidget({Key? key, required this.PostingList, }) : super(key: key);
  final List<Posting_Property?> PostingList;
  ///final List<XFile?> UploadImages;
  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 90,
   //   child: SelectedImage.isEmpty? Image.asset('assets/image/No_image.png') 
   //   : Image(image: FileImage(File(SelectedImage[0]!.path))),//SelectedImage
    );
  }
}