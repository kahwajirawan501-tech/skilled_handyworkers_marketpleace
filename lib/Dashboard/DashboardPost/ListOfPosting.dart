import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/commintSceren.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/cubit/state.dart';

import 'package:skilled_handyworkers_marketpleace/InformationCustomerOne/information.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/postModel.dart';

import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class ListOfPosting extends StatefulWidget {
  final List<Map<String, dynamic>> post;

  const ListOfPosting({
    Key? key,
    required this.post,


  }) : super(key: key);

  @override
  State<ListOfPosting> createState() => _ListOfPostingState();
}

class _ListOfPostingState extends State<ListOfPosting> {
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
      listener:(context, state) {
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
                itemCount: widget.post.length+ (isEndOfList ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == widget.post.length) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          color: AppColor.orangeColor,
                        ),
                      ),
                    );
                  }

                  return  PostModel(
                    imagePaths: widget.post[index]['images'],
                    postText: widget.post[index]['text'],
                    imagePath: widget.post[index]['user']['profileImage'] ?? imageCope,

                    name: widget.post[index]['user']['fullName'],
                    numberOfCommit: "",
                    time: widget.post[index]['createdAt'],
                    onPressedForCommit: () {
                      navigateTo(context: context, widget: CommitScreen(idPost: widget.post[index]['_id'], typePost: "post"));
                    },
                    onPressedForFavorit: () {

                    },
                    colorsFavorit:Colors.transparent,//
                    // widget.post[index]['isSaved']?Colors.red:Colors.grey
                    onTapImage: () {
                        navigateTo(context: context,widget: Information(idCustomer:widget.post[index]['user']['_id']));

                    },
                    videoUrl: widget.post[index]['videos'],
                    onPressed: () {
                      _showOptions(widget.post[index]['_id']);
                    },
                    deleteAndEdit:  true, // post[index]['postAuthor']['id'] == id ? true : false
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
