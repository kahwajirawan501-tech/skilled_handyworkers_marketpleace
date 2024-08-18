import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/HomeScreen/ListOpenQuestionAll.dart';
import 'package:skilled_handyworkers_marketpleace/HomeScreen/ListPostAll.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';

import '../shared/styles/styles.dart';

class AllOpenQuestion extends StatefulWidget {

  const AllOpenQuestion({Key? key}) : super(key: key);

  @override
  State<AllOpenQuestion> createState() => _AllOpenQuestionState();
}

class _AllOpenQuestionState extends State<AllOpenQuestion> {
  bool clickPosting = true;
  bool clickOpenQuestion = false;
  List<Map<String, dynamic>> openQuestion = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {
        if (state is PostSucssessfullStateStatesOpenQuestion) {
          setState(() {

            openQuestion = HomeCubit.get(context).openQuestionPost;

          });
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              surfaceTintColor:  AppColor.backgroundColor,
              elevation: 0.0,
              backgroundColor: AppColor.backgroundColor,
              centerTitle: true,
              title: Text("352".tr.tr,style: TextStyle(
                  color: Colors.black,fontSize: AppFontStyles.borderRadius,
                  fontWeight: AppFontStyles.fontWeightBold
              ),),


            ),
            body:Container(
              color: AppColor.backgroundColor,
              child: Column(
                children: [
                  Expanded(
                    child: ConditionalBuilder(
                      condition:(
                          state is! PostLoadStateStatesOpenQuestion),
                      builder: (context) =>  openQuestion.isEmpty?
                      Center(
                        child: Text(
                          '116'.tr,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                          :ListOfOpenQuestionAll(
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
            )
        );
      },
    );
  }
}
