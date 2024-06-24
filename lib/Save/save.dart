import 'package:flutter/material.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/ListOfPosting.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/ListOpenQuestion.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class Save extends StatefulWidget {
  const Save({Key? key}) : super(key: key);

  @override
  State<Save> createState() => _SaveState();
}

class _SaveState extends State<Save> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColor.backgroundColor,
        backgroundColor: AppColor.backgroundColor,
        title: Text("Save Post",style: TextStyle
          (fontSize:AppFontStyles.borderRadius ,fontWeight: AppFontStyles.fontWeightBold,color: AppColor.bluColor),),
        centerTitle: true,
        // actions: [
        //   // TextButton(
        //   //
        //   //     onPressed: () {
        //   //
        //   // }, child: Text("Delete",style: TextStyle(fontSize:AppFontStyles.descriptionLoginFontSize ,color: AppColor.orangeColor),))
        //
        //   ],

      ),
      body: Container(
        color: AppColor.backgroundColor,
        child: ListOfOpenQuestion(
          time: "21 minutes ago",
          numberOfCommit: "10",
          name: "Orlando Diggs",
          imagePath: "assets/images/Mask group.png",
          openQuestion:"What are the characteristics of a fake job call form?\n"
              "Because I always find fake job calls so "
              "I'm confused which job to take can you share your knowledge here? thank you",
          onTapImage: () {

          },
          onPressedForCommit:(){

          },
          onPressedForFavorit: (){

          },

        ) ,
      ),
    );
  }
}
