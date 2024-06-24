import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class OpenQuestionModel extends StatefulWidget {


  const OpenQuestionModel({Key? key}) : super(key: key);

  @override
  State<OpenQuestionModel> createState() => _OpenQuestionModelState();
}

class _OpenQuestionModelState extends State<OpenQuestionModel> {


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(AppFontStyles.aboutMe),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: ClipOval(
                    child: Image.asset(
                      "assets/images/Mask group.png",
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  title: Text(
                    "Orlando Diggs",
                    style: TextStyle(
                      fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                      color: AppColor.bluColor,
                      fontWeight: AppFontStyles.fontWeightBold,
                    ),
                  ),
                  subtitle: Text(
                    "21 minutes ago",
                    style: TextStyle(
                      fontSize: AppFontStyles.descriptionLoginFontSize,
                      color: AppColor.fontColorDescription,
                      fontWeight: AppFontStyles.fontWeightMedium,
                    ),
                  ),
                ),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),

                Text("What are the characteristics of a fake job call form?\n"
                    "Because I always find fake job calls so "
                    "I'm confused which job to take can you share your knowledge here? thank you",
                  style: TextStyle(fontWeight:AppFontStyles.fontWeightSemiBold ),
                ),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: AppColor.comment,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
            child: Row(
              children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      icon:  Icon(Icons.favorite, color:Colors.red),
                      onPressed: () {},
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(CupertinoIcons.bubble_left),
                      onPressed: () {},
                    ),
                    Text(
                      '10',
                      style: TextStyle(
                          fontSize: AppFontStyles.aboutMe,
                          color: AppColor.commentFont),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(CupertinoIcons.arrowshape_turn_up_right),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
