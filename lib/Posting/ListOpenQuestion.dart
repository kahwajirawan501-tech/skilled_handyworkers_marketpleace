import 'package:flutter/material.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/BottonNavigationBar.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/OpenQuestionModel.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/postModel.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class ListOfOpenQuestion extends StatefulWidget {
  final GestureTapCallback? onTapImage;
  final String imagePath;//"assets/images/Mask group.png"
  final String name;//Orlando Diggs
  final String time;//21 minutes ago
  final VoidCallback? onPressedForCommit;
  final VoidCallback? onPressedForFavorit;
  final String numberOfCommit;
  final String openQuestion;
//"What are the characteristics of a fake job call form?\n"
//                     "Because I always find fake job calls so "
//                     "I'm confused which job to take can you share your knowledge here? thank you"
  const ListOfOpenQuestion({Key? key, this.onTapImage, required this.imagePath, required this.name, required this.time, this.onPressedForCommit, this.onPressedForFavorit, required this.numberOfCommit, required this.openQuestion}) : super(key: key);

  @override
  State<ListOfOpenQuestion> createState() => _ListOfOpenQuestionState();
}

class _ListOfOpenQuestionState extends State<ListOfOpenQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(AppFontStyles.aboutMe),
          child: ListView.separated(
              itemBuilder: (context, index) =>
                  OpenQuestionModel(
                    time: widget.time,
                    numberOfCommit: widget.numberOfCommit,
                    name: widget.name,
                    imagePath: widget.imagePath,
                    openQuestion: widget.openQuestion,
                    onTapImage: widget.onTapImage,
                    onPressedForFavorit: widget.onPressedForFavorit,
                    onPressedForCommit: widget.onPressedForCommit,

                  ),
              separatorBuilder: (context, index) => SizedBox(height: AppFontStyles.descriptionLoginFontSize,),
              itemCount: 4),
        ),
      ),
    );
  }
}
