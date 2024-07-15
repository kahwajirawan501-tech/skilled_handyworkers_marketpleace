import 'package:flutter/material.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/ListOfPosting.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/ListOpenQuestion.dart';
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
        surfaceTintColor: AppColor.backgroundColor,
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
        child: Text("kkk") ,
      ),
    );
  }
}
