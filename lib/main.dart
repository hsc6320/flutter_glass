//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:glassapp/BusinessPage/BusinessPage.dart';
import 'package:glassapp/EstiamtePage/EstimatePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'PostPage/PostModel.dart';


void main() {
  runApp(
    // Adding ProviderScope enables Riverpod for the entire project
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PostingApp', // 앱의 아이콘 이름
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.getTextTheme('Noto Sans'),
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
  //State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
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

  @override
  Widget build(BuildContext contextf) {
    //final sizex = MediaQuery.of(context).size.width;
    //final sizey = MediaQuery.of(context).size.height;
    return MaterialApp(
        home: Scaffold (
          body :IndexedStack (
            index: currentPageIndex,
            children: [   
              GlassMainPage(),
              Businesspage(PostList: PostingList, scrollController: scrollController, index: currentPageIndex,),
              ProfilePage(),
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
        selectedIndex : currentPageIndex,
        backgroundColor: Colors.lightGreen,
          destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.forum),
            icon: Icon(Icons.forum_outlined),
            label: '내 플러터',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.business_sharp),
           // icon: Badge(child: Icon(Icons.business)),
            icon: Icon(Icons.business),
            label: '게시글',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person_2_sharp),
            icon: Icon(Icons.person),
            label: '프로필',
          ),
        ],
      )

      ),
    );
  }
}

class GlassMainPage extends StatefulWidget { 

  GlassMainPage({Key? key,}) : super(key: key);

  @override
  State<GlassMainPage> createState() => _GlassMainPageState();
}

// ignore: must_be_immutable
class _GlassMainPageState extends State<GlassMainPage> {

  final String Content = "";
  int currentPageIndex =0, postingListIndex =0;
  
  Widget Self_estimation() {
    return Center(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
             // margin : EdgeInsets.only(top: 5.0,),
              shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
                borderRadius: BorderRadius.circular(60.0),
              ),
              margin: EdgeInsets.symmetric(vertical: 9, horizontal: 100),
              elevation: 10,
              child: Image.network('https://get.pxhere.com/photo/planner-evaluate-assessment-teamwork-consulting-estimate-discussion-equipment-business-data-partnership-financial-people-project-adviser-analysis-analyze-assess-businesspeople-meeting-calculate-chart-consult-silhouette-black-sitting-furniture-black-and-white-standing-chair-human-behavior-male-communication-table-line-arm-area-conversation-font-angle-monochrome-joint-clip-art-logo-office-chair-graphics-shoe-1447891.jpg'),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              //"합리적인 가격에 견적을 받으세요",
              "플러터 공부 지금 당장 시작하세요",
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.black,
              ),
            ),
            Text(
              //"무엇을 도와 드릴까요?",
              "플러터 어디까지 해봤니",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.13,
              child :Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: ListTile(
                  trailing: Icon(Icons.shopping_cart),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute( builder: (context) => EstimatePage())
                    );
                  },
                  title: Text (
                    textAlign: TextAlign.start,
                    //"견적 내보기",
                    "I LIKE FULTTER",
                    style : TextStyle(
                      height: 3,
                      fontSize: 30,
                    ),
                  )
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.13,
             // child : Container ( 
              child: Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            /*    child : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child :Text (
                        textAlign: TextAlign.start,
                        "I LOVE FLUTTER",
                        style : TextStyle(
                          height: 3,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const SizedBox(
                      //width: 20,
                    ),
                    Container(
                      //margin: EdgeInsets.symmetric(vertical: 1, horizontal: 10,),
                      child: Image.network(fit: BoxFit.cover, 'https://st4.depositphotos.com/12982378/23018/i/1600/depositphotos_230185830-stock-photo-handsome-man-holding-bag-sitting.jpg'),
                    )
                  ]
                )
                */
               child: ListTile(
                  trailing: ClipRRect(
                    borderRadius : BorderRadius.circular(100),
                    child: Image.network(fit: BoxFit.fill, 'https://st4.depositphotos.com/12982378/23018/i/1600/depositphotos_230185830-stock-photo-handsome-man-holding-bag-sitting.jpg'),//Icon(Icons.shopping_cart),
                  ),
                  onTap: () {
                /*   Navigator.push(
                       context,
                       MaterialPageRoute( builder: (context) => )
                    );*/
                  },
                  title: Text (
                    textAlign: TextAlign.start,
                    "I LOVE FLUTTER",
                    style : TextStyle(
                      height: 3,
                      fontSize: 30,
                    ),
                  )
                ),
              ),
           ),
          ],
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    //final sizex = MediaQuery.of(context).size.width;
    //final sizey = MediaQuery.of(context).size.height;
  
    return Scaffold(
      appBar: AppBar(
        title: Text("플러터 페이지"),
      ),
      backgroundColor: Color.fromARGB(255, 201, 238, 193),
      body : Self_estimation(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //final int Index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    /*  appBar: AppBar(title: Text("기타 비지니스 페이지 "),),*/
      body: Center(
        //String sss = PostingList[Index]!.PostingTitle;
        child: Text("로그인 페이지"),
      ),
    );
  }
}