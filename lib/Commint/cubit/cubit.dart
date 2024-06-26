import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/cubit/states.dart';
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
          'id': 2,
          'name': 'Taimaa',
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
    print(commentsPost);
    emit(CommitStatesState(commentsPost));
  }

  void addComment(String content) {
    final newComment = {
      'id': commentsPost.length + 1,
      'content': content,
      'time': DateTime.now().toIso8601String(),
      'author': {
        'id': 4,
        'name': 'New User',
        'gender': 'غير محدد',
        'address': 'غير محدد',
        'profileImage': 'assets/images/Mask group.png',
      },
      'replies': <Map<String, dynamic>>[],
    };

    (comments['comments'] as List).add(newComment);
    emit(CommitStatesState(commentsPost));
  }

  void addReply(int commentIndex, String content) {
    final reply = {
      'id': commentsPost[commentIndex]['replies'].length + 1,
      'content': content,
      'time': DateTime.now().toIso8601String(),
      'author': {
        'id': 4,
        'name': 'New User',
        'gender': 'غير محدد',
        'address': 'غير محدد',
        'profileImage': 'assets/images/Mask group.png',
      },
    };

    (comments['comments'][commentIndex]['replies'] as List).add(reply);
    emit(CommitStatesState(commentsPost));
  }



//CommitModel commitModel;
  void getCommitForPost(int idPost){
    emit(CommitLoadStateStates());
    print("CommitLoadStateStates");
    DioHelper.getData(
      url:'',
      token: '',
    ).then((value)
    {

      // commitModel=CommitModel.fromJson(value.data);
      emit(CommitSucssessfullStateStates());
    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      emit(CommitErrorStateStates(statusCode));
    });
  }










}