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
    // {
    //   'postId': 1,
    //   'time': "21 minutes ago",
    //   'numberOfCommit':"10",
    //   'postContent':{
    //     'images':[
    //       "assets/images/download.jpg",
    //       "assets/images/download.jpg",
    //       "assets/images/download.jpg",
    //       "assets/images/download.jpg",
    //       "assets/images/download.jpg",
    //       "assets/images/download.jpg",
    //       "assets/images/download.jpg",
    //     ],
    //    'video':null,
    //
    //   },
    //   'postAuthor': {
    //     'id': 1,
    //     'name': "Orlando Diggs",
    //     'gender': 'male',
    //     'address': 'Damascus',
    //     'profileImage': 'assets/images/Mask group.png', // مثال على مسار الصورة
    //   },
    //
    // },
    // {
    //   'postId': 2,
    //   'time': "20 minutes ago",
    //   'numberOfCommit':"12",
    //   'postContent':{
    // 'images':[
    // "assets/images/download.jpg",
    // "assets/images/download.jpg",
    // "assets/images/download.jpg",
    // "assets/images/download.jpg",
    // "assets/images/download.jpg",
    // "assets/images/download.jpg",
    // "assets/images/download.jpg",
    // ],
    // 'video':''
    //
    // },
    //   'postAuthor': {
    //     'id': 2,
    //     'name': "Roaa Diggs",
    //     'gender': 'Female',
    //     'address': 'Damascus',
    //     'profileImage': 'assets/images/imagePerson.jpg', // مثال على مسار الصورة
    //   },
    //
    // },
    // يمكن إضافة منشورات إضافية هنا حسب الحاجة
    {
      "_id": "668188f16a299a6791092699",
      "userId": "4042a457-eb42-473d-ad90-e95ad2297525",
      "type": "post",
      "text": "",
      "images": [
        "Screenshot 2024-06-30 172407.png",
        "Screenshot 2024-06-30 203505.png"

      ],
      "videos": [
        "E:/IMG_20221107_202953_891.mp4",
        "E:/IMG_20221107_202953_891.mp4",
        "E:/IMG_20221107_202953_891.mp4",
        "E:/IMG_20221107_202953_891.mp4",
      ],
      "region": "ريف دمشق",
      "skill": "التصميم الجرافيكي",
      "createdAt": "2024-06-30T16:33:53.332Z",
      "updatedAt": "2024-06-30T16:33:53.332Z",
      "__v": 0
    },
  ];
  int currentPagePost=1;
  void changePagePost(String service,String location) {
    currentPagePost++;
    getPostForLocationAndService(service,location,currentPagePost);
    print("postSearch.length in changePagePost " );
    print(postSearch.length);
    print("openQuestionPostSearch.length in changePagePost " );
    print(openQuestionPostSearch.length);

  }

  final List<Map<String, dynamic>> openQuestionPostSearch=[];
  final List<Map<String, dynamic>> postSearch=[];
  //PostModel postModel;
  void getPostForLocationAndService(String service,String location,int page){
    emit(SearchPostLoadStateStates());
    print("SearchPostLoadStateStates");
    DioHelper.getData2(
      url:'/post/search?region=دمشق&skill=نجار&page=1&limit=10',

    ).then((value)
    {
      print("l&s");
      print(value.data);
      for (var post in value.data) {
        if (post['type'] == 'post') {
          postSearch.add(post);
        } else if (post['type'] == 'open_question') {
          openQuestionPostSearch.add(post);
        }
      }

      print("SearchPostSucssessfullStateStates");
      emit(SearchPostSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("SearchPostErrorStateStates");
      emit(SearchPostErrorStateStates(statusCode));
    });
  }

  int currentPagePostLocation=1;
  void changePagePostLocation(String location) {
    currentPagePostLocation++;
    getPostForLocation(location,currentPagePostLocation);
    print("postSearchLocation.length in changePagePost " );
    print(postSearchLocation.length);
    print("openQuestionPostSearchLocation.length in changePagePost " );
    print(openQuestionPostSearchLocation.length);
  }
  final List<Map<String, dynamic>> openQuestionPostSearchLocation=[];
  final List<Map<String, dynamic>> postSearchLocation=[];

  void getPostForLocation(String location,int page){
    emit(SearchPostOnlyLocationLoadStateStates());
    print("SearchPostOnlyLocationLoadStateStates");
    DioHelper.getData2(
      url:'post/search/region?region=$location&page=$page&limit=10',

    ).then((value)
    {
      print("location");
      print(value.data);
      for (var post in value.data) {
        if (post['type'] == 'post') {
          postSearchLocation.add(post);
        } else if (post['type'] == 'open_question') {
          openQuestionPostSearchLocation.add(post);
        }
      }

      print("SearchPostOnlyLocationSucssessfullStateStates");
      emit(SearchPostOnlyLocationSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("SearchPostOnlyLocationErrorStateStates");
      emit(SearchPostOnlyLocationErrorStateStates(statusCode));
    });
  }


  int currentPagePostService=1;
  void changePagePostService(String service) {
    currentPagePostService++;
    getPostForService(service,currentPagePostService);
    print("postSearchService.length in changePagePost " );
    print(postSearchService.length);
    print("openQuestionPostSearchService.length in changePagePost " );
    print(openQuestionPostSearchService.length);
  }
  final List<Map<String, dynamic>> openQuestionPostSearchService=[];
  final List<Map<String, dynamic>> postSearchService=[];

  void getPostForService(String service,int page){
    emit(SearchPostOnlyServiceLoadStateStates());
    print("SearchPostOnlyServiceLoadStateStates");
    DioHelper.getData2(
      url:'post/search/skill?skill=$service&page=$page&limit=10',
    ).then((value)
    {
      print("Service");
      print(value.data);
      for (var post in value.data) {
        if (post['type'] == 'post') {
          postSearchService.add(post);
        } else if (post['type'] == 'open_question') {
          openQuestionPostSearchService.add(post);
        }
      }
      print("SearchPostOnlyServiceSucssessfullStateStates");
      emit(SearchPostOnlyServiceSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("SearchPostOnlyServiceErrorStateStates");
      emit(SearchPostOnlyServiceErrorStateStates(statusCode));
    });
  }



}