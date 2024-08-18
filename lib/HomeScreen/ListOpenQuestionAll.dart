import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/commintSceren.dart';

import 'package:skilled_handyworkers_marketpleace/InformationCustomerOne/information.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/OpenQuestionModel.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/cubit.dart';

import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';

import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class ListOfOpenQuestionAll extends StatefulWidget {
  final List<Map<String, dynamic>> openQuestionPost;



  const ListOfOpenQuestionAll({
    Key? key, required this.openQuestionPost,

  }) : super(key: key);

  @override
  State<ListOfOpenQuestionAll> createState() => _ListOfOpenQuestionAllState();
}

class _ListOfOpenQuestionAllState extends State<ListOfOpenQuestionAll> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        bool isEndOfList = false;
        if (state is PostSucssessfullStateStatesOpenQuestion ) {
          isEndOfList = HomeCubit.get(context).hasMoreDataOpenQuestion;
        }


        return Container(
          color: AppColor.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(AppFontStyles.aboutMe),
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (isEndOfList &&
                    scrollInfo is ScrollEndNotification &&
                    scrollInfo.metrics.extentAfter == 0) {

                  HomeCubit.get(context).getPostForLocationAndServiceNextOpenQuestion(HomeCubit.get(context).currentPageOpenQuestion);
                }
                return false;
              },
              child: ListView.builder(

                itemCount: widget.openQuestionPost.length + (isEndOfList ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == widget.openQuestionPost.length) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          color: AppColor.orangeColor,
                        ),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: OpenQuestionModel(
                      time: widget.openQuestionPost[index]['createdAt'],
                      numberOfCommit: "",
                      name: widget.openQuestionPost[index]['user']['fullName'],
                      imagePath: widget.openQuestionPost[index]['user']['profileImage'] ?? imageCope,
                      openQuestion: widget.openQuestionPost[index]['text'],
                      onTapImage: () {
                        navigateTo(context: context,widget: Information(idCustomer: widget.openQuestionPost[index]['user']['_id']));

                      },
                      onPressedForCommit: () {
                        navigateTo(context: context, widget: CommitScreen(idPost:widget.openQuestionPost[index]['_id'], typePost: "openQuestion"));
                      },
                      onPressedForFavorit: () {
                        setState(() {
                          if(widget.openQuestionPost[index]['isSaved']){
                            CubitYourPost.get(context).unSavePost(widget.openQuestionPost[index]['_id']);
                            widget.openQuestionPost[index]['isSaved']=false;
                          }
                          else if(!widget.openQuestionPost[index]['isSaved']){
                            CubitYourPost.get(context).savePost(widget.openQuestionPost[index]['_id']);
                            widget.openQuestionPost[index]['isSaved']=true;
                          }
                        });
                      },
                      colorsFavorit: widget.openQuestionPost[index]['isSaved']?Colors.red:Colors.grey,//
                      // widget.openQuestionPost[index]['isSaved']?Colors.red:Colors.grey
                      deleteAndEdit: false, // Decide whether to show delete and edit buttons
                      onPressed: () {
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
