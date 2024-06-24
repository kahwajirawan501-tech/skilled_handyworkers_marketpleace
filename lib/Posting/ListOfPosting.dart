import 'package:flutter/material.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/BottonNavigationBar.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/postModel.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class ListOfPosting extends StatefulWidget {
  const ListOfPosting({Key? key}) : super(key: key);

  @override
  State<ListOfPosting> createState() => _ListOfPostingState();
}

class _ListOfPostingState extends State<ListOfPosting> {
  List<String> imagePaths=[
    "assets/images/download.jpg",
    "assets/images/download.jpg",
    "assets/images/download.jpg",
    "assets/images/download.jpg",
    "assets/images/download.jpg",
    "assets/images/download.jpg",
    "assets/images/download.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(AppFontStyles.aboutMe),
          child: ListView.separated(
              itemBuilder: (context, index) => PostModel(imagePaths:imagePaths,),
              separatorBuilder: (context, index) => SizedBox(height: AppFontStyles.descriptionLoginFontSize,),
              itemCount: 4),
        ),
      ),
    );
  }
}
