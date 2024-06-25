import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/BottonNavigationBar.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/commintSceren.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/postModel.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class ListOfPosting extends StatefulWidget {
 final  List<Map<String, dynamic>>post;
  const ListOfPosting({Key? key, required this.post
    }) : super(key: key);

  @override
  State<ListOfPosting> createState() => _ListOfPostingState();
}

class _ListOfPostingState extends State<ListOfPosting> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(AppFontStyles.aboutMe),
          child: ListView.separated(
              itemBuilder: (context, index) => PostModel(
              imagePaths:widget.post[index]['postContent']['images'],
              imagePath:widget.post[index]['postAuthor']['profileImage'],
              name:widget.post[index]['postAuthor']['name'],
              numberOfCommit: widget.post[index]['numberOfCommit'] ,
              time:widget.post[index]['time'],
              onPressedForCommit:(){

                navigateTo(context: context,widget: CommitScreen(id:widget.post[index]['postId'])) ;
              },
              onPressedForFavorit:(){

              },
              onTapImage:(){

              },
              videoUrl:widget.post[index]['postContent']['video'],
              ),
              separatorBuilder: (context, index) => SizedBox(height: AppFontStyles.descriptionLoginFontSize,),
              itemCount: widget.post.length),
        ),
      ),
    );
  }
}
