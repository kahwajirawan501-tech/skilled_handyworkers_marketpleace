import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/BottonNavigationBar.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/commintSceren.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/postModel.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class ListOfPosting extends StatefulWidget {
 final  List<Map<String, dynamic>>?post;
  const ListOfPosting({Key? key, required this.post
    }) : super(key: key);

  @override
  State<ListOfPosting> createState() => _ListOfPostingState();
}

class _ListOfPostingState extends State<ListOfPosting> {
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
    return BlocConsumer<CubitYourPost,YourPostStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
       return Scaffold(
          body: Container(
            color: AppColor.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(AppFontStyles.aboutMe),
              child: ListView.separated(
                  itemBuilder: (context, index) => GestureDetector(

                    child: PostModel(
                      imagePaths:widget.post![index]['images'],
                      imagePath:widget.post![index]['user']['profileImage']=="assets/images/aboutmy.png"?"assets/images/aboutmy.png":widget.post![index]['user']['profileImage'],//widget.post![index]['postAuthor']['profileImage']
                      name:widget.post![index]['user']['fullName'],
                      numberOfCommit: "67" ,//widget.post![index]['numberOfCommit']
                      time:widget.post![index]['publishedAt'],//widget.post![index]['time']
                      onPressedForCommit:(){

                        //navigateTo(context: context,widget: CommitScreen(idPost:widget.post![index]['postId'],typePost: "post",)) ;
                      },
                      onPressedForFavorit:(){

                      },
                      onTapImage:(){

                      },
                      videoUrl:widget.post![index]['videos'],
                      onPressed: () {
                     //   _showOptions(widget.post![index]['postId']);

                      },
                      deleteAndEdit:true,//widget.post![index]['postAuthor']['id']==id?true :false
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: AppFontStyles.descriptionLoginFontSize,),
                  itemCount: widget.post!.length),
            ),
          ),
        );
      },

    );
  }
}
