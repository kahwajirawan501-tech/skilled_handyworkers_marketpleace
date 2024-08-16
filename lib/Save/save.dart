import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/Save/ListOpenQuestionFavorit.dart';
import 'package:skilled_handyworkers_marketpleace/Save/ListPostFavorite.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class Save extends StatefulWidget {
  const Save({Key? key}) : super(key: key);

  @override
  State<Save> createState() => _SaveState();
}

class _SaveState extends State<Save> {
  bool clickPosting=true;
  bool clickOpenQuestion=false;
  List<Map<String, dynamic>> post = [];
  List<Map<String, dynamic>> openQuestion = [];

  @override
  void initState() {
    super.initState();

     CubitYourPost.get(context).getFavorites();
  }
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<CubitYourPost,YourPostStates>(
      listener: (context, state) {
        if(state is SuccessGetFavoritesDateState){
          setState(() {
            post = CubitYourPost.get(context).favoritesPost;
            openQuestion=CubitYourPost.get(context).favoritesOpenQuestion;

          });
        }
      },
      builder: (context, state) {
        return  Scaffold(
          appBar: AppBar(
            surfaceTintColor: AppColor.backgroundColor,
            backgroundColor: AppColor.backgroundColor,
            title: Text("328".tr,style: TextStyle
              (fontSize:AppFontStyles.borderRadius ,fontWeight: AppFontStyles.fontWeightBold,color: AppColor.bluColor),),
            centerTitle: true,

          ),
          body: Container(
            color: AppColor.backgroundColor,
            width: double.infinity,
            height:double.infinity ,
            child:Column(
          children: [
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
                        CubitYourPost.get(context).getFavorites();

                      });

                    },
                    child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                          color: clickPosting?AppColor.orangeColor:Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Text("103".tr,style: TextStyle(color:clickPosting?Colors.white:AppColor.bluColor ),)
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
                        CubitYourPost.get(context).getFavorites();

                      });


                    },
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                          color:clickOpenQuestion?AppColor.orangeColor:Colors.white,
                        ),
                        child: Text("104".tr,style: TextStyle(color:clickOpenQuestion?Colors.white:AppColor.bluColor ))
                    ),
                  ), height: 40, borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(width: AppFontStyles.aboutMe,),

              ],
            ),
          ),
            if (clickPosting)
              Expanded(
                child: ConditionalBuilder(
                  condition:state is! LoadingGetFavoritesDateState  ,//state is! LoadingGetFavoritesDateState
                  builder: (context) =>state is ErrorGetFavoritesDateState?Center(child:
                  GestureDetector(
                      onTap: () {
                        CubitYourPost.get(context).getFavorites();
                      },
                      child: Icon(Icons.refresh_outlined,color:AppColor.orangeColor,size: 50,)),): ListOfPostingFavorit(
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
                  condition: state is !LoadingGetFavoritesDateState,//state is !LoadingGetFavoritesDateState
                  builder: (context) =>state is ErrorGetFavoritesDateState?Center(child:
                  GestureDetector(
                      onTap: () {
                        CubitYourPost.get(context).getFavorites();
                      },
                      child: Icon(Icons.refresh_outlined,color:AppColor.orangeColor,size: 50,)),):ListOfOpenQuestionFavorit(
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
            ) ,
          ),
        );
      },
    );
  }
}
