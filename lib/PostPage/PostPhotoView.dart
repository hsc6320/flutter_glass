
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';


class Photoview_viewerPage extends StatefulWidget {
  final int Index;
  final List<XFile?> SelectedImage;
  Photoview_viewerPage({super.key, required this.SelectedImage, required this.Index});

  @override
   State<Photoview_viewerPage> createState() => _Photoview_viewerPage();
}

class _Photoview_viewerPage extends State<Photoview_viewerPage> {
  late PageController _controller;
  bool tapGes =true;
  
  void _handleTap() {
      // 탭(클릭) 제스처가 감지될 때 실행될 코드
      setState(() {
        tapGes = !tapGes;
      });
  }
  @override
  Widget build(BuildContext context) {
    _controller = PageController(initialPage: widget.Index);
    return Scaffold (
     // appBar: AppBar(
     //   title: Text('PageviewPage'),
     // ),
        body : Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 5),
          color: Colors.black,
          child : PageView.builder (
          controller: _controller,
          itemCount: widget.SelectedImage.length,
          itemBuilder: (context, idx) {
            return Container (
                child :GestureDetector(
                  onTap : () {
                    _handleTap();
                  },
                  child : Stack (
                    children: [ 
                      PhotoView(
                        imageProvider: AssetImage(widget.SelectedImage.elementAt(idx)!.path),
                      ),
                      Visibility(
                        child : Align(
                        alignment: Alignment.topRight,
                        child : Container(
                          margin: const EdgeInsets.only(top: 100, right: 20),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white24,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ), 
                        ),
                        ),
                        visible: tapGes, 
                      ),
                      Visibility (
                        child : Align(
                          alignment: Alignment.bottomCenter,
                          child : Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              "${idx + 1} / ${widget.SelectedImage.length}",
                              style: const TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ) ,
                        visible: tapGes, 
                      ),
                    ],
                  ),
              ),
            );
          }, 
        )
      )
    );
  }

}