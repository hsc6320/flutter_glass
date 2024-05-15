
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'PostPage/Post.dart';
import 'PostPage/PostModel.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.getTextTheme('Noto Sans'),
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex =0;
  List<Posting_Property?> PostingList = [];
  
  void cardClickEvent(/*BuildContext context,*/ int index) {
    String content = itemContents[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContentPage(content: content),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final sizex = MediaQuery.of(context).size.width;
    final sizey = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar (
        title: Text("메인 페이지"),
      ),
      body: PostingList.isEmpty
        ? Center(child: Text("게시글이 없습니다."))
          : Scrollbar(
            child: Align(
              alignment: Alignment.topCenter, 
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 5),
                  color: Color.fromARGB(255, 189, 173, 51),
                  child : Column (
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        //color: Color.fromARGB(255, 157, 219, 156),
                        child: ListView.separated (//ListView.builder(\
                          itemCount: PostingList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            return Container (
                              onTap: () => cardClickEvent(/*context,*/ index),
                              padding: EdgeInsets.all(5),
                              color: Color.fromARGB(255, 219, 156, 175),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 150,
                                    width: 90,
                                    child: Image(image: FileImage(File(PostingList[index]!.UploadImages[0]!.path))),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Column (
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: Text(
                                                PostingList[index]!.PostingTitle,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                PostingList[index]!.PostingMainText,
                                                maxLines: 5,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ))
                                ],
                              ),
                            );
                          }, separatorBuilder: (BuildContext context, int index) => const Divider(),
                          
                        ),
                      ),
                    ],
                  )
                ),
              ),
            )
          ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () async {
          // + 버튼 클릭시 버킷 생성 페이지로 이동
           PostingList = await Navigator.push(
           context,
           MaterialPageRoute(builder: (_) => CreatePostThread()),
         );
         setState(() {});
        },
        elevation: 0,
      ), 
      bottomNavigationBar: NavigationBar(
      onDestinationSelected: (int index){  
          setState(() {
            currentPageIndex = index;
            print('PagIndex : $currentPageIndex');
          });
         },
         indicatorColor: Colors.amber,
         backgroundColor: Colors.lightGreen,
          destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.forum),
            icon: Icon(Icons.forum_outlined),
            label: '게시글',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.business_sharp),
            icon: Icon(Icons.business),
            label: 'Business1',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person_2_sharp),
            icon: Icon(Icons.person),
            label: '프로필',
          ),
        ],
      )
    );
  }
}


class ContentPage extends StatelessWidget {
  final String content;
 
  const ContentPage({Key? key, required this.content}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Content'),
      ),
      body: Center(
        child: Text(content),
      ),
    );
  }
}
/*

 return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    Container(
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image:
                        DecorationImage(
                            fit: BoxFit.cover,  //사진을 크기를 상자 크기에 맞게 조절
                            image: FileImage(File(PostImage[index]!.path))   // images 리스트 변수 안에 있는 사진들을 순서대로 표시함
                        )
                      ),
                    ),
                  ],
                );

     title: Text(
                    PostingList[index]!.PostingTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    PostingList[index]!.PostingMainText,                    
                    overflow: TextOverflow.ellipsis,
                  ),
                  */