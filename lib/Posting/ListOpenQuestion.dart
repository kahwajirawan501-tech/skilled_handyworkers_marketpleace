import 'package:flutter/material.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/BottonNavigationBar.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/OpenQuestionModel.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/postModel.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class ListOfOpenQuestion extends StatefulWidget {
  const ListOfOpenQuestion({Key? key}) : super(key: key);

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
              itemBuilder: (context, index) => OpenQuestionModel(),
              separatorBuilder: (context, index) => SizedBox(height: AppFontStyles.descriptionLoginFontSize,),
              itemCount: 4),
        ),
      ),
    );
  }
}
