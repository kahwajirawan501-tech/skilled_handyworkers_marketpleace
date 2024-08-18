import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/HomeScreen/ListPostAll.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';

import '../shared/styles/styles.dart';

class AllPost extends StatefulWidget {

  const AllPost({Key? key}) : super(key: key);

  @override
  State<AllPost> createState() => _AllPostState();
}

class _AllPostState extends State<AllPost> {
  bool clickPosting = true;
  bool clickOpenQuestion = false;
  List<Map<String, dynamic>> post = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
     listener: (context, state) {
       if (state is PostSucssessfullStateStates) {
         setState(() {

           post = HomeCubit.get(context).postList;

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
              title: Text("353".tr,style: TextStyle(
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
                          state is! PostLoadStateStates),
                      builder: (context) =>  post.isEmpty?
                      Center(
                        child: Text(
                          '113'.tr,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                          :ListOfPostingAll(
                        post: post,

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
