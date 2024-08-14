import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/DashboardPost/ListOfPosting.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/DashboardPost/ListOpenQuestion.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/cubit/state.dart';


import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class DashBoardPost extends StatefulWidget {
  const DashBoardPost({Key? key}) : super(key: key);
  @override
  State<DashBoardPost> createState() => _DashBoardPostState();
}

class _DashBoardPostState extends  State<DashBoardPost> {
  bool clickPosting = true;
  bool clickOpenQuestion = false;
  List<Map<String, dynamic>> post = [];
  List<Map<String, dynamic>> openQuestion = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColor.backgroundColor,
      surfaceTintColor:  AppColor.backgroundColor,
      elevation: 0.0,),
      body: BlocConsumer<DashBoardCubit, DashBoardStates>(
        listener: (context, state) {
          if (state is PostSucssessfullStateStates) {
            setState(() {

                post = DashBoardCubit.get(context).postList;
                openQuestion = DashBoardCubit.get(context).openQuestionPost;

            });
          }},
        builder: (context, state) {
          return Container(
            color: AppColor.backgroundColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppFontStyles.padding,
                      ),
                  child: Row(
                    children: [

                      Expanded(
                        child: Box(
                            widget: GestureDetector(
                              onTap: () {

                                  setState(() {
                                    clickPosting = !clickPosting;
                                    if (clickPosting) {
                                      clickOpenQuestion = false;
                                      post.clear();
                                      DashBoardCubit.get(context).currentPage=1;

                                    }
                                    DashBoardCubit.get(context).getPostForLocationAndService(DashBoardCubit.get(context).currentPage);


                                  });

                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: clickPosting
                                        ? AppColor.orangeColor
                                        : AppColor.comment,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "posting",
                                    style: TextStyle(
                                        color: clickPosting
                                            ? Colors.white
                                            : AppColor.bluColor),
                                  )),
                            ),
                            height: 40,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      SizedBox(width: AppFontStyles.aboutMe),
                      Expanded(
                        child: Box(
                            widget: GestureDetector(
                              onTap: () {

                                  setState(() {
                                    clickOpenQuestion = !clickOpenQuestion;
                                    if (clickOpenQuestion) {
                                      clickPosting = false;
                                      openQuestion.clear();
                                      DashBoardCubit.get(context).currentPage=1;

                                    }
                                    DashBoardCubit.get(context).getPostForLocationAndService(DashBoardCubit.get(context).currentPage);

                                  });

                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: clickOpenQuestion
                                        ? AppColor.orangeColor
                                        : AppColor.comment,
                                  ),
                                  child: Text(
                                    "open question",
                                    style: TextStyle(
                                        color: clickOpenQuestion
                                            ? Colors.white
                                            : AppColor.bluColor),
                                  )),
                            ),
                            height: 40,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  ),
                ),

                if (clickPosting)
                  Expanded(
                    child: ConditionalBuilder(
                      condition:(
                          state is! PostLoadStateStates),
                      builder: (context) =>  post.isEmpty?
                      Center(
                        child: Text(
                          'No open questions yet.',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                          :ListOfPosting(
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
                      condition:
                          state is! PostLoadStateStates,
                      builder: (context) =>
                      openQuestion.isEmpty?
                      Center(
                        child: Text(
                          'No open questions yet.',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                          :ListOfOpenQuestion(
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
          );
        },
      ),
    );
  }
}
