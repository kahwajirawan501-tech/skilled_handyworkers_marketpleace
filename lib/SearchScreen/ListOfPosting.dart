import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/EditPost/EditPost.dart';
import 'package:skilled_handyworkers_marketpleace/EditPost/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/postModel.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class ListOfPosting extends StatelessWidget {
  final List<Map<String, dynamic>> post;
  final ScrollController scrollController;
  final bool hasMoreData;

  const ListOfPosting({
    Key? key,
    required this.post,
    required this.scrollController,
    required this.hasMoreData,
  }) : super(key: key);

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


    return post.isEmpty
        ? const Center(
      child: Text(
        'No post yet.',
        style: TextStyle(color: Colors.grey, fontSize: 16),
      ),
    )
        :  Container(
      color: AppColor.backgroundColor,

          child: Padding(
            padding: const EdgeInsets.all(AppFontStyles.aboutMe),

            child: ListView.builder(
                  controller: scrollController,
                  itemCount: post.length + (hasMoreData ? 1 : 0),
                  itemBuilder: (context, index) {
            if (index == post.length) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: hasMoreData
                      ? CircularProgressIndicator()
                      : Text('No more data'),
                ),
              );
            }
            return PostModel(
              imagePaths: post[index]['images'],
              imagePath: post[index]['user']['profileImage'] == "assets/images/aboutmy.png"
                  ? "assets/images/aboutmy.png"
                  : post[index]['user']['profileImage'],
              name: post[index]['user']['fullName'],
              numberOfCommit: "67",
              time: post[index]['publishedAt'],
              onPressedForCommit: () {
                // navigateTo(context: context, widget: CommitScreen(idPost: post[index]['postId'], typePost: "post"));
              },
              onPressedForFavorit: () {},
              onTapImage: () {},
              videoUrl: post[index]['videos'],
              onPressed: () {
                 _showOptions(post[index]['_id']);
              },
              deleteAndEdit: post[index]['postAuthor']['_id'] == id ? true : false, // post[index]['postAuthor']['id'] == id ? true : false
            );
                  },
                ),
          ),
        );
  }
}
