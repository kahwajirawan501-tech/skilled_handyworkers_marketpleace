import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/commintSceren.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/ListOfPosting.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/ListOpenQuestion.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/states.dart';
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

  bool clickPosting=false;
  bool clickOpenQuestion=false;



  Future<void> _handleRefresh() async {
    CubitYourPost.get(context).changePageOpenQuestion();
  }
  Future<void> _handleRefreshPost() async {
    CubitYourPost.get(context).changePagePost();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CubitYourPost,YourPostStates>(
        listener: (context, state) {

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
                              child: Image.asset(
                                image!.isEmpty?"assets/images/aboutmy.png":image!,
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
                        //        CubitYourPost.get(context).getPost(1);
                              }
                              CubitYourPost.get(context).changePagePost();

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
                                // CubitYourPost.get(context).getPost(1);

                              }
                              CubitYourPost.get(context).changePageOpenQuestion();

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
                      condition: clickPosting && state is !YourPostPostLoadStateStates,
                      builder: (context) =>CubitYourPost.get(context).yourPost['post']!=null
                     ?RefreshIndicator(
                        onRefresh: _handleRefreshPost,
                          color: AppColor.orangeColor,
                          child: ListOfPosting(post: CubitYourPost.get(context).yourPost['post'],)):const Center(
                        child: Text(
                          'No post yet.',
                          style:
                          TextStyle(color: Colors.grey, fontSize: 16),
                        )),
                      //CubitYourPost.get(context).getPost(1);
                      fallback: (context) =>  Center(child: CircularProgressIndicator(color:AppColor.orangeColor,),),
                    ),),
                  if(clickOpenQuestion)

                    Expanded(child: ConditionalBuilder(
                      condition: clickOpenQuestion&& state is !YourPostPostLoadStateStates,
                      builder: (context) =>CubitYourPost.get(context).yourPost['OpenQuestion']!=null
                          ?RefreshIndicator(
                          color: AppColor.orangeColor,

                          onRefresh: _handleRefresh,
                          child: ListOfOpenQuestion(openQuestionPost: CubitYourPost.get(context).yourPost['OpenQuestion'],)):const Center(
                          child: Text(
                            'No post yet.',
                            style:
                            TextStyle(color: Colors.grey, fontSize: 16),
                          )),
                      fallback: (context) =>  Center(child: CircularProgressIndicator(color:AppColor.orangeColor,),),
                    ),),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
