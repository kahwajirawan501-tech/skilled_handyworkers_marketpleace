import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Chat_Messages/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Chat_Messages/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class Message extends StatefulWidget {
  final String receiverId ;
  const Message({Key? key, required this.receiverId}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final _commentController = TextEditingController();
  bool _isReplying = false;
  bool _isEditing = false;
  int _editingCommentIndex = -1;
  String _messegeId="0";
  int _commitIndexDelete=-1;
  String _textAddCommit="";
  bool _error=false;

  void _addMessage() {
    if (_commentController.text.isNotEmpty) {
      if (_isEditing) {
        ChatCubit.get(context).editMessage(_editingCommentIndex, _commentController.text);
        _commentController.clear() ;
      } else {
        ChatCubit.get(context).sendMessage(_commentController.text,widget.receiverId);
        _textAddCommit = _commentController.text;
        _commentController.clear();
      }

      setState(() {
        _isEditing = false;
      });
    }
  }

  void _showOptions(BuildContext context, int commentIndex) {
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
                  _deleteMessage(commentIndex);
                },
              ),
              ListTile(
                leading: Icon(Icons.edit, color: AppColor.orangeColor),
                title: Text("Edit", style: TextStyle(color: AppColor.bluColor)),
                onTap: () {
                  Navigator.pop(context);
                  _editMessage(commentIndex);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteMessage(int messageIndex) {
    _commitIndexDelete = messageIndex;
    setState(() {
      ChatCubit.get(context).deleteMessage(_commitIndexDelete);
    });
  }

  void _editMessage(int commentIndex) {
    setState(() {
      _isEditing = true;
      _editingCommentIndex = commentIndex;
      _commentController.text = ChatCubit.get(context).messages[commentIndex]['text'];
    });
  }

  @override
  void initState() {
    super.initState();
    //ChatCubit.get(context).getMessages();
    // ChatCubit.get(context).initializeSocket();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, MessageStates>(
      listener: (context, state) {
         if(state is AddMessageSucssessfullStateStates){
           _error=false;
           _textAddCommit="";
         }
         else if(state is AddMessageErrorStateStates){
           showToast(text:"The message hasn't been send successfully \n", state: ToastStates.EROOR);
           _error=true;

         }

         if(state is DeleteMessageSucssessfullStateStates){
           _commitIndexDelete=-1;
         }
         else if(state is DeleteMessageErrorStateStates){
           showToast(text:"The message hasn't been send successfully \n", state: ToastStates.EROOR);
           _commitIndexDelete= -1;

         }
         if(state is EditMessageSucssessfullStateStates){
           _editingCommentIndex=-1;
           _isEditing = false;
         }
         else if(state is EditMessageErrorStateStates){
           showToast(text:"The message hasn't been edit successfully \n", state: ToastStates.EROOR);
           _editingCommentIndex= -1;
           _isEditing = false;
         }

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColor.arrowBackColor),
              onPressed: () {
                Navigator.pop(context);
                // navigateAndFinish(widget: const ProfileScreen(), context: context);
              },
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(90.0), // تعديل الارتفاع حسب الحاجة
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.aboutMe),
                child: ListTile(
                  leading: ClipOval(
                    child: Image.asset(
                      imageCope!,
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  title: Text(
                    name!.isNotEmpty ? name! : "Rawan",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                      color: AppColor.bluColor,
                      fontWeight: AppFontStyles.fontWeightBold,
                    ),
                  ),
                  subtitle: Text(
                    "Online",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: AppFontStyles.descriptionLoginFontSize,
                      color: AppColor.fontColorDescription,
                      fontWeight: AppFontStyles.fontWeightMedium,
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Container(
            color: AppColor.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(AppFontStyles.padding),

              child: Column(
                children: [
                  Expanded(
                    child: ConditionalBuilder(
                      condition: true, // state is! MessageLoadStateStates
                      builder: (context) => ChatCubit.get(context).messages.isEmpty
                          ? const Center(
                        child: Text(
                          'No messages',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                          : ListView.builder(
                        itemCount: ChatCubit.get(context).messages.length,
                        itemBuilder: (context, index) {
                          final message = ChatCubit.get(context).messages[index];
                          bool isCurrentUserMessage = message['userId'] == id;
                          return Align(
                            alignment: isCurrentUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: isCurrentUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                              children: [
                                if (!isCurrentUserMessage)
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            constraints: const BoxConstraints(maxWidth: 270, minWidth: 120),
                                            padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.aboutMe, vertical: 12),
                                            decoration: BoxDecoration(
                                              color: AppColor.orangeColor.withOpacity(0.1),
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                                bottomRight: Radius.circular(15),
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(message['text']),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              const SizedBox(width: 10),
                                              Text(
                                                message['createdAt'],
                                                style: TextStyle(color: Colors.grey, fontSize: AppFontStyles.soSmallFontSize),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                if (isCurrentUserMessage)
                                  GestureDetector(
                                    onLongPress: () {
                                      if (message['userId'] == id) {
                                        _showOptions(context, index);
                                        setState(() {
                                          _messegeId = message['id'];
                                        });
                                      }
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              constraints: const BoxConstraints(maxWidth: 270, minWidth: 120),
                                              padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.aboutMe, vertical: 12),
                                              decoration: BoxDecoration(
                                                color: AppColor.navyBlueColor,
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                  bottomLeft: Radius.circular(15),
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(message['text'], style: TextStyle(color: Colors.white)),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                const SizedBox(width: 10),
                                                ConditionalBuilder(
                                                  condition: state is! AddMessageLoadStateStates &&
                                                      state is! DeleteMessageLoadStateStates &&
                                                      state is! EditMessageLoadStateStates,
                                                  builder: (context) => (_error && (_messegeId == message['id'] ||
                                                      (index == ChatCubit.get(context).messages.length - 1)))
                                                      ? GestureDetector(
                                                    child: Icon(Icons.refresh_outlined, color: AppColor.orangeColor, size: 20),
                                                    onTap: () {
                                                      ChatCubit.get(context).sendMessage( _textAddCommit,widget.receiverId);                                                    },
                                                  )
                                                      : Text(
                                                    message['createdAt'], // _formatDate(comment['time'])
                                                    style: TextStyle(color: Colors.grey, fontSize: AppFontStyles.soSmallFontSize),
                                                  ),
                                                  fallback: (context) => (((_messegeId == message['id']) &&
                                                      (index == ChatCubit.get(context).messages.length - 1)) ||
                                                      (_messegeId == message['id']) ||
                                                      ((_messegeId == '0') && (index == ChatCubit.get(context).messages.length - 1)))
                                                      ? Container(
                                                    child: CircularProgressIndicator(color: AppColor.orangeColor, strokeWidth: 2),
                                                    height: 10,
                                                    width: 10,
                                                  )
                                                      : Text(
                                                    message['createdAt'], // _formatDate(comment['time'])
                                                    style: TextStyle(color: Colors.grey, fontSize: AppFontStyles.soSmallFontSize),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                const SizedBox(height: 4),
                              ],
                            ),
                          );
                        },
                      ),
                      fallback: (context) => Center(
                        child: CircularProgressIndicator(color: AppColor.orangeColor),
                      ),
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
                          minLines: 1,
                          cursorColor: AppColor.navyBlueColor,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: AppColor.grayColorFont,
                              fontSize: AppFontStyles.descriptionLoginFontSize,
                            ),
                            hintText:

                                'Write your message...',
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
                          onPressed: _addMessage,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
