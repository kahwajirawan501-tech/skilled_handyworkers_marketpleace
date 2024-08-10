import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/ListOfPostForUser.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/ListOpenQuestionForUser.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/informationCustomer.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/imageView.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profilrTile.dart';
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

  bool clickPosting=true;
  bool clickOpenQuestion=false;
  List<Map<String, dynamic>> post = [];
  List<Map<String, dynamic>> openQuestion = [];



  @override
  void initState() {
    super.initState();
      CubitYourPost.get(context).getPost();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor:  AppColor.backgroundColor,
        actions: [
          TextButton(onPressed:() {
            navigateTo(context: context,widget: InformationCustomer());

          }, child:Text("See More",style:TextStyle(
              fontSize: AppFontStyles.descriptionLoginFontSize,
              fontWeight: AppFontStyles.fontWeightBold,
              color: AppColor.bottomNavigationBar
          ) ,))

        ],
        elevation: 0.0,
        backgroundColor: AppColor.backgroundColor,
      ),
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
          return Container(
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
                        Container(width: double.infinity,height: 40,color: AppColor.backgroundColor,),
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
                          GestureDetector(
                            onTap: () {
                              if (imageNetwork != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImageScreen(
                                      imageUrl: api + imageNetwork!,
                                    ),
                                  ),
                                );
                              } else if (imageCope != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImageScreen(
                                      imageUrl: imageCope!,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: ClipOval(
                              child:imageNetwork!.isNotEmpty?Image.network(api+imageNetwork!, fit: BoxFit.cover,
                                height: 90,
                                width: 90,): Image.asset(
                                imageCope!,
                                fit: BoxFit.cover,
                                height: 90,
                                width: 90,
                              ),
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
                    // Positioned(
                    //   bottom:0,
                    //   left: 0,
                    //   right: 0,// Adjust this value to move the circle image vertically
                    //   child:Padding(
                    //     padding: const EdgeInsets.all(AppFontStyles.padding),
                    //     child: Row(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           email!.isEmpty?"":email!,
                    //           style: TextStyle(
                    //             fontSize: AppFontStyles.aboutMe,
                    //             color: AppColor.fontColor,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),


                Padding(
                  padding: const EdgeInsets.only(top: 16,bottom: 8),
                  child: Row(
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
                ),

                // if(!(clickOpenQuestion||clickPosting))
                //   Expanded(child: Center(child: Image.asset("assets/images/Illustrasi.png"))),
                if (clickPosting)
                  Expanded(
                    child: ConditionalBuilder(
                      condition: state is! YourPostPostLoadStateStates ,
                      builder: (context) =>(state is YourPostPostErrorStateStates)?Center(
                        child:  GestureDetector(
                            onTap: () {
                              CubitYourPost.get(context).getPost();
                            },
                            child: Icon(Icons.refresh_outlined,color:AppColor.orangeColor,size: 50,)),
                      ): ListOfPostingUser(
                        post: post,

                      ),
                      fallback: (context) =>

                      Center(
                        child: CircularProgressIndicator(
                          color: AppColor.orangeColor,
                        ),
                      )
                    ),
                  ),
                if (clickOpenQuestion)
                  Expanded(
                    child: ConditionalBuilder(
                      condition:state is !YourOpenQuestionPostLoadStateStates ,
                      builder: (context) =>(state is YourOpenQuestionPostErrorStateStates)?   Center(
                        child:  GestureDetector(
                            onTap: () {
                              CubitYourPost.get(context).getOpenQuestion();
                            },
                            child: Icon(Icons.refresh_outlined,color:AppColor.orangeColor,size: 50,)),
                      ):ListOfOpenQuestionUser(
                        openQuestionPost: openQuestion,

                      ),
                        fallback: (context) =>

                        Center(
                          child: CircularProgressIndicator(
                            color: AppColor.orangeColor,
                          ),
                        ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
