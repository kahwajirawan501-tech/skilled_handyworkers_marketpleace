import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skilled_handyworkers_marketpleace/EditPost/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';

class EditPostCubit extends Cubit<EditPostStates> {

  EditPostCubit() :super(EditPostStatesInitialStateStates());

  static EditPostCubit get(context) => BlocProvider.of(context);

  //id
  Future<void> editPost(int id,String service,String location,String description,List<XFile>images,List<XFile>videos) async {
    emit(EditPostPostLoadStateStates());
    print("EditPostPostLoadStateStates");
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
      emit(EditPostPostSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("AddPostErrorStateStates");
      emit(EditPostPostErrorStateStates(statusCode));
    });
  }

  Future<void> editOpenQuestion(int id,String service,String location,String description) async {
    emit(EditOpenQuestionPostLoadStateStates());
    print("EditOpenQuestionPostLoadStateStates");
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

      print("EditOpenQuestionPostSucssessfullStateStates");
      emit(EditOpenQuestionPostSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("EditOpenQuestionPostErrorStateStates");
      emit(EditOpenQuestionPostErrorStateStates(statusCode));
    });
  }

}