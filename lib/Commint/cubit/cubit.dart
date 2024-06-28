import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';

class CommitCubit extends Cubit<CommitStates> {
  CommitCubit() : super(CommitStatesInitialStateStates());

  static CommitCubit get(context) => BlocProvider.of(context);

  final Map<String, dynamic> comments = {
    'postId': 1,
    'postAuthor': {
      'id': 1,
      'name': 'اسم الكاتب',
      'gender': 'ذكر',
      'address': 'عنوان الكاتب',
      'profileImage': 'assets/images/Mask group.png',
    },
    'comments': [
      {
        'id': 1,
        'content': 'Hi nina',
        'time': '2024-06-27T15:30:00Z',
        'author': {
          'id': 1,
          'name': 'Orlando Diggs',
          'gender': 'female',
          'address': 'Damascus',
          'profileImage': 'assets/images/Mask group.png',
        },
        'replies': <Map<String, dynamic>>[
          {
            'id': 1,
            'content': 'hi Taimaa',
            'time': '2024-06-27T16:00:00Z',
            'author': {
              'id': 3,
              'name': 'nina',
              'gender': 'female',
              'address': 'Damascus',
              'profileImage': 'assets/images/imagePerson.jpg',
            },
          },
        ],
      },
    ],
  };

  List<Map<String, dynamic>> get commentsPost => List<Map<String, dynamic>>.from(comments['comments'] as List);

  void getCommit() {
    emit(CommitStatesState(commentsPost));
  }

  void addComment(String content) {
    final newComment = {
      'id': commentsPost.length + 1,
      'content': content,
      'time': DateTime.now().toIso8601String(),
      'author': {
        'id': id,
        'name': name,
        'gender': gender,
        'address': location,
        'profileImage': image,
        'number': number
      },
      'replies': <Map<String, dynamic>>[],
    };

    (comments['comments'] as List).add(newComment);
    emit(CommitStatesState(commentsPost));
 //   addCommitForPost(id!, commentsPost);
  }

  void addReply(int commentIndex, String content) {
    final reply = {
      'id': commentsPost[commentIndex]['replies'].length + 1,
      'content': content,
      'time': DateTime.now().toIso8601String(),
      'author': {
        'id': id,
        'name': name,
        'gender': gender,
        'address': location,
        'profileImage': image,
        'number': number
      },
    };

    (comments['comments'][commentIndex]['replies'] as List).add(reply);
    emit(CommitStatesState(commentsPost));
    //addCommitForPost(id!, commentsPost);

  }

  void deleteReply(int commentIndex, int replyIndex) {
    (comments['comments'][commentIndex]['replies'] as List).removeAt(replyIndex);
    emit(CommitStatesState(commentsPost));
   // deleteCommitForPost(id!, commentsPost);

  }

  void deleteComment(int commentIndex) {
    (comments['comments'] as List).removeAt(commentIndex);
    emit(CommitStatesState(commentsPost));
    //deleteCommitForPost(id!, commentsPost);
  }

  void editReply(int commentIndex, int replyIndex,String content) {
    (comments['comments'][commentIndex]['replies'][replyIndex] as Map<String, dynamic>)['content'] = content;
    emit(CommitStatesState(commentsPost));
   // editCommitForPost(id!, commentsPost);
  }

  void editComment(int commentIndex,String content) {
    (comments['comments'][commentIndex] as Map<String, dynamic>)['content'] = content;
    emit(CommitStatesState(commentsPost));
    //editCommitForPost(id!, commentsPost);

  }




  // CommitModel commitModel;
  void getCommitForPost(int idPost) {
    emit(CommitLoadStateStates());
    print("CommitLoadStateStates");
    DioHelper.getData(
      url: '',
      token: '',
    ).then((value) {
      // commitModel = CommitModel.fromJson(value.data);
      emit(CommitSucssessfullStateStates());
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(CommitErrorStateStates(statusCode));
    });
  }

  void deleteCommitForPost(int idPost,List<Map<String, dynamic>>commit) {
    emit(DeleteCommitLoadStateStates());
    print("DeleteCommitLoadStateStates");
    DioHelper.postData(
      url: '',
      token: '',
      data: {
        'idPost':idPost,
        'commit':commit,
      }
    ).then((value) {

      emit(DeleteCommitSucssessfullStateStates());
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(DeleteCommitErrorStateStates(statusCode));
    });
  }

  void editCommitForPost(int idPost,List<Map<String, dynamic>>commit) {
    emit(EditCommitLoadStateStates());
    print("EditCommitLoadStateStates");
    DioHelper.postData(
        url: '',
        token: '',
        data: {
          'idPost':idPost,
          'commit':commit,
        }
    ).then((value) {

      emit(EditCommitSucssessfullStateStates());
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(EditCommitErrorStateStates(statusCode));
    });
  }

  void addCommitForPost(int idPost,List<Map<String, dynamic>>commit) {
    emit(AddCommitLoadStateStates());
    print("AddCommitLoadStateStates");
    DioHelper.postData(
        url: '',
        token: '',
        data: {
          'idPost':idPost,
          'commit':commit,
        }
    ).then((value) {

      emit(AddCommitSucssessfullStateStates());
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(AddCommitErrorStateStates(statusCode));
    });
  }

}
