//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:glassapp/BusinessPage/BusinessPage.dart';
import 'package:glassapp/EstiamtePage/EstimatePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'PostPage/PostModel.dart';


void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  runApp(
    // Adding ProviderScope enables Riverpod for the entire project
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: 100)),
      builder: (context, AsyncSnapshot snapshot) {
     /*   if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: Splash());
        } 
        else { */
          return MaterialApp(
            title: 'PostingApp', // 앱의 아이콘 이름
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: GoogleFonts.getTextTheme('Noto Sans'),
            ),
            home: MainPage(),
          );
    //    }
     }
  );
  }
}


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  //_MainPageState createState() => _MainPageState();
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex =0;
  late List<Posting_Property?> PostingList = [];
  //late ScrollController scrollController = ScrollController();

  List<Widget> _widgetOptions = <Widget>[
    GlassMainPage(),
    Businesspage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext contextf) {
    FlutterNativeSplash.remove();
    //final sizex = MediaQuery.of(context).size.width;
    //final sizey = MediaQuery.of(context).size.height;
    return MaterialApp(
        home: Scaffold (
          body : 
          /* currentPageIndex == 0
                    ? GlassMainPage()
                    : currentPageIndex == 1
                        ? Businesspage(PostList: PostingList, /*scrollController: scrollController,*/ index: currentPageIndex,)
                        : ProfilePage(),
          */
          
       /*   IndexedStack (
            index: currentPageIndex,
            children: [   
              GlassMainPage(),
              Businesspage(PostList: PostingList, /*scrollController: scrollController,*/ index: currentPageIndex,),
              ProfilePage(),
            ]
          ),*/
          SafeArea(
             child: _widgetOptions.elementAt(currentPageIndex),
          ),

        bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index){ 
          setState(() {
            currentPageIndex = index;
            print('PageIndex : $currentPageIndex');
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
   @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  Widget Self_estimation() {
    return Center(
    //  child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card (
             // margin : EdgeInsets.only(top: 5.0,),
              shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
                borderRadius: BorderRadius.circular(5.0),
              ),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 110),
              elevation: 10,
              child: Image.network('http://www.specialtimes.co.kr/news/photo/202206/317289_314796_1929.jpg'),
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
               child: ListTile(
                  trailing: ClipRRect(
                    borderRadius : BorderRadius.circular(10),
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
    //  )
    );
  }

  @override
  Widget build(BuildContext context) {
    //final sizex = MediaQuery.of(context).size.width;
    //final sizey = MediaQuery.of(context).size.height;
    //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
    return Scaffold(
     /* appBar: AppBar(
        title: Text("플러터 페이지"),
      ),*/
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


class Splash extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/image/logo.png')
      ),
    );
  }
}