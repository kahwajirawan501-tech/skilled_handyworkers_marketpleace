import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class CommitScreen extends StatefulWidget {
  final int id;
  const CommitScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<CommitScreen> createState() => _CommitScreenState();
}

class _CommitScreenState extends State<CommitScreen> {
  final _commentController = TextEditingController();
  bool _isReplying = false;
  int _replyIndex = -1;

  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      if (_isReplying && _replyIndex != -1) {
        CommitCubit.get(context).addReply(_replyIndex, _commentController.text);
      } else {
        CommitCubit.get(context).addComment(_commentController.text);
      }
      _commentController.clear();
      setState(() {
        _isReplying = false;
        _replyIndex = -1;
      });
    }
  }

  void _replyToComment(int index, int commentId) {
    setState(() {
      _isReplying = true;
      _replyIndex = index;
      _commentController.text = "Replying to: ${CommitCubit.get(context).commentsPost[index]['content']}";
    });
  }

  String _formatDate(String date) {
    final DateTime dateTime = DateTime.parse(date);
    return "${dateTime.hour}:${dateTime.minute} - ${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  @override
  void initState() {
    super.initState();
    CommitCubit.get(context).getCommit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        surfaceTintColor: AppColor.backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.arrowBackColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocConsumer<CommitCubit, CommitStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            color: AppColor.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(AppFontStyles.aboutMe),
              child: Column(
                children: [
                  Expanded(
                    child: ConditionalBuilder(
                      condition: CommitCubit.get(context).commentsPost.isNotEmpty,
                      builder: (context) => CommitCubit.get(context).commentsPost.isEmpty
                          ? const Center(
                        child: Text(
                          'No comments yet. Be the first to comment!',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                          : ListView.builder(
                        itemCount: CommitCubit.get(context).commentsPost.length,
                        itemBuilder: (context, index) {
                          final comment = CommitCubit.get(context).commentsPost[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipOval(
                                    child: Image.asset(
                                      comment['author']['profileImage'],
                                      fit: BoxFit.cover,
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        constraints: const BoxConstraints(maxWidth: 270, minWidth: 217),
                                        padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.aboutMe, vertical: 12),
                                        decoration: BoxDecoration(
                                          color: AppColor.orangeColor.withOpacity(0.1),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30),
                                            bottomRight: Radius.circular(30),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              comment['author']['name'],
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(comment['content']),
                                            const SizedBox(height: 5),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            _formatDate(comment['time']),
                                            style: const TextStyle(color: Colors.grey, fontSize: AppFontStyles.soSmallFontSize),
                                          ),
                                          const SizedBox(width: AppFontStyles.aboutMe),
                                          GestureDetector(
                                            onTap: () {
                                              _replyToComment(index, comment['id']);
                                            },
                                            child: Text(
                                              'Reply',
                                              style: TextStyle(color: AppColor.orangeColor, fontSize: AppFontStyles.descriptionLoginFontSize),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ...(comment['replies'] as List<Map<String, dynamic>>).map((reply) {
                                            return Row(
                                              children: [
                                                ClipOval(
                                                  child: Image.asset(
                                                    reply['author']['profileImage'],
                                                    fit: BoxFit.cover,
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      constraints: const BoxConstraints(maxWidth: 270, minWidth: 217),
                                                      padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.aboutMe, vertical: 12),
                                                      decoration: BoxDecoration(
                                                        color: AppColor.navyBlueColor.withOpacity(0.1),
                                                        borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(30),
                                                          topRight: Radius.circular(30),
                                                          bottomRight: Radius.circular(30),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            reply['author']['name'],
                                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          const SizedBox(height: 5),
                                                          Text(reply['content']),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          _formatDate(reply['time']),
                                                          style: const TextStyle(color: Colors.grey, fontSize: AppFontStyles.soSmallFontSize),
                                                        ),
                                                        const SizedBox(width: AppFontStyles.aboutMe),
                                                        GestureDetector(
                                                          onTap: () {
                                                            _replyToComment(index, comment['id']);
                                                          },
                                                          child: Text(
                                                            'Reply',
                                                            style: TextStyle(color: AppColor.orangeColor, fontSize: AppFontStyles.descriptionLoginFontSize),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          }).toList(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppFontStyles.padding),
                            ],
                          );
                        },
                      ),
                      fallback: (context) => Center(child: CircularProgressIndicator(color: AppColor.orangeColor)),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: AppColor.grayColorFont, fontSize: AppFontStyles.descriptionLoginFontSize),
                            hintText: _isReplying ? 'Write your reply...' : 'Write your message...',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.navyBlueColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: _addComment,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
