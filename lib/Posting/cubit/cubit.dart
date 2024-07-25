import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';

class CubitYourPost extends Cubit<YourPostStates>{
  CubitYourPost():super(YourPostStatesInitialStateStates());
  static CubitYourPost get(context)=>BlocProvider.of(context);



final List<Map<String,dynamic>>post=[];
final List<Map<String,dynamic>>openQuestion=[];

 void getPost(){
    emit(YourPostPostLoadStateStates());
    print("YourPostPostLoadStateStates");
    post.clear();
    DioHelper.getData(
      url:'post/$id/posts',
    ).then((value)
    {
      print(value.data);
      post.addAll(List<Map<String, dynamic>>.from(value.data));
      print("YourPostPostSucssessfullStateStates");
      emit(YourPostPostSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("YourPostPostErrorStateStates");
      emit(YourPostPostErrorStateStates(statusCode));
    });
  }
 void getOpenQuestion(){
    emit(YourOpenQuestionPostLoadStateStates());
    print("YourOpenQuestionPostLoadStateStates");
    openQuestion.clear();
    DioHelper.getData(
      url:'post/$id/open-questions',
    ).then((value)
    {
      openQuestion.addAll(List<Map<String, dynamic>>.from(value.data));
       print(openQuestion);
      print("YourOpenQuestionPostSucssessfullStateStates");
      emit(YourOpenQuestionPostSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("YourOpenQuestionPostErrorStateStates");
      emit(YourOpenQuestionPostErrorStateStates(statusCode));
    });
  }
  void deletePost(String id){
    emit(DeletePostLoadStateStates());
    print("DeletePostLoadStateStates");
    DioHelper.deletePost(
      url:'post/$id',
    ).then((value)
    {

      print("DeletePostSucssessfullStateStates");
      emit(DeletePostSucssessfullStateStates());
     getOpenQuestion();
     getPost();
    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("DeletePostErrorStateStates");
      print(error.toString());
      emit(DeletePostErrorStateStates(statusCode));
    });
  }



}