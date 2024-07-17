import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class CommitScreen extends StatefulWidget {
  final String idPost;
  final String typePost;
  const CommitScreen({Key? key, required this.idPost, required this.typePost}) : super(key: key);

  @override
  State<CommitScreen> createState() => _CommitScreenState();
}

class _CommitScreenState extends State<CommitScreen> {
  final _commentController = TextEditingController();
  bool _isReplying = false;
  int _replyIndex = -1;
  bool _isEditing = false;
  int _editingCommentIndex = -1;
  int _editingReplyIndex = -1;
  String _commitId="0";
  String _replyId="0";
  int _commitIndexDelete=-1;
  int _replyIndexDelete=-1;
  int _isCicle=-1;

  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      if (_isEditing) {
        if (_isReplying && _editingReplyIndex != -1) {

          CommitCubit.get(context).editReplyForPost(_replyId, _commitId, _commentController.text);

        } else {

          CommitCubit.get(context).editCommitForPost(widget.idPost, _commitId, _commentController.text);



        }
      } else {
        if (_isReplying && _replyIndex != -1) {
          CommitCubit.get(context).addReply(_replyIndex, _commentController.text);

          CommitCubit.get(context).addReplyForCommit(_commitId, _commentController.text);


        } else {
          CommitCubit.get(context).addComment(_commentController.text);
          CommitCubit.get(context).addCommitForPost(widget.idPost, _commentController.text);


        }
      }

