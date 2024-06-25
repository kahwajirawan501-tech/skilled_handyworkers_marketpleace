import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';

class CubitSearch extends Cubit<SearchStates>{
  CubitSearch():super(SearchStatesInitialStateStates());
  static CubitSearch get(context)=>BlocProvider.of(context);
  final List<Map<String, dynamic>> openQuestionPost = [
    {
      'postId': 1,
      'time': "21 minutes ago",
      'numberOfCommit':"10",
      'postContent': "What are the characteristics of a fake job call form?\n"
          "Because I always find fake job calls so "
          "I'm confused which job to take can you share your knowledge here? thank you",
      'postAuthor': {
        'id': 1,
        'name': "Orlando Diggs",
        'gender': 'male',
        'address': 'Damascus',
        'profileImage': 'assets/images/Mask group.png', // مثال على مسار الصورة
      },

    },
    {
      'postId': 2,
      'time': "20 minutes ago",
      'numberOfCommit':"12",
      'postContent': "What are the characteristics of a fake job call form?\n"
          "Because I always find fake job calls so "
          "I'm confused which job to take can you share your knowledge here? thank you",
      'postAuthor': {
        'id': 2,
        'name': "Roaa Diggs",
        'gender': 'Female',
        'address': 'Damascus',
        'profileImage': 'assets/images/imagePerson.jpg', // مثال على مسار الصورة
      },

    },
    // يمكن إضافة منشورات إضافية هنا حسب الحاجة
  ];


  final List<Map<String, dynamic>> post = [
    {
      'postId': 1,
      'time': "21 minutes ago",
      'numberOfCommit':"10",
      'postContent':{
        'images':[
          "assets/images/download.jpg",
          "assets/images/download.jpg",
          "assets/images/download.jpg",
          "assets/images/download.jpg",
          "assets/images/download.jpg",
          "assets/images/download.jpg",
          "assets/images/download.jpg",
        ],
       'video':null,

      },
      'postAuthor': {
        'id': 1,
        'name': "Orlando Diggs",
        'gender': 'male',
        'address': 'Damascus',
        'profileImage': 'assets/images/Mask group.png', // مثال على مسار الصورة
      },

    },
    {
      'postId': 2,
      'time': "20 minutes ago",
      'numberOfCommit':"12",
      'postContent':{
    'images':[
    "assets/images/download.jpg",
    "assets/images/download.jpg",
    "assets/images/download.jpg",
    "assets/images/download.jpg",
    "assets/images/download.jpg",
    "assets/images/download.jpg",
    "assets/images/download.jpg",
    ],
    'video':''

    },
      'postAuthor': {
        'id': 2,
        'name': "Roaa Diggs",
        'gender': 'Female',
        'address': 'Damascus',
        'profileImage': 'assets/images/imagePerson.jpg', // مثال على مسار الصورة
      },

    },
    // يمكن إضافة منشورات إضافية هنا حسب الحاجة
  ];

  //PostModel postModel;
  void getPost(String service,String location){
    emit(SearchPostLoadStateStates());
    print("SearchPostLoadStateStates");
    DioHelper.postData(
      url:'',
      token: '',
      data: {
        'service': service,
        'location':location
      },
    ).then((value)
    {

      // postModel=PostModel.fromJson(value.data);
      print("SearchPostSucssessfullStateStates");
      emit(SearchPostSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("SearchPostErrorStateStates");
      emit(SearchPostErrorStateStates(statusCode));
    });
  }

  //OpenQuestionPostModel openQuestionPostModel;
  void getOpenQuestionPost(String service,String location){
    emit(SearchOpenQuestionLoadStateStates());
    print("SearchOpenQuestionLoadStateStates");
    DioHelper.postData(
      url:'',
      token: '',
      data: {
        'service': service,
        'location':location
      },
    ).then((value)
    {

      // postModel=PostModel.fromJson(value.data);
      print("SearchOpenQuestionSucssessfullStateStates");
      emit(SearchOpenQuestionSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("SearchOpenQuestionErrorStateStates");
      emit(SearchOpenQuestionErrorStateStates(statusCode));
    });
  }
}