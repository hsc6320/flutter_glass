
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassapp/PostPage/PostPhotoView.dart';
import 'package:glassapp/Utills/ImageSelection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import 'PostModel.dart';

final List<Posting_Property?> _posting_property = [];


class ContentPage extends StatefulWidget {
  final int Index;
  final List<Posting_Property?> PostingList;
  final List<XFile?> SelectedImage;

  const ContentPage({Key? key, required this.Index, required this.PostingList, required this.SelectedImage, }) : super(key: key);

  @override
  State<ContentPage> createState() => _ContentPageState(index: Index, PostingList: PostingList, SelectedImage: SelectedImage);
}

class _ContentPageState extends State<ContentPage> {
  

  _ContentPageState({required this.index, required this.PostingList, required this.SelectedImage});

  int index = 0;
  List<Posting_Property?> PostingList = [];
  List<XFile?> SelectedImage = [];
  int lendgth_ = 0;
  bool _hasCallSupport = false;
  Future<void>? _launched;
  
  void initState() {
    super.initState();
    String phonenumber = PostingList[index]!.PostingPhoneNumer;
    phonenumber = '+82' + phonenumber;
    phonenumber = phonenumber.replaceAll('010', ' 10 ');
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: phonenumber)).then((bool result) {
      setState(() {
        _hasCallSupport = result;
        print("Phone Num : $result $_hasCallSupport");
      });
    });
  } 

  Future<void> _makePhoneCall( {required String? phoneNumber} ) async {
    if(phoneNumber == '') {
      phoneNumber = '0';
    }
    phoneNumber = '+82' + phoneNumber!;
    phoneNumber = phoneNumber.replaceAll('010', ' 10 ');
    
    final Uri urlParsed = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(urlParsed)) {
      await launchUrl(urlParsed);
    } else {
      throw 'Could not launch to: $phoneNumber';
    }
     
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.PostingList[widget.Index]!.PostingTitle),
      ),
      body : Container(
        child: SingleChildScrollView (
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Text(
                widget.PostingList[widget.Index]!.PostingMainText,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                // maxLines: 3,
              ),
              ElevatedButton (
               onPressed: _hasCallSupport
                  ? () => setState(() {
                      _launched = _makePhoneCall(phoneNumber: PostingList[index]!.PostingPhoneNumer);
                    })
                  : null,
                child: _hasCallSupport
                    ?  Text(
                  '연락처 : ' + 
                  PostingList[index]!.PostingPhoneNumer,
                  textAlign: TextAlign.left,
                  style: const TextStyle (
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  ),
                )
                : Text(
                  '전화 사용 불가' + 
                  PostingList[index]!.PostingPhoneNumer,
                  textAlign: TextAlign.left,
                  style: const TextStyle (
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  ),
                )
              ),
              widget.PostingList[widget.Index]!.PostingUrl.isEmpty ? 
                Text("")
                :
              ElevatedButton(
                child : Text(
                  widget.PostingList[widget.Index]!.PostingUrl,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                onPressed: () async {
                    final url = Uri.parse(
                      "https://" +widget.PostingList[widget.Index]!.PostingUrl
                    );
                    if (await canLaunchUrl(url)) {
                      print("Possible launch $url");
                      await launchUrl(url,);
                    } else {
                      // ignore: avoid_priㅋㅊㅂnt
                      print("Can't launch $url");
                    }
                }, 
              ),
              PostingList[index]?.SelectingImage[0] != null ?
                Column (
                  children : List.generate(PostingList[index]!.SelectingImage.length, (idx) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                              return Photoview_viewerPage(Index: idx, SelectedImage: SelectedImage,
                                );
                          }));
                      },
                      child: Container(
                        child : Image.asset(PostingList[index]!.SelectingImage.elementAt(idx)!.path), // images 리스트 변수 안에 있는 사진들을 순서대로 표시함
                      )
                    ) ;
                  }).toList(), 
                )
                :
                Column (
                  children : [ 
                    Container(
                      child : Text(
                        "",
                        style: TextStyle(
                          fontSize: 0,
                        ),
                      ),
                    ),
                  ]
                ), 
            ],
          ),
        ),
      ),
    );
        //Text(PostingList[Index]!.PostingMainText),
  }
}
/*
class CreatePostThread extends StatefulWidget {
//  final List<XFile> SelectedImage;

  const CreatePostThread({super.key, /*required this.SelectedImage*/});
  
  @override
  State<CreatePostThread> createState() => _CreatePostThreadState();
}*/

//class _CreatePostThreadState extends State<CreatePostThread> {

// ignore: must_be_immutable
class CreatePostThread extends ConsumerWidget {

  late List<XFile?> pickedImages = [];
  //CreatePostThread({required this.bbb}) ;
  final _formKey = GlobalKey<FormState>();
  //final PostingImage bbb;

  String title = '';
  String description = '';
  String PhoneNumber = '';
  String Url = '';
  List<XFile?> SelectedImage = [];

  List<Posting_Property?> PosttingList = [];
 // late Posting_Property aaa;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<bool> ShowTempSaveDialog () async {
      return await showDialog (
        barrierDismissible: false,
        context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Get out?'),
              content: Text("저장되지 않습니다. 나가시겠습니까?"),
              actions: <Widget> [
                TextButton(
                  child: const Text('Got it'),
                  onPressed: () {
                    Navigator.pop(context, true);
                  }
                ),
                TextButton(
                  child: const Text('Nope'),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            );
          },
      );
    }
    return WillPopScope(
      onWillPop: () async {
        return await ShowTempSaveDialog(); 
      },
      child :Scaffold(
       appBar: AppBar(
        title: Text("견적 내기"),
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: Align(
            alignment: Alignment.topCenter,
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
                            title = value!;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            hintText: 'Enter a description...',
                            labelText: '소개 및 실적',
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
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
                          validator: (value) {
                            if(value!.isEmpty) {
                              value = null;
                            }
                            return null;
                          },
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
                                PostingImage aaa = PostingImage(title, description, PhoneNumber, Url,SelectedImage, _posting_property);
                                aaa.PostUpdate();
                                //_posting_property.add(Posting_Property(title, description, PhoneNumber, Url, pickedImages));
                                
                                print("ITEM COUNT : ");
                                print(_posting_property.length);
                                print("\n");
                                Navigator.pop(context, aaa);
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
          ),
        ),
      ),
    ),
    );
  }
}