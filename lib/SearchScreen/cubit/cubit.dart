import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';

class CubitSearch extends Cubit<SearchStates>{
  CubitSearch():super(SearchStatesInitialStateStates());
  static CubitSearch get(context)=>BlocProvider.of(context);



  final List<Map<String, dynamic>> openQuestionPostSearch=[];
  final List<Map<String, dynamic>> postSearch=[];
  //PostModel postModel;
  getPostForLocationAndService(String service, String location, int page)  {
    emit(SearchPostLoadStateStates());

    print("SearchPostLoadStateStates");
    postSearch.clear();
    openQuestionPostSearch.clear();
    DioHelper.getData2(
      url: '/post/search?region=$location&skill=$service&page=$page&limit=10',
    ).then((value) {

      print(value.data);


        for (var post in value.data) {
          if (post['type'] == 'post') {
            postSearch.add(post);
          } else if (post['type'] == 'open_question') {
            openQuestionPostSearch.add(post);
          }
          print("length all");

          print(postSearch.length+openQuestionPostSearch.length);


      }

      print("SearchPostSucssessfullStateStates");
      emit(SearchPostSucssessfullStateStates());

    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      print("SearchPostErrorStateStates");
      emit(SearchPostErrorStateStates(statusCode));
    });
  }



  final List<Map<String, dynamic>> openQuestionPostSearchLocation=[];
  final List<Map<String, dynamic>> postSearchLocation=[];

  void getPostForLocation(String location,int page){
    emit(SearchPostOnlyLocationLoadStateStates());
    print("SearchPostOnlyLocationLoadStateStates");
    postSearchLocation.clear();
    openQuestionPostSearchLocation.clear();

    DioHelper.getData2(
      url:'post/search/region?region=$location&page=$page&limit=10',

    ).then((value)
    {

      for (var post in value.data) {
        if (post['type'] == 'post') {
          postSearchLocation.add(post);
        } else if (post['type'] == 'open_question') {
          openQuestionPostSearchLocation.add(post);
        }
      }
      print("length location");

      print(postSearchLocation.length+openQuestionPostSearchLocation.length);

      print("SearchPostOnlyLocationSucssessfullStateStates");
      emit(SearchPostOnlyLocationSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("SearchPostOnlyLocationErrorStateStates");
      emit(SearchPostOnlyLocationErrorStateStates(statusCode));
    });
  }


  final List<Map<String, dynamic>> openQuestionPostSearchService=[];
  final List<Map<String, dynamic>> postSearchService=[];

  void getPostForService(String service,int page){
    emit(SearchPostOnlyServiceLoadStateStates());
    print("SearchPostOnlyServiceLoadStateStates");
    openQuestionPostSearchService.clear();
    postSearchService.clear();
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