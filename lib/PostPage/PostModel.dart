import 'package:image_picker/image_picker.dart';


/*
class Posting {
  String WritePost;
  String Writer;

  Posting(this.WritePost, this.Writer); // 생성자
}*/

class Posting_Property {
  String PostingTitle;
  String PostingMainText;
  String PostingPhoneNumer;
  String PostingUrl;

  List<XFile?> UploadImages;

  Posting_Property(this.PostingTitle, this.PostingMainText, this.PostingPhoneNumer, this.PostingUrl, this.UploadImages); // 생성자

}

class Posting_Service {
  void CreatePostingTitle(String title) {

  }
}