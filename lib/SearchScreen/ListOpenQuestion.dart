import 'package:flutter/material.dart';
import 'package:skilled_handyworkers_marketpleace/EditPost/EditOpenQuestion.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/OpenQuestionModel.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class ListOfOpenQuestion extends StatelessWidget {
  final List<Map<String, dynamic>> openQuestionPost;
  final ScrollController scrollController;
  final bool hasMoreData;

  const ListOfOpenQuestion({
    Key? key,
    required this.openQuestionPost,
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
                    navigateTo(widget: EditOpenQuestion(id:id),context: context);
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    return openQuestionPost.isEmpty
        ? const Center(
      child: Text(
        'No open questions yet.',
        style: TextStyle(color: Colors.grey, fontSize: 16),
      ),
    )
        : ListView.builder(
      controller: scrollController,
      itemCount: openQuestionPost.length + 1,
      itemBuilder: (context, index) {
        if (index == openQuestionPost.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: hasMoreData
                  ? CircularProgressIndicator()
                  : Text('No more data'),
            ),
          );
        }
        return OpenQuestionModel(
          time: openQuestionPost[index]['publishedAt'],
          numberOfCommit: "78",
          name: openQuestionPost[index]['user']['fullName'],
          imagePath: openQuestionPost[index]['user']['profileImage'] ?? "assets/images/aboutmy.png",
          openQuestion: openQuestionPost[index]['text'],
          onTapImage: () {},
          onPressedForCommit: () {
            // navigateTo(context: context, widget: CommitScreen(idPost: openQuestionPost[index]['postId'], typePost: "openQuestion"));
          },
          onPressedForFavorit: () {},
          deleteAndEdit:  openQuestionPost[index]['user']['_id'] == id ? true : false, //
          onPressed: () {
             _showOptions(openQuestionPost[index]['user']['_id']);
          },
        );
      },
    );
  }
}
