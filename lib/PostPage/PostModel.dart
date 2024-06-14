
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:image_picker/image_picker.dart';

//List<XFile?> SelectedImage = [];
final todoModelStateProvider = StateProvider((ref) => PostingImage("", "", "", "", [], []));

class Posting_Property  {
  String PostingTitle = "";
  String PostingMainText = "";
  String PostingPhoneNumer = " ";
  String PostingUrl = "";
  List<XFile?> SelectingImage = [];

  Posting_Property(this.PostingTitle, this.PostingMainText, this.PostingPhoneNumer, this.PostingUrl, this.SelectingImage); // 생성자
 
}

class PostingImage extends Posting_Property {
  List<XFile?> SelectingImage = [];

  List<Posting_Property?> PosttingList = [];
  

  PostingImage(String PostingTitle, String PostingMainText, String PostingPhoneNumer, String PostingUrl, this.SelectingImage, this.PosttingList) 
    : super(PostingTitle, PostingMainText, PostingPhoneNumer, PostingUrl, SelectingImage);

  void PostUpdate () {
    PosttingList.add(Posting_Property(PostingTitle, PostingMainText, PostingPhoneNumer, PostingUrl, SelectingImage));
    print("업데이트 사진 개수 : ");
    print(SelectingImage.length);
  }
}

class PostingListModel extends StateNotifier<Posting_Property?> {
  Ref ref;
  PostingListModel(super.state, this.ref);
  
  ///ostingListModel(this.PostingList ) : super(null);
  void UploadPost () {
  }

}