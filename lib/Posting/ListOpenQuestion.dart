import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/BottonNavigationBar.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/commintSceren.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/OpenQuestionModel.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/postModel.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class ListOfOpenQuestion extends StatefulWidget {
  final List<Map<String, dynamic>>? openQuestionPost;

  const ListOfOpenQuestion({Key? key, required this.openQuestionPost}) : super(key: key);

  @override
  State<ListOfOpenQuestion> createState() => _ListOfOpenQuestionState();
}

class _ListOfOpenQuestionState extends State<ListOfOpenQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(AppFontStyles.aboutMe),
          child: ListView.separated(
              itemBuilder: (context, index) =>
                  OpenQuestionModel(
                    time:widget.openQuestionPost![index]['time'],
                    numberOfCommit: widget.openQuestionPost![index]['numberOfCommit'],
                    name: widget.openQuestionPost![index]['postAuthor']['name'],
                    imagePath:widget.openQuestionPost![index]['postAuthor']['profileImage'],
                    openQuestion:widget.openQuestionPost![index]['postContent'],
                    onTapImage: () {

                    },
                    onPressedForCommit:(){

                      navigateTo(context: context,widget: CommitScreen(idPost:widget.openQuestionPost![index]['postId'],typePost: "openQuestion",)) ;

                    },
                    onPressedForFavorit: (){

                    },

                  ),
              separatorBuilder: (context, index) => SizedBox(height: AppFontStyles.descriptionLoginFontSize,),
              itemCount:widget.openQuestionPost!.length),
        ),
      ),
    );
  }
}
