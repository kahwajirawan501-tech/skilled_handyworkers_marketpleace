import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';

class CubitYourPost extends Cubit<YourPostStates>{
  CubitYourPost():super(YourPostStatesInitialStateStates());
  static CubitYourPost get(context)=>BlocProvider.of(context);
  final Map<String, dynamic> yourPost =
    {
      'information_profile':{
        'id': 1,
        'name': "Orlando Diggs",
        'gender': 'male',
        'address': 'Damascus',
        'profileImage': 'assets/images/Mask group.png',
        'number':"0986756248"
        // مثال على مسار الصورة

      },
      'OpenQuestion':[
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
      ],
      'post':[
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
      ]
    }

    // يمكن إضافة منشورات إضافية هنا حسب الحاجة
  ;



  //InformationModel informationModel;
  void getPost(int id){
    emit(YourPostPostSucssessfullStateStates());
    print("YourPostPostSucssessfullStateStates");
    DioHelper.postData(
      url:'',
      token: '',
      data: {
        'id': id,

      },
    ).then((value)
    {

      // informationModel=InformationModel.fromJson(value.data);
      print("YourPostPostSucssessfullStateStates");
      emit(YourPostPostSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("YourPostPostErrorStateStates");
      emit(YourPostPostErrorStateStates(statusCode));
    });
  }


}