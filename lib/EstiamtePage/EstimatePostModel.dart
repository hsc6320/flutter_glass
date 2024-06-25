

import 'package:image_picker/image_picker.dart';

class Estimate_Property  {
  String Estimate_Name = "";
  String Estimate_Mail = "";
  String Estimate_PhoneNumer = " ";
  String Estimate_Address = "";
  String Estimate_Target = "";
  String Estimate_Setup = "";
  String Estimate_Date = " ";
  String Estimate_Area_X = "";
  String Estimate_Area_Y = "";
  String Estimate_etcInquiry = "";
  List<XFile?> SpotImage = [];

  

  Estimate_Property(this.Estimate_Name, this.Estimate_Mail, this.Estimate_PhoneNumer, this.Estimate_Address, 
                this.Estimate_Target, this.Estimate_Setup, this.Estimate_Date, this.Estimate_etcInquiry,
                this.Estimate_Area_X, this.Estimate_Area_Y, this.SpotImage); // 생성자

 
}

class ConstructSpotImage extends Estimate_Property {
  List<XFile?> SpotImage = [];

  List<Estimate_Property?> EstimatePostList = [];
  

  ConstructSpotImage (
    String Estimate_Name, 
    String Estimate_Mail, 
    String Estimate_PhoneNumer, 
    String Estimate_Address, 
    String Estimate_Target, 
    String Estimate_Setup, 
    String Estimate_Date, 
    String Estimate_etcInquiry,
    String Estimate_Area_X,
    String Estimate_Area_Y, 
    this.SpotImage, 
    this.EstimatePostList) 
    : super (
    Estimate_Name, 
    Estimate_Mail, 
    Estimate_PhoneNumer, 
    Estimate_Address, 
    Estimate_Target, 
    Estimate_Setup, 
    Estimate_Date, 
    Estimate_etcInquiry, 
    Estimate_Area_X,
    Estimate_Area_Y, 
    SpotImage);

  void PostUpdate () {
    EstimatePostList.add(Estimate_Property(Estimate_Name, Estimate_Mail, Estimate_PhoneNumer, Estimate_Address, 
                    Estimate_Target, Estimate_Setup, Estimate_Date, Estimate_etcInquiry, Estimate_Area_X, Estimate_Area_Y,  SpotImage));
                    
    print("견적 업데이트 사진 개수 : ${SpotImage.length}");
    //print("이름 : " + Estimate_Name );
    //print("메일 주소 : " + Estimate_Mail );
    //print("연락처 : " + Estimate_PhoneNumer);
    print("가로 면적 : $Estimate_Area_X, 세로 면적 : $Estimate_Area_Y");
  }
}