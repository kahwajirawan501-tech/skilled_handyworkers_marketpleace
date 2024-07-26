import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/commintSceren.dart';
import 'package:skilled_handyworkers_marketpleace/EditPost/EditPost.dart';
import 'package:skilled_handyworkers_marketpleace/EditPost/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/InformationCustomerOne/information.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/postModel.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class ListOfPostingUser extends StatefulWidget {
  final List<Map<String, dynamic>> post;

  const ListOfPostingUser({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<ListOfPostingUser> createState() => _ListOfPostingUserState();
}

class _ListOfPostingUserState extends State<ListOfPostingUser> {
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
                    navigateTo(widget: EditPost(id:id),context: context);
                    EditPostCubit.get(context).getInformationForPost(id);

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
          condition: state is !DeletePostLoadStateStates,
          builder: (context) {
            if (widget.post.isEmpty && ( state is YourPostPostSucssessfullStateStates ||state is YourOpenQuestionPostSucssessfullStateStates)) {
              return const Center(
                child: Text(
                  'No post yet.',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              );
            } else {
              return Container(
                color: AppColor.backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.aboutMe),
                  child: ListView.separated(
                    itemBuilder: (context, index) => PostModel(
                      postText: widget.post[index]['text'],
                      imagePaths: widget.post[index]['images'],
                      imagePath: widget.post[index]['user']['profileImage'] ?? imageCope,

                      name: widget.post[index]['user']['fullName'],
                      numberOfCommit: "67",
                      time: widget.post[index]['publishedAt'],
                      onPressedForCommit: () {
    navigateTo(context: context, widget: CommitScreen(idPost: widget.post[index]['_id'], typePost: "post"));
                      },
                      onPressedForFavorit: () {},
                      onTapImage: () {
                        if(widget.post[index]['user']['_id'] != id) {
                          navigateTo(context: context,widget: Information(idCustomer: widget.post[index]['user']['_id']));
                        }

                      },
                      videoUrl: widget.post[index]['videos'],
                      onPressed: () {
                        _showOptions(widget.post[index]['_id']);
                      },
                      deleteAndEdit: widget.post[index]['user']['_id'] == id ? true : false,
                    ),
                    separatorBuilder: (context, index) => const SizedBox(height: AppFontStyles.aboutMe),
                    itemCount: widget.post.length,
                  ),
                ),
              );
            }
          },
          fallback: (context) => Center(child: CircularProgressIndicator(color: AppColor.orangeColor,)),);
      },
    );
  }
}
