import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/BottonNavigationBar.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/commintSceren.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/OpenQuestionModel.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/postModel.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class ListOfOpenQuestion extends StatefulWidget {
  final List<Map<String, dynamic>>? openQuestionPost;

  const ListOfOpenQuestion({Key? key, required this.openQuestionPost}) : super(key: key);

  @override
  State<ListOfOpenQuestion> createState() => _ListOfOpenQuestionState();
}

class _ListOfOpenQuestionState extends State<ListOfOpenQuestion> {
  void _showOptions(int id) {
    showModalBottomSheet(
      backgroundColor: AppColor.backgroundColor,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.delete, color: AppColor.orangeColor),
                title:
                Text("Delete", style: TextStyle(color: AppColor.bluColor)),
                onTap: () {
                  Navigator.pop(context);
                  // CubitYourPost.get(context).deletePost(id);
                },
              ),
              ListTile(
                leading: Icon(Icons.edit, color: AppColor.orangeColor),
                title: Text("Edit", style: TextStyle(color: AppColor.bluColor)),
                onTap: () {

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
    return Scaffold(
      body: Container(
        color: AppColor.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(AppFontStyles.aboutMe),
          child: ListView.separated(
              itemBuilder: (context, index) =>
                  OpenQuestionModel(
                    time:widget.openQuestionPost![index]['publishedAt'],
                    numberOfCommit:"78" ,//widget.openQuestionPost![index]['numberOfCommit']
                    name: widget.openQuestionPost![index]['user']['fullName'],
                    imagePath:widget.openQuestionPost![index]['user']['profileImage'] ?? "assets/images/aboutmy.png",
                    openQuestion:widget.openQuestionPost![index]['text'],
                    onTapImage: () {

                    },
                    onPressedForCommit:(){

                    //  navigateTo(context: context,widget: CommitScreen(idPost:widget.openQuestionPost![index]['postId'],typePost: "openQuestion",)) ;

                    },
                    onPressedForFavorit: (){

                    },
                    deleteAndEdit:true,//widget.openQuestionPost![index]['postAuthor']['id']==id?true :false,
                    onPressed: () {
                    //  _showOptions(widget.openQuestionPost![index]['postId']);

                    },

                  ),
              separatorBuilder: (context, index) => SizedBox(height: AppFontStyles.descriptionLoginFontSize,),
              itemCount:widget.openQuestionPost!.length),
        ),
      ),
    );
  }
}
