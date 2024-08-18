import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/commintSceren.dart';


import 'package:skilled_handyworkers_marketpleace/InformationCustomerOne/information.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/postModel.dart';

import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class ListOfPostingAll extends StatefulWidget {
  final List<Map<String, dynamic>> post;

  const ListOfPostingAll({
    Key? key,
    required this.post,


  }) : super(key: key);

  @override
  State<ListOfPostingAll> createState() => _ListOfPostingAllState();
}

class _ListOfPostingAllState extends State<ListOfPostingAll> {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HomeCubit, HomeStates>(
      listener:(context, state) {

      },
      builder: (context, state) {
        bool isEndOfList = false;
        if (state is PostSucssessfullStateStates ) {
          isEndOfList = HomeCubit.get(context).hasMoreData;
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
                  HomeCubit.get(context).getPostForLocationAndServiceNext(HomeCubit.get(context).currentPage);
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

                  return  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: PostModel(
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
                        setState(() {
                          if(widget.post[index]['isSaved']){
                            CubitYourPost.get(context).unSavePost(widget.post[index]['_id']);
                            widget.post[index]['isSaved']=false;
                          }
                          else if(!widget.post[index]['isSaved']){
                            CubitYourPost.get(context).savePost(widget.post[index]['_id']);
                            widget.post[index]['isSaved']=true;
                          }
                        });
                      },
                      colorsFavorit:widget.post[index]['isSaved']?Colors.red:Colors.grey,//
                      onTapImage: () {
                        navigateTo(context: context,widget: Information(idCustomer:widget.post[index]['user']['_id']));

                      },
                      videoUrl: widget.post[index]['videos'],
                      onPressed: () {
                       // _showOptions(widget.post[index]['_id']);
                      },
                      deleteAndEdit:  false, // post[index]['postAuthor']['id'] == id ? true : false
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
