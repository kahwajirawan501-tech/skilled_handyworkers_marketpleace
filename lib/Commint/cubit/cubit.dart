import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

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
      'createdAt':"",
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
      'commentId':"",
      'createdAt':""
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
    print(idPost);
    comments.clear();
   await DioHelper.getData(
      url: '/comments/post/$idPost',
    ).then((value) {
     List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(value.data);

     data.forEach((comment) {
       comment['createdAt'] = formatFacebookTime(comment['createdAt']);

       if (comment['replies'] != null) {
         comment['replies'].forEach((reply) {
           reply['createdAt'] = formatFacebookTime(reply['createdAt']);
         });
       }
     });

     comments = data;



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

      comments[comments.length-1]['createdAt']=formatFacebookTime(value.data['createdAt']);

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
       print(comments);
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
    print(idCommit);
  await  DioHelper.postData(
        url: '/comments/reply',
        data: {
          "commentId": idCommit,
          "userId": id,
          "text": commit
        }
    ).then((value) {


      for (var commit in comments){
        if(commit.containsValue(idCommit)){
          commit['replies'][ commit['replies'].length-1]['id']=value.data['_id'];
          commit['replies'][ commit['replies'].length-1]['commentId']=idCommit;
          commit['replies'][ commit['replies'].length-1]=formatFacebookTime(value.data['createdAt']);

        }
      }


      emit(AddReplySucssessfullStateStates());
      print("AddReplySucssessfullStateStates");
    }).catchError((error) {

     // print(error.toString());
      print("AddReplyErrorStateStates");
      emit(AddReplyErrorStateStates());

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


  String formatFacebookTime(String postTimeStr) {
    if (RegExp(r'^\d{2}:\d{2}:\d{2} [APM]{2}$').hasMatch(postTimeStr)) {
      return postTimeStr;
    }
    // إزالة الجزء الأخير الذي يحتوي على معلومات المنطقة الزمنية بين الأقواس
    postTimeStr = postTimeStr.split('(')[0].trim();

    // تحويل الوقت المستلم إلى كائن DateTime
    DateTime postTime = DateFormat("EEE MMM dd yyyy HH:mm:ss 'GMT'Z", 'en_US').parse(postTimeStr);
    print(postTime);
    // الحصول على الوقت الحالي (بتوقيت النظام المحلي)
    DateTime now = DateTime.now();

    print(now);
    // حساب الفرق بين الوقت الحالي ووقت نشر البوست
    Duration delta = now.difference(postTime);

    // في حال كان الفرق أقل من دقيقة واحدة
    if (delta < Duration(minutes: 1)) {
      return "الآن";
    }
    // في حال كان الفرق أقل من ساعة واحدة
    else if (delta < Duration(hours: 1)) {
      int minutes = delta.inMinutes;
      if (minutes == 1) {
        return "منذ دقيقة واحدة";
      } else if (minutes == 2) {
        return "منذ دقيقتين";
      } else if (minutes <= 10) {
        return "منذ $minutes دقائق";
      } else {
        return "منذ $minutes دقيقة";
      }
    }
    // في حال كان الفرق أقل من يوم واحد
    else if (delta < Duration(days: 1)) {
      int hours = delta.inHours;
      if (hours == 1) {
        return "منذ ساعة واحدة";
      } else if (hours == 2) {
        return "منذ ساعتين";
      } else if (hours <= 10) {
        return "منذ $hours ساعات";
      } else {
        return "منذ $hours ساعة";
      }
    }
    // في حال كان الفرق بين يوم واحد ويومين
    else if (delta < Duration(days: 2)) {
      return "أمس الساعة ${DateFormat('HH:mm', 'ar').format(postTime)}";
    }
    // في حال كان الفرق أكثر من يومين
    else {
      return DateFormat('dd MMM yyyy الساعة HH:mm', 'ar').format(postTime);
    }

  }

}