      setState(() {
        _isReplying = false;
        _isEditing = false;
        _commitId="0";
        _replyId="0";

      });
    }
  }

  void _replyToComment(int index, String commentId) {
    setState(() {
      _isReplying = true;
      _replyIndex = index;
      _commitId=commentId;
      _commentController.text = "Replying to : ${CommitCubit.get(context).comments[index]["fullName"]}\t \t \t \t  ";
    });
  }

  void _showOptions(BuildContext context, int commentIndex,
      {bool isReply = false, int? replyIndex}) {
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
                  _deleteComment(commentIndex,
                      isReply: isReply, replyIndex: replyIndex);
                },
              ),
              ListTile(
                leading: Icon(Icons.edit, color: AppColor.orangeColor),
                title: Text("Edit", style: TextStyle(color: AppColor.bluColor)),
                onTap: () {
                  Navigator.pop(context);
                  _editComment(commentIndex,
                      isReply: isReply, replyIndex: replyIndex);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteComment(int commentIndex,
      {bool isReply = false, int? replyIndex}) {
    _commitIndexDelete=commentIndex;

    setState(() {
      if (isReply && replyIndex != null) {
        CommitCubit.get(context).deleteReplyForPost(_replyId);




      } else {

        CommitCubit.get(context).deleteCommitForPost(_commitId);


      }
    });
  }

  void _editComment(int commentIndex, {bool isReply = false, int? replyIndex}) {
    setState(() {
      _isEditing = true;
      _editingCommentIndex = commentIndex;

      if (isReply && replyIndex != null) {
        _isReplying = true;
        _editingReplyIndex = replyIndex;
        _commentController.text = CommitCubit.get(context)
            .comments[commentIndex]['replies'][replyIndex]['text'];

      } else {
        _isReplying = false;
        _editingReplyIndex = -1;
        _commentController.text =
            CommitCubit.get(context).comments[commentIndex]['text'];


      }
    });
  }

  String _formatDate(String date) {
    final DateTime dateTime = DateTime.parse(date);
    return "${dateTime.hour}:${dateTime.minute} - ${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  @override
  void initState() {
    super.initState();
    CommitCubit.get(context).getCommitForPost(widget.idPost);
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
        listener: (context, state) {
        setState(() {
          //////////////////////////////////////////////////////////////delete commit
          if(state is DeleteCommitSucssessfullStateStates){
            CommitCubit.get(context).deleteComment(_commitIndexDelete);
            _commitId="0";
            _replyId="0";
            _commitIndexDelete=-1;
            _replyIndexDelete=-1;
            _replyIndex = -1;
            _editingCommentIndex = -1;
            _editingReplyIndex = -1;
            _commitIndexDelete=-1;
          }
          else if (state is DeleteCommitErrorStateStates){
            showToast(text:"The commit hasn't been delete successfully \n", state: ToastStates.EROOR);
            _commitId="0";
            _replyId="0";
            _commitIndexDelete=-1;
            _replyIndexDelete=-1;
            _replyIndex = -1;
            _editingCommentIndex = -1;
            _editingReplyIndex = -1;
            _commitIndexDelete=-1;

          }
          ////////////////////////////////////////////////////////////////delete reply
          if(state is DeleteReplySucssessfullStateStates){
            CommitCubit.get(context).deleteReply(_commitIndexDelete, _replyIndexDelete);
            print(_replyIndexDelete);
            print(_commitIndexDelete);
            _commitId="0";
            _replyId="0";
            _commitIndexDelete=-1;
            _replyIndexDelete=-1;
            _replyIndex = -1;
            _editingCommentIndex = -1;
            _editingReplyIndex = -1;
            _commitIndexDelete=-1;
          }
          else if (state is DeleteReplyErrorStateStates){
            showToast(text:"The commit hasn't been delete successfully \n", state: ToastStates.EROOR);
            print(_replyIndexDelete);
            print(_commitIndexDelete);
            _commitId="0";
            _replyId="0";
            _commitIndexDelete=-1;
            _replyIndexDelete=-1;
            _replyIndex = -1;
            _editingCommentIndex = -1;
            _editingReplyIndex = -1;
            _commitIndexDelete=-1;
          }
          ////////////////////////////////////////////////////////////////edit commit

          if(state is EditCommitSucssessfullStateStates){
            CommitCubit.get(context).editComment(_editingCommentIndex, _commentController.text);
            _commentController.clear();

            _commitId="0";
            _replyId="0";
            _commitIndexDelete=-1;
            _replyIndexDelete=-1;
            _replyIndex = -1;
            _editingCommentIndex = -1;
            _editingReplyIndex = -1;
            _commitIndexDelete=-1;
          }
          else if (state is EditCommitErrorStateStates){
            showToast(text:"The commit hasn't been edit successfully \n", state: ToastStates.EROOR);
            _commitId="0";
            _replyId="0";
            _commitIndexDelete=-1;
            _replyIndexDelete=-1;
            _replyIndex = -1;
            _editingCommentIndex = -1;
            _editingReplyIndex = -1;
            _commitIndexDelete=-1;
          }
          ////////////////////////////////////////////////////////////////edit reply
          if(state is EditReplySucssessfullStateStates){
            CommitCubit.get(context).editReply(_editingCommentIndex,
                _editingReplyIndex, _commentController.text);
            _commentController.clear();

            _commitId="0";
            _replyId="0";
            _commitIndexDelete=-1;
            _replyIndexDelete=-1;
            _replyIndex = -1;
            _editingCommentIndex = -1;
            _editingReplyIndex = -1;
            _commitIndexDelete=-1;
          }
          else if (state is EditReplyErrorStateStates){
            showToast(text:"The commit hasn't been edit successfully \n", state: ToastStates.EROOR);

            _commitId="0";
            _replyId="0";
            _commitIndexDelete=-1;
            _replyIndexDelete=-1;
            _replyIndex = -1;
            _editingCommentIndex = -1;
            _editingReplyIndex = -1;
            _commitIndexDelete=-1;
          }

          /////////////////////////////////////////////////////////////////add commit
          if(state is AddCommitSucssessfullStateStates){
            _commentController.clear();
            _commitId="0";
            _replyId="0";
            _commitIndexDelete=-1;
            _replyIndexDelete=-1;
            _replyIndex = -1;
            _editingCommentIndex = -1;
            _editingReplyIndex = -1;
            _commitIndexDelete=-1;
          }
          else if (state is AddCommitErrorStateStates){
            showToast(text:"The commit hasn't been add successfully \n", state: ToastStates.EROOR);
            _commitId="0";
            _replyId="0";
            _commitIndexDelete=-1;
            _replyIndexDelete=-1;
            _replyIndex = -1;
            _editingCommentIndex = -1;
            _editingReplyIndex = -1;
            _commitIndexDelete=-1;
          }
          ///////////////////////////////////////////////////////////////////add reply
          if(state is AddReplySucssessfullStateStates){
            _commentController.clear();
            _commitId="0";
            _replyId="0";
            _commitIndexDelete=-1;
            _replyIndexDelete=-1;
            _replyIndex = -1;
            _editingCommentIndex = -1;
            _editingReplyIndex = -1;
            _commitIndexDelete=-1;
          }
          else if (state is AddReplyErrorStateStates){
            showToast(text:"The commit hasn't been add successfully \n", state: ToastStates.EROOR);
            _commitId="0";
            _replyId="0";
            _commitIndexDelete=-1;
            _replyIndexDelete=-1;
            _replyIndex = -1;
            _editingCommentIndex = -1;
            _editingReplyIndex = -1;
            _commitIndexDelete=-1;
          }
        });


        },
        builder: (context, state) {
          return Container(
            color: AppColor.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(AppFontStyles.aboutMe),
              child: Column(
                children: [
                  Expanded(
                    child: ConditionalBuilder(
                      condition:
                      state is! CommitLoadStateStates  ,//CommitCubit.get(context).commentsPost.isNotEmpty //state is CommitLoadStateStates
                      builder: (context) => CommitCubit.get(context)
                          .comments
                          .isEmpty
                          ? const Center(
                        child: Text(
                          'No comments yet. Be the first to comment!',
                          style:
                          TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                          : ListView.builder(
                        itemCount:
                        CommitCubit.get(context).comments.length,
                        itemBuilder: (context, index) {
                          final comment = CommitCubit.get(context)
                              .comments[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onLongPress: () {
                                  if (comment['userId'] == id) {
                                    _showOptions(context, index);
                                setState(() {
                              _commitId=comment['id'];

                              });
                                  }
                                },
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    ClipOval(
                                      child: Image.network(
                                        api+comment['profileImage'],
                                        fit: BoxFit.cover,
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          constraints:
                                          const BoxConstraints(
                                              maxWidth: 270,
                                              minWidth: 217),
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal:
                                              AppFontStyles
                                                  .aboutMe,
                                              vertical: 12),
                                          decoration: BoxDecoration(
                                            color: AppColor.orangeColor
                                                .withOpacity(0.1),
                                            borderRadius:
                                            const BorderRadius.only(
                                              topLeft:
                                              Radius.circular(30),
                                              topRight:
                                              Radius.circular(30),
                                              bottomRight:
                                              Radius.circular(30),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                comment['fullName'],
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(comment['text']),
                                              const SizedBox(height: 5),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            // Text(
                                            //   "67",//_formatDate(comment['time'])
                                            //
                                            //   style: const TextStyle(
                                            //       color: Colors.grey,
                                            //       fontSize: AppFontStyles
                                            //           .soSmallFontSize),
                                            // ),
                                            const SizedBox(width: 10,),
                                            ConditionalBuilder(
                                                condition: state is !AddCommitLoadStateStates &&
                                                    state is !DeleteCommitLoadStateStates
                                                    && state is! EditCommitLoadStateStates,
                                                builder:(context) =>    const Text(
                          "5:19 PM",//_formatDate(comment['time'])

                          style: TextStyle(
                          color: Colors.grey,
                          fontSize: AppFontStyles
                              .soSmallFontSize),
                          ),
                                                fallback:(context) =>
                                                (_commitId==comment['id'] ||index==CommitCubit.get(context).comments.length-1)?
                                                Container(

                                                  child: CircularProgressIndicator(color:AppColor.orangeColor,strokeWidth: 2,)
                                                  ,
                                                  height: 10,
                                                  width: 10,
                                                ):SizedBox(),),
                                            const SizedBox(
                                                width: AppFontStyles
                                                    .aboutMe),
                                            GestureDetector(
                                              onTap: () {

                                                _replyToComment(
                                                    index, comment['id']);
                                              },
                                              child: Text(
                                                'Reply',
                                                style: TextStyle(
                                                    color: AppColor
                                                        .orangeColor,
                                                    fontSize: AppFontStyles
                                                        .descriptionLoginFontSize),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            ...(comment['replies']
                                            as List<
                                                dynamic>)
                                                .map((reply) {
                                                  print("object");
                                                  print(reply);
                                              return GestureDetector(
                                                onLongPress: () {

                                                  if (reply['userId']
                                                   ==
                                                      id) {
                                                    _showOptions(
                                                        context, index,
                                                        isReply: true,
                                                        replyIndex: comment['replies'].indexOf(reply));
                                                    _replyId=reply["id"];
                                                    _commitId=comment['id'];
                                                    _replyIndexDelete=comment['replies'].indexOf(reply);
                                                  }

                                                },
                                                child: Row(
                                                  children: [
                                                    ClipOval(
                                                      child: Image.network(

                                                        api+reply['profileImage']
                                                        ,
                                                        fit: BoxFit.cover,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                        width: 10),
                                                    Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Container(
                                                          constraints:
                                                          const BoxConstraints(
                                                              maxWidth:
                                                              270,
                                                              minWidth:
                                                              217),
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                              AppFontStyles
                                                                  .aboutMe,
                                                              vertical:
                                                              12),
                                                          decoration:
                                                          BoxDecoration(
                                                            color: AppColor
                                                                .navyBlueColor
                                                                .withOpacity(
                                                                0.1),
                                                            borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                  30),
                                                              topRight: Radius
                                                                  .circular(
                                                                  30),
                                                              bottomRight:
                                                              Radius.circular(
                                                                  30),
                                                            ),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text(
                                                                reply['fullName']
                                                               ,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.bold),
                                                              ),
                                                              const SizedBox(
                                                                  height:
                                                                  5),
                                                              Text(reply[
                                                              'text']),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 4),
                                                        Row(
                                                          children: [
                                                            // Text(//_formatDate(reply['time'])
                                                            //   "6"
                                                            //       ,
                                                            //
                                                            //   style: const TextStyle(
                                                            //       color: Colors
                                                            //           .grey,
                                                            //       fontSize:
                                                            //       AppFontStyles.soSmallFontSize),
                                                            // ),
                                                            const SizedBox(width: 10,),
                                                            ConditionalBuilder(
                                                              condition: state is !AddReplyLoadStateStates &&
                                                                  state is!DeleteReplyLoadStateStates
                                                                  && state is !EditReplyLoadStateStates,
                                                              builder:(context) =>    const Text(
                                                                "5:19 PM",//_formatDate(comment['time'])

                                                                style: TextStyle(
                                                                    color: Colors.grey,
                                                                    fontSize: AppFontStyles
                                                                        .soSmallFontSize),
                                                              ),
                                                              fallback:(context) =>_replyId==reply["id"]? Container(

                                                                child: CircularProgressIndicator(
                                                                  color:AppColor.orangeColor,strokeWidth: 2,)
                                                                ,
                                                                height: 10,
                                                                width: 10,
                                                              ):SizedBox(),),
                                                            const SizedBox(
                                                                width: AppFontStyles
                                                                    .aboutMe),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 4),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                            ],
                          );
                        },
                      ),
                      fallback: (context) => Center(
                          child: CircularProgressIndicator(
                              color: AppColor.orangeColor)),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          maxLines: null,
                          // يسمح للنص بأن يتمدد لعدد غير محدود من الأسطر
                          minLines: 1,
                          // يبدأ بسطر واحد ويمكن أن يتمدد حسب الحاجة
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: AppColor.grayColorFont,
                              fontSize: AppFontStyles.descriptionLoginFontSize,
                            ),
                            hintText: _isReplying
                                ? 'Write your reply...'
                                : 'Write your message...',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
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
