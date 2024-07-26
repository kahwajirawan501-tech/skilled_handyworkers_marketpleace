import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';

class ImageScreen extends StatelessWidget {
  final String imageUrl;

  ImageScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        leading: SizedBox(),
      ),
      body: Container(
        color:AppColor.backgroundColor ,
        child: Center(
          child: PhotoView(
            backgroundDecoration: BoxDecoration(
              color: AppColor.backgroundColor
            ),
            imageProvider: NetworkImage(imageUrl,),
          ),
        ),
      ),
    );
  }
}