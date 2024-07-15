import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/ListOfPostForUser.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/ListOpenQuestionForUser.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class TabBarPosting extends StatefulWidget
{
  const TabBarPosting({Key? key}) : super(key: key);

  @override
  State<TabBarPosting> createState() => _TabBarPostingState();
}

 class _TabBarPostingState extends State<TabBarPosting> {

  bool clickPosting=false;
  bool clickOpenQuestion=false;
  List<Map<String, dynamic>> post = [];
  List<Map<String, dynamic>> openQuestion = [];






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CubitYourPost,YourPostStates>(
        listener: (context, state) {
         if(state is YourPostPostSucssessfullStateStates){
           setState(() {
             post = CubitYourPost.get(context).post;

           });
         }
         if(state is YourOpenQuestionPostSucssessfullStateStates){
          setState(() {
            openQuestion = CubitYourPost.get(context).openQuestion;
          });

         }


        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top:60),
            child: Container(
              color: AppColor.backgroundColor,
              width: double.infinity,
              height:double.infinity ,
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
                              child:imageNetwork!=null?Image.network(imageNetwork!, fit: BoxFit.cover,
                                height: 80,
                                width: 80,): Image.asset(
                                imageCope!,
                                fit: BoxFit.cover,
                                height: 80,
                                width: 80,
                              ),
                            ),
                            SizedBox(height: AppFontStyles.aboutMe,),
                            Text(
                              name!.isEmpty?"":name!,
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
                                gender!.isEmpty?"":gender!,
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
                               location!.isEmpty?"":location!,
                                style: TextStyle(
                                  fontSize: AppFontStyles.aboutMe,
                                  color: AppColor.fontColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                number!.isEmpty?"":number!,
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
                                post.clear();
                                                            }
                              CubitYourPost.get(context).getPost();

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
                                openQuestion.clear();

                              }
                              CubitYourPost.get(context).getOpenQuestion();

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

                    ],
                  ),
                  if(!(clickOpenQuestion||clickPosting))
                    Expanded(child: Center(child: Image.asset("assets/images/Illustrasi.png"))),
                  if (clickPosting)
                    Expanded(
                      child: ConditionalBuilder(
                        condition: state is! YourPostPostLoadStateStates ,
                        builder: (context) => ListOfPostingUser(
                          post: post,

                        ),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(
                            color: AppColor.orangeColor,
                          ),
                        ),
                      ),
                    ),
                  if (clickOpenQuestion)
                    Expanded(
                      child: ConditionalBuilder(
                        condition:state is !YourOpenQuestionPostLoadStateStates ,
                        builder: (context) =>ListOfOpenQuestionUser(
                          openQuestionPost: openQuestion,

                        ),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(
                            color: AppColor.orangeColor,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
