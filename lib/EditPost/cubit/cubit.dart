import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skilled_handyworkers_marketpleace/EditPost/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';
import 'package:path/path.dart' as p;


class EditPostCubit extends Cubit<EditPostStates> {

  EditPostCubit() :super(EditPostStatesInitialStateStates());

  static EditPostCubit get(context) => BlocProvider.of(context);

  //id
  Future<void> editPost(String id,String description,List<String>images,List<String>videos) async {
    emit(EditPostPostLoadStateStates());
    print("EditPostPostLoadStateStates");

    DioHelper.putData(
      url:'post/update/$id',

      data:{
        'text': description,
        'images':images,
        'videos':videos
      },
    ).then((value)
    {

      print("AddPostSucssessfullStateStates");
      emit(EditPostPostSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("AddPostErrorStateStates");
      emit(EditPostPostErrorStateStates(statusCode));
    });
  }

  Future<void> editOpenQuestion(String id,String description) async {
    emit(EditOpenQuestionPostLoadStateStates());
    print("EditOpenQuestionPostLoadStateStates");


   await DioHelper.putData(
      url:'post/update/$id',
      data: {
        'text': description,
      }


    ).then((value)
    {

      print("EditOpenQuestionPostSucssessfullStateStates");
      emit(EditOpenQuestionPostSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("EditOpenQuestionPostErrorStateStates");
      print(error.toString());
      emit(EditOpenQuestionPostErrorStateStates(statusCode));
    });
  }


   Map<String,dynamic> postInformation= {};
  void getInformationForPost(String id){
    print(id);
    emit(GetInformationPostLoadStateStates());
    print("GetInformationPostLoadStateStates");
    DioHelper.getData2(
      url:'post/$id',
       token: accessToken
    ).then((value)
    {
      postInformation=Map<String,dynamic>.from(value.data);

      print("GetInformationPostSucssessfullStateStates");
      emit(GetInformationPostSucssessfullStateStates());

    }
    ).catchError((error){
      print(error.toString());
      int statusCode = error.response?.statusCode ?? -1;
      print("GetInformationPostErrorStateStates");
      emit(GetInformationPostErrorStateStates(statusCode));
    });
  }


  List<String> ima = [];
  List<String> video = [];

  Future<void> postFile(List<XFile> images, List<XFile> videos,List<dynamic>im,List<dynamic>vi) async {
    emit(PostFileLoadStateStates());
    print("PostFileLoadStateStates");
    ima.clear();
    video.clear();
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

    await  DioHelper.postDataWithFormData(
      url: 'upload/post',
      token: accessToken,
      data: formData,
    ).then((value) {
      print(value.data);
      List<dynamic> responseData = value.data;

      for (var fileData in responseData) {
        String originalName = fileData['originalname'];
        String filePath = fileData['path'];
        String extension = p.extension(originalName).toLowerCase();

        if (extension == '.jpg' || extension == '.jpeg' || extension == '.png' || extension == '.gif' || extension == '.bmp') {
          ima.add(filePath);
        } else if (extension == '.mp4' || extension == '.avi' || extension == '.mov' || extension == '.wmv' || extension == '.flv') {
          video.add(filePath);
        }
      }
      for (var im in im) {
        ima.add(im);
      }
      for (var vi in vi) {
        video.add(vi);
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