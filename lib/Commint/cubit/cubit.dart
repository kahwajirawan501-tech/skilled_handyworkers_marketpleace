import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';

class CommitCubit extends Cubit<CommitStates> {
  CommitCubit() : super(CommitStatesInitialStateStates());

  static CommitCubit get(context) => BlocProvider.of(context);
   List<Map<String, dynamic>> comments =[

   ];
   final String idReply="";
   final String idCommit="";

  void getCommit() {
    emit(CommitStatesState(comments));
  }

  void addComment(String content) {
    final newComment = {
       'id': "",
       'postId':"",
       'userId': id,
       'fullName': name,
       'profileImage': "/uploads/post/files-1721217405528-473656958.jpg",
       'text': content,
      //'time': DateTime.now().toIso8601String(),
      'replies': <Map<String, dynamic>>[],
    };

    comments.add(newComment);
    emit(CommitStatesState(comments));
  }

  void addReply(int commentIndex, String content) {
    final reply = {
      'id': "",
      'userId': id,
      'fullName': name,
      'profileImage': "/uploads/post/files-1721217405528-473656958.jpg",
      'text': content,
      //'time': DateTime.now().toIso8601String(),

    };

    comments[commentIndex]['replies'].add(reply);
    print(reply);
    emit(CommitStatesState(comments));
    //addCommitForPost(id!, commentsPost);

  }

  void deleteReply(int commentIndex, int replyIndex) {
    comments[commentIndex]['replies'].removeAt(replyIndex);
    emit(CommitStatesState(comments));
   // deleteCommitForPost(id!, commentsPost);

  }

  void deleteComment(int commentIndex) {
    comments .removeAt(commentIndex);
    emit(CommitStatesState(comments));
    //deleteCommitForPost(id!, commentsPost);
  }

  void editReply(int commentIndex, int replyIndex,String content) {
    comments[commentIndex]['replies'][replyIndex] ['text'] = content;
    emit(CommitStatesState(comments));
   // editCommitForPost(id!, commentsPost);
  }

  void editComment(int commentIndex,String content) {
    comments[commentIndex]['text'] = content;
    emit(CommitStatesState(comments));
    //editCommitForPost(id!, commentsPost);

  }
////////////////////////////////////////////////////////////////////////////////////////
  Future<void> getCommitForPost(String idPost)async {
    emit(CommitLoadStateStates());
    print("CommitLoadStateStates");
   await DioHelper.getData(
      url: '/comments/post/$idPost',
    ).then((value) {
      comments = List<Map<String, dynamic>>.from(value.data);

      emit(CommitSucssessfullStateStates());
    }).catchError((error) {
      print(error.toString());
      int statusCode = error.response?.statusCode ?? -1;
      emit(CommitErrorStateStates(statusCode));
    });
  }

  Future<void> addCommitForPost(String idPost,String commit)async {
    emit(AddCommitLoadStateStates());
    print("AddCommitLoadStateStates");
   await DioHelper.postData(
        url: '/comments/add',
        data: {
          "userId": id,
          "postId": idPost,
          "text": commit
        }
    ).then((value) {
      comments[comments.length-1]['id']=value.data['_id'];
      comments[comments.length-1]['postId']=idPost;

      emit(AddCommitSucssessfullStateStates());
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(AddCommitErrorStateStates(statusCode));
    });
  }
  Future<void> deleteCommitForPost(String idCommit)async {
    emit(DeleteCommitLoadStateStates());
    print("DeleteCommitLoadStateStates");
    await DioHelper.deletePost(
      url: '/comments/delete/$idCommit',
        token: accessToken

    ).then((value) {

      emit(DeleteCommitSucssessfullStateStates());
      print("DeleteCommitSucssessfullStateStates");
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(DeleteCommitErrorStateStates(statusCode));
      print(error.toString());
      print("DeleteCommitErrorStateStates");
    });
  }
  Future<void> editCommitForPost(String idPost,String idCommit,String commit)async {
    emit(EditCommitLoadStateStates());
    print("EditCommitLoadStateStates");
   await DioHelper.putData(
        url: '/comments/edit/$idCommit',
        token: accessToken,
        data: {
          "userId": id,
          "postId": idPost,
          "text": commit

        }
    ).then((value) {

      emit(EditCommitSucssessfullStateStates());
      print("EditCommitSucssessfullStateStates");
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      print(error.toString());
      emit(EditCommitErrorStateStates(statusCode));
    });
  }

  Future<void> addReplyForCommit(String idCommit,String commit) async{
    emit(AddReplyLoadStateStates());
    print("AddReplyLoadStateStates");
  await  DioHelper.postData(
        url: '/comments/reply',
        data: {
          "commentId": idCommit,
          "userId": id,
          "text": commit
        }
    ).then((value) {

      comments[comments.length-1]['replies'][comments[comments.length-1]['replies'].length-1]['id']=value.data['_id'];


      emit(AddReplySucssessfullStateStates());
      print("AddReplySucssessfullStateStates");
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(AddReplyErrorStateStates(statusCode));
      print(error.toString());
      print("AddReplyErrorStateStates");

    });
  }
  Future<void> deleteReplyForPost(String idReply) async{
    emit(DeleteReplyLoadStateStates());
    print("DeleteReplyLoadStateStates");
  await  DioHelper.deletePost(
      url: '/comments/reply/delete/$idReply',
      token: accessToken
    ).then((value) {

      emit(DeleteReplySucssessfullStateStates());
      print("DeleteReplySucssessfullStateStates");
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      print(error.toString());
      emit(DeleteReplyErrorStateStates(statusCode));
      print("DeleteReplyErrorStateStates");
    });
  }
  Future<void> editReplyForPost(String idReply,String idCommit,String commit)async {
    emit(EditReplyLoadStateStates());
    print("EditReplyLoadStateStates");
  await  DioHelper.putData(
        url: '/comments/reply/edit/$idReply',
        token: accessToken,
        data: {
          "commentId":idCommit,
          "userId": id,
          "text": commit

        }
    ).then((value) {

      emit(EditReplySucssessfullStateStates());
      print('EditReplySucssessfullStateStates');
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      print(error.toString());
      emit(EditReplyErrorStateStates(statusCode));
    });
  }



}
