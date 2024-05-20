
import 'dart:io';
//import 'dart:js';

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
  late List<Posting_Property?> PostingList = [];
  late ScrollController scrollController = ScrollController();

  
   @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  
  void ScrollToTop() {
    var controller = PrimaryScrollController.of(context);
    setState(() {
      controller.animateTo(0,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    //final sizex = MediaQuery.of(context).size.width;
    //final sizey = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar (
        title: Text("메인 페이지"),
      ),
      body: IndexedStack (
          index: currentPageIndex,
          children: [
            GlassMainPage(PostList: PostingList, scrollController: scrollController, index: currentPageIndex,),
          ]
      ),
      floatingActionButton: Stack (
        children: <Widget> [
          Align(
            alignment: Alignment(Alignment.bottomRight.x, Alignment.bottomRight.y-0.2),
            child: FloatingActionButton(
              heroTag: 'edit',
              onPressed: () async {
                  // + 버튼 클릭시 게시글 생성 페이지로 이동
                  PostingList = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CreatePostThread()),
                );
                setState(() {});
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

class GlassMainPage extends StatefulWidget { 

  GlassMainPage({Key? key, required this.index,required this.PostList, required this.scrollController}) : super(key: key);

  final List<Posting_Property?> PostList;
  late ScrollController scrollController;
  int index;

  @override
  State<GlassMainPage> createState() => _GlassMainPageState();
}

class _GlassMainPageState extends State<GlassMainPage> {
  final String Content = "";
  
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Align(
        child : Container(
          color: Color.fromARGB(255, 214, 214, 225),
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
                      controller: widget.scrollController,
                      itemCount: widget.PostList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return Container (
                          padding: EdgeInsets.all(10),
                          color: Color.fromARGB(255, 219, 156, 175),
                          child : GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute( builder: (context) => ContentPage(Index: index, PostingList: widget.PostList, )));
                              },
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 150,
                                  width: 90,
                                  child: Image(image: FileImage(File(widget.PostList[index]!.UploadImages[0]!.path))),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left:15),
                                    child: Column (
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            child: Text(
                                              widget.PostList[index]!.PostingTitle,
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              widget.PostList[index]!.PostingMainText,
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
}

class ContentPage extends StatelessWidget {
  final int Index;
  final List<Posting_Property?> PostingList;
  const ContentPage({Key? key, required this.Index, required this.PostingList, }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(PostingList[Index]!.PostingTitle),
      ),
      body: Center(
        //String sss = PostingList[Index]!.PostingTitle;
        child: Text(PostingList[Index]!.PostingMainText),
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