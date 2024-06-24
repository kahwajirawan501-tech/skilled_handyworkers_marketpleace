import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/ListOfPosting.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/ListOpenQuestion.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profileScreen.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class TabBarPosting extends StatefulWidget {
  const TabBarPosting({Key? key}) : super(key: key);

  @override
  State<TabBarPosting> createState() => _TabBarPostingState();
}

class _TabBarPostingState extends State<TabBarPosting> {
  List<String> imagePaths=[
    "assets/images/download.jpg",
    "assets/images/download.jpg",
    "assets/images/download.jpg",
    "assets/images/download.jpg",
    "assets/images/download.jpg",
    "assets/images/download.jpg",
    "assets/images/download.jpg",
  ];
  bool clickPosting=false;
  bool clickOpenQuestion=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical:60),
        child: Container(
          color: AppColor.backgroundColor,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Column(

                    children: [
                      Container(width: double.infinity,height: 60,color: AppColor.backgroundColor,),
                      Container(
                        padding: EdgeInsets.zero,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/Group 48.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top:0, // Adjust this value to move the circle image vertically
                    child: Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "assets/images/Mask group.png",
                            fit: BoxFit.cover,
                            height: 80,
                            width: 80,
                          ),
                        ),
                        SizedBox(height: AppFontStyles.aboutMe,),
                        Text(
                          "Orlando Diggs",
                          style: TextStyle(
                            fontSize: AppFontStyles.aboutMe,
                            color: AppColor.fontColor,
                            fontWeight: AppFontStyles.fontWeightBold,
                          ),
                        ),
                        SizedBox(height: AppFontStyles.aboutMe,),

                      ],
                    ),
                  ),
                  Positioned(
                    bottom:0,
                    left: 0,
                    right: 0,// Adjust this value to move the circle image vertically
                    child:Padding(
                      padding: const EdgeInsets.all(AppFontStyles.padding),
                      child: Row(
                        children: [
                          Text(
                            "male",
                            style: TextStyle(
                              fontSize: AppFontStyles.aboutMe,
                              color: AppColor.fontColor,
                            ),
                          ),
                          Text(
                            " , ",
                            style: TextStyle(
                              fontSize: AppFontStyles.aboutMe,
                              color: AppColor.fontColor,
                            ),
                          ),
                          Text(
                            "syria",
                            style: TextStyle(
                              fontSize: AppFontStyles.aboutMe,
                              color: AppColor.fontColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "0997654357",
                            style: TextStyle(
                              fontSize: AppFontStyles.aboutMe,
                              color: AppColor.fontColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppFontStyles.aboutMe,),

              Row(
                children: [
                  SizedBox(width: AppFontStyles.aboutMe,),
                  Expanded(

                    child: Box(widget:GestureDetector(
                      onTap: () {


                          setState(() {
                            clickPosting=!clickPosting;
                            if(clickPosting){
                              clickOpenQuestion=false;

                            }
                          });
                      },
                      child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                            color: clickPosting?AppColor.orangeColor:Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Text("posting",style: TextStyle(color:clickPosting?Colors.white:AppColor.bluColor ),)
                      ),
                    ), height: 40, borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(width: AppFontStyles.aboutMe,),
                  Expanded(
                    child: Box(widget:GestureDetector(
                      onTap: () {


                          setState(() {
                            clickOpenQuestion=!clickOpenQuestion;
                            if(clickOpenQuestion){
                              clickPosting=false;

                            }
                          });


                      },
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                            color:clickOpenQuestion?AppColor.orangeColor:Colors.white,
                          ),
                          child: Text("open question",style: TextStyle(color:clickOpenQuestion?Colors.white:AppColor.bluColor ))
                      ),
                    ), height: 40, borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(width: AppFontStyles.aboutMe,),

                ],
              ),
              if(!(clickOpenQuestion||clickPosting))
                Expanded(child: Center(child: Image.asset("assets/images/Illustrasi.png"))),
              if(clickPosting)
                Expanded(child: ConditionalBuilder(
                  condition: clickPosting,
                  builder: (context) =>ListOfPosting(
                    imagePaths:imagePaths,
                    imagePath: "assets/images/Mask group.png",
                    name: "Orlando Diggs",
                    numberOfCommit:"10" ,
                    time:"21 minutes ago" ,
                    onPressedForCommit:(){

                    },
                    onPressedForFavorit:(){

                    },
                    onTapImage:(){

                    },

                  ) ,
                  fallback: (context) =>  Center(child: CircularProgressIndicator(color:AppColor.orangeColor,),),
                ),),
              if(clickOpenQuestion)

                Expanded(child: ConditionalBuilder(
                  condition: clickOpenQuestion,
                  builder: (context) =>ListOfOpenQuestion(
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
                  fallback: (context) =>  Center(child: CircularProgressIndicator(color:AppColor.orangeColor,),),
                ),),
            ],
          ),
        ),
      ),
    );
  }
}
