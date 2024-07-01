import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skilled_handyworkers_marketpleace/AddPosting/cubit/states.dart';
import 'package:path/path.dart' as p;

import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';

class AddPostCubit extends Cubit<AddPostStates>{
  AddPostCubit():super(AddPostStatesInitialStateStates());
  static AddPostCubit get(context)=>BlocProvider.of(context);



 //id المستخدم
  Future<void> addPost(String service,String location,String description,
      List<String>images,List<String>videos) async {
    emit(AddPostLoadStateStates());
    print("AddPostLoadStateStates");

    DioHelper.postData(
      url:'post/create',
      token:"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQwNDJhNDU3LWViNDItNDczZC1hZDkwLWU5NWFkMjI5NzUyNSIsImZ1bGxOYW1lIjoiTm91ciBOYSIsImVtYWlsIjoibm91cm5hZmlzYWgyMkBnbWFpbC5jb20iLCJpYXQiOjE3MTk4MzY5MDksImV4cCI6MTcyMDA5NjEwOX0.vG5txwa0G-clIIUGlXZ5hQHBRsR6Lq_W-QWaDgd7iqE"
      ,
      data:{
        'type':"post",
        'skill': service,
        'region': location,
        'text': description,
        'images':images,
        'videos':videos
      },
    ).then((value)
    {

      print("AddPostSucssessfullStateStates");
      emit(AddPostSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("AddPostErrorStateStates");

      emit(AddPostErrorStateStates(statusCode,error.response.data['message']));
    });
  }

  Future<void> addOpenQuestion(String service,String location,String description) async {
    emit(AddOpenQuestionLoadStateStates());
    print("AddOpenQuestionLoadStateStates");


    DioHelper.postData(
      url:'post/create',
      token:"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQwNDJhNDU3LWViNDItNDczZC1hZDkwLWU5NWFkMjI5NzUyNSIsImZ1bGxOYW1lIjoiTm91ciBOYSIsImVtYWlsIjoibm91cm5hZmlzYWgyMkBnbWFpbC5jb20iLCJpYXQiOjE3MTk4MzY5MDksImV4cCI6MTcyMDA5NjEwOX0.vG5txwa0G-clIIUGlXZ5hQHBRsR6Lq_W-QWaDgd7iqE"
      ,
      data: {
        'type':"open_question",
        'skill': service,
        'region': location,
        'text': description,
      },
    ).then((value)
    {

      print("AddOpenQuestionSucssessfullStateStates");
      emit(AddOpenQuestionSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("AddOpenQuestionErrorStateStates");
      emit(AddOpenQuestionErrorStateStates(statusCode,error.response.data['message']));
    });
  }



  List<String> ima = [];
  List<String> video = [];

  Future<void> postFile(List<XFile> images, List<XFile> videos) async {
    emit(PostFileLoadStateStates());
    print("PostFileLoadStateStates");

    List<MultipartFile> allFiles = [];

    for (var image in images) {
      allFiles.add(await MultipartFile.fromFile(image.path, filename: image.name));
    }

    for (var video in videos) {
      allFiles.add(await MultipartFile.fromFile(video.path, filename: video.name));
    }

    FormData formData = FormData.fromMap({
      'files': allFiles,
    });

    DioHelper.postDataWithFormData(
      url: 'upload/post',
      data: formData,
    ).then((value) {
      print(value.data);
      List<dynamic> responseData = value.data;

      for (var fileData in responseData) {
        String originalName = fileData['originalname'];
        String filePath = fileData['path'];
        String extension = p.extension(originalName).toLowerCase();

        if (extension == '.jpg' || extension == '.jpeg' || extension == '.png' || extension == '.gif' || extension == '.bmp') {
          ima.add(originalName);
        } else if (extension == '.mp4' || extension == '.avi' || extension == '.mov' || extension == '.wmv' || extension == '.flv') {
          video.add(originalName);
        }
      }

      print("PostFileSucssessfullStateStates");
      emit(PostFileSucssessfullStateStates());
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      print("PostFileErrorStateStates");
      emit(PostFileErrorStateStates(statusCode,error.response.data['message']));
    });
  }

}