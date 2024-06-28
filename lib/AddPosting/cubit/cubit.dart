import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skilled_handyworkers_marketpleace/AddPosting/cubit/states.dart';

import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';

class AddPostCubit extends Cubit<AddPostStates>{
  AddPostCubit():super(AddPostStatesInitialStateStates());
  static AddPostCubit get(context)=>BlocProvider.of(context);



 //id المستخدم
  Future<void> addPost(int id,String service,String location,String description,List<XFile>images,List<XFile>videos) async {
    emit(AddPostLoadStateStates());
    print("AddPostLoadStateStates");
    FormData formData = FormData.fromMap({
      'id': id,
      'service': service,
      'location': location,
      'description': description,
      'images': await Future.wait(images.map((image) async {
        return await MultipartFile.fromFile(image.path, filename: image.name);
      })),
      'videos': await Future.wait(videos.map((video) async {
        return await MultipartFile.fromFile(video.path, filename: video.name);
      })),
    });

    DioHelper.postDataWithFormData(
      url:'',
      token: '',
      data: formData,
    ).then((value)
    {

      print("AddPostSucssessfullStateStates");
      emit(AddPostSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("AddPostErrorStateStates");
      emit(AddPostErrorStateStates(statusCode));
    });
  }

  Future<void> addOpenQuestion(int id,String service,String location,String description) async {
    emit(AddOpenQuestionLoadStateStates());
    print("AddOpenQuestionLoadStateStates");
    FormData formData = FormData.fromMap({
      'id': id,
      'service': service,
      'location': location,
      'description': description,

    });

    DioHelper.postDataWithFormData(
      url:'',
      token: '',
      data: formData,
    ).then((value)
    {

      print("AddOpenQuestionSucssessfullStateStates");
      emit(AddOpenQuestionSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("AddOpenQuestionErrorStateStates");
      emit(AddOpenQuestionErrorStateStates(statusCode));
    });
  }

}