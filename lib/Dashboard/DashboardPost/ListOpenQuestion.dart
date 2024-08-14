import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/commintSceren.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/cubit/state.dart';
import 'package:skilled_handyworkers_marketpleace/EditPost/EditOpenQuestion.dart';
import 'package:skilled_handyworkers_marketpleace/InformationCustomerOne/information.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/OpenQuestionModel.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/cubit.dart';

import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';

import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class ListOfOpenQuestion extends StatefulWidget {
  final List<Map<String, dynamic>> openQuestionPost;



  const ListOfOpenQuestion({
    Key? key, required this.openQuestionPost,

  }) : super(key: key);

  @override
  State<ListOfOpenQuestion> createState() => _ListOfOpenQuestionState();
}

class _ListOfOpenQuestionState extends State<ListOfOpenQuestion> {
  void _showOptions(String id) {
    showModalBottomSheet(
      backgroundColor: AppColor.backgroundColor,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.delete, color: AppColor.orangeColor),
                title: Text("Delete", style: TextStyle(color: AppColor.bluColor)),
                onTap: () {
                  Navigator.pop(context);
                  DashBoardCubit.get(context).deletePost(id);
                },
              ),

            ],
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashBoardCubit, DashBoardStates>(
      listener: (context, state) {
        if(state is DeletePostSucssessfullStateStatesSearch){

          showToast(text:"The post has been delete successfully \n", state: ToastStates.EROOR);
          DashBoardCubit.get(context).getPostForLocationAndService(DashBoardCubit.get(context).currentPage);

        }
        else if(state is DeletePostErrorStateStatesSearch){
          showToast(text:"The post hasn't been delete successfully \n", state: ToastStates.EROOR);

        }
      },
      builder: (context, state) {
        bool isEndOfList = false;
        if (state is PostSucssessfullStateStates ) {
          isEndOfList = DashBoardCubit.get(context).hasMoreData;
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

                 DashBoardCubit.get(context).getPostForLocationAndServiceNext(DashBoardCubit.get(context).currentPage);
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
                  return OpenQuestionModel(
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

                    },
                    colorsFavorit:Colors.transparent,//
                    // widget.openQuestionPost[index]['isSaved']?Colors.red:Colors.grey
                    deleteAndEdit: true, // Decide whether to show delete and edit buttons
                    onPressed: () {
                      _showOptions(widget.openQuestionPost[index]['_id']);
                    },
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
