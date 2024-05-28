
import 'package:flutter/material.dart';
import 'package:glassapp/Utills/ImageSelection.dart';
import 'package:image_picker/image_picker.dart';

class EstimatePage extends StatefulWidget {
  
  EstimatePage({Key? key, /*required this.PickedImages,*/}) : super(key: key);

  @override
  State<EstimatePage> createState() => _EstimatePageState();
}

class _EstimatePageState extends State<EstimatePage> {
  final _formKey = GlobalKey<FormState>();

  List<XFile?> PickedImages = [];

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: Text("FORM 작성"),//Text(PostingList[Index]!.PostingTitle),
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: AutofillGroup(
              child: Column(
                children: [
                  ...[
                    //const Text('기업이 보는 견적서를 작성해보세요 '),
                    const Text('내용 작성'),
                    TextFormField(
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: '홍길동',
                        labelText: '이 름',
                      ),
                      autofillHints: const [AutofillHints.givenName],
                    ),
                    const TextField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'foo@example.com',
                        labelText: 'Email',
                      ),
                      autofillHints: [AutofillHints.email],
                    ),
                    const TextField(
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: '(010) 456-7890',
                        labelText: '연락처',
                      ),
                      autofillHints: [AutofillHints.telephoneNumber],
                    ),
                    const TextField(
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: '서울 강남구 테헤란로',
                        labelText: '주소',
                      ),
                      autofillHints: [AutofillHints.streetAddressLine1],
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: '스포츠/조경 등',
                        labelText: '목적 및 용도',
                      ),
                    ),
                    const TextField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: '그물망/펜스 등',
                        labelText: '악세서리 설치 유무',
                      ),
                    ),
                    const TextField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'YY/MM/DD',
                        labelText: '희망 날짜',
                      ),
                    ),
                    const TextField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: '그외 하실 말씀들...',
                        labelText: '기타 문의 사항',
                      ),
                    ),
                    const TextField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: '가로 x 세로 ',
                        labelText: '면적',
                      ),
                    ),
                    FiledImageUploader(PickedImages: PickedImages, aaa: '시공 할 현장 사진을 올려주세요',),
                 
                  ].expand(
                    (widget) => [
                      widget,
                      const SizedBox(
                        height: 24,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}