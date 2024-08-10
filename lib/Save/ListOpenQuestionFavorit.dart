import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/commintSceren.dart';
import 'package:skilled_handyworkers_marketpleace/EditPost/EditOpenQuestion.dart';
import 'package:skilled_handyworkers_marketpleace/InformationCustomerOne/information.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/OpenQuestionModel.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class ListOfOpenQuestionFavorit extends StatefulWidget {
  final List<Map<String, dynamic>> openQuestionPost;


  const ListOfOpenQuestionFavorit({
    Key? key,
    required this.openQuestionPost,

  }) : super(key: key);

  @override
  State<ListOfOpenQuestionFavorit> createState() => _ListOfOpenQuestionFavoritState();
}

class _ListOfOpenQuestionFavoritState extends State<ListOfOpenQuestionFavorit> {
  bool favor=true;
  @override
  Widget build(BuildContext context) {

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
                    CubitYourPost.get(context).deletePost(id);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.edit, color: AppColor.orangeColor),
                  title: Text("Edit", style: TextStyle(color: AppColor.bluColor)),
                  onTap: () {
                    Navigator.pop(context);
                    navigateTo(widget: EditOpenQuestion(id:id),context: context);
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    return BlocConsumer<CubitYourPost, YourPostStates>(
      listener: (context, state) {
        if(state is DeletePostSucssessfullStateStates){

          showToast(text:"The post has been delete successfully \n", state: ToastStates.EROOR);

        }
        else if(state is DeletePostErrorStateStates){
          showToast(text:"The post hasn't been delete successfully \n", state: ToastStates.EROOR);

        }

      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: (state is !DeletePostLoadStateStates


          ),
          builder: (context) {
            print(widget.openQuestionPost);
            if (widget.openQuestionPost.isEmpty
                )
            {
              return   Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/Illustrationn.png"),
                    SizedBox(height: 24,),
                    Text("Not openQuestion Yet",style: TextStyle(color: AppColor.posting),)
                  ],
                ),
              );
            } else {
              return Container(
                color: AppColor.backgroundColor,

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.aboutMe),
                  child: ListView.separated(
                      itemBuilder: (context, index) => OpenQuestionModel(
                        time: widget.openQuestionPost[index]['createdAt'],
                        numberOfCommit: "",
                        name: widget.openQuestionPost[index]['user']['fullName'],
                        imagePath: widget.openQuestionPost[index]['user']['profileImage'] ?? imageCope,
                        openQuestion: widget.openQuestionPost[index]['text'],
                        onTapImage: () {
                          if( widget.openQuestionPost[index]['user']['_id'] != id) {
                            navigateTo(context: context,widget: Information(idCustomer: widget.openQuestionPost[index]['user']['_id']));
                          }
                        },
                        onPressedForCommit: () {
                          navigateTo(context: context, widget: CommitScreen(idPost: widget.openQuestionPost[index]['_id'], typePost: "openQuestion"));
                        },
                        onPressed: () {
                          _showOptions(widget.openQuestionPost[index]['_id']);
                        },
                        deleteAndEdit: widget.openQuestionPost[index]['user']['_id'] == id ? true : false,
                        onPressedForFavorit: () {
                          setState(() {

                            if(favor){
                              CubitYourPost.get(context).unSavePost(widget.openQuestionPost[index]['_id']);
                              if(state is UnSaveErrorFavoritesDateState){
                                favor=true;
                              }
                              favor=false;
                            }

                          });

                        },

                        colorsFavorit:favor?Colors.red:Colors.grey,
                        //widget.openQuestionPost[index]['isSaved']?Colors.red:Colors.grey
                      ),
                      separatorBuilder: (context, index) => SizedBox(height: AppFontStyles.aboutMe,),
                      itemCount: widget.openQuestionPost.length),
                ),
              );
            }
          },
          fallback: (context) => Center(child: CircularProgressIndicator(color: AppColor.orangeColor,)),);
      },
    );
  }
}
