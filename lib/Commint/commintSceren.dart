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
  final List<Map<String, dynamic>> _comments = []; // Use dynamic for flexibility
  bool _isReplying = false;
  int _replyIndex = -1;

  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        if (_isReplying && _replyIndex != -1) {
          // Add reply
          (_comments[_replyIndex]['replies'] as List<Map<String, dynamic>>).add({
            'content': _commentController.text,
            'time': DateTime.now().toIso8601String(),
          });
        } else {
          // Add new comment
          _comments.add({
            'content': _commentController.text,
            'time': DateTime.now().toIso8601String(),
            'replies': <Map<String, dynamic>>[], // Initialize replies as empty list
          });
        }
        _commentController.clear();
        _isReplying = false;
        _replyIndex = -1;
      });
    }
  }

  void _replyToComment(int index) {
    setState(() {
      _isReplying = true;
      _replyIndex = index;
      _commentController.text = "Replying to: ${_comments[index]['content']}";
    });
  }

  String _formatDate(String date) {
    final DateTime dateTime = DateTime.parse(date);
    return "${dateTime.hour}:${dateTime.minute} - ${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        surfaceTintColor:AppColor.backgroundColor ,
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
      body: BlocConsumer<CommitCubit,CommitStates>(

        listener:(context, state) {

        },
        builder: (context, state) {
        //  CommitCubit.get(context).getCommitForPost(widget.id);
          return Container(
            color: AppColor.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(AppFontStyles.aboutMe),
              child: Column(
                children: [
                  Expanded(

                    child: _comments.isEmpty
                        ? const Center(
                      child: Text(
                        'No comments yet. Be the first to comment!',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                        : ListView.builder(
                      itemCount: _comments.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    "assets/images/Mask group.png",
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
                                            'User ${index + 1}',
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(_comments[index]['content']),
                                          const SizedBox(height: 5),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          _formatDate(_comments[index]['time']),
                                          style: const TextStyle(color: Colors.grey, fontSize: AppFontStyles.soSmallFontSize),
                                        ),
                                        const SizedBox(width: AppFontStyles.aboutMe),
                                        GestureDetector(
                                          onTap: () {
                                            _replyToComment(index);
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
                                        ...(_comments[index]['replies'] as List<Map<String, dynamic>>).map((reply) {
                                          return Row(
                                            children: [
                                              ClipOval(
                                                child: Image.asset(
                                                  "assets/images/Mask group.png",
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
                                                        const Text(
                                                          'User replied:',
                                                          style: TextStyle(fontWeight: FontWeight.bold),
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
                                                        _formatDate(_comments[index]['time']),
                                                        style: const TextStyle(color: Colors.grey, fontSize: AppFontStyles.soSmallFontSize),
                                                      ),
                                                      const SizedBox(width: AppFontStyles.aboutMe),
                                                      GestureDetector(
                                                        onTap: () {
                                                          _replyToComment(index);
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
