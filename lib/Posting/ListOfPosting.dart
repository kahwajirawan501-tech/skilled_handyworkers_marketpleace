import 'package:flutter/material.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/BottonNavigationBar.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/postModel.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class ListOfPosting extends StatefulWidget {
  final String? videoUrl;
  final List<String>? imagePaths;
  //List<String> imagePaths=[
  //     "assets/images/download.jpg",
  //     "assets/images/download.jpg",
  //     "assets/images/download.jpg",
  //     "assets/images/download.jpg",
  //     "assets/images/download.jpg",
  //     "assets/images/download.jpg",
  //     "assets/images/download.jpg",
  //   ];
  final GestureTapCallback? onTapImage;
  final String imagePath;//"assets/images/Mask group.png"
  final String name;//Orlando Diggs
  final String time;//21 minutes ago
  final VoidCallback? onPressedForCommit;
  final VoidCallback? onPressedForFavorit;
  final String numberOfCommit;
  const ListOfPosting({Key? key, this.videoUrl, this.imagePaths, this.onTapImage, required this.imagePath, required this.name, required this.time, this.onPressedForCommit, this.onPressedForFavorit, required this.numberOfCommit}) : super(key: key);

  @override
  State<ListOfPosting> createState() => _ListOfPostingState();
}

class _ListOfPostingState extends State<ListOfPosting> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(AppFontStyles.aboutMe),
          child: ListView.separated(
              itemBuilder: (context, index) => PostModel
                (name: widget.name,
                imagePath:widget.imagePath,
                numberOfCommit: widget.numberOfCommit,
                time: widget.time,
                imagePaths:widget.imagePaths,
                onPressedForCommit: widget.onPressedForCommit,
                onPressedForFavorit: widget.onPressedForFavorit,
                onTapImage: widget.onTapImage,
                videoUrl:widget.videoUrl ,
              )
              ,
              separatorBuilder: (context, index) => SizedBox(height: AppFontStyles.descriptionLoginFontSize,),
              itemCount: 4),
        ),
      ),
    );
  }
}
