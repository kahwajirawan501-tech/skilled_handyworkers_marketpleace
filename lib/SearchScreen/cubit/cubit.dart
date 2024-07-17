import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';

class CubitSearch extends Cubit<SearchStates> {
  CubitSearch() : super(SearchStatesInitialStateStates());
  static CubitSearch get(context) => BlocProvider.of(context);

  final List<Map<String, dynamic>> openQuestionPostSearch = [];
  final List<Map<String, dynamic>> postSearch = [];

  final List<Map<String, dynamic>> openQuestionPostSearchLocation = [];
  final List<Map<String, dynamic>> postSearchLocation = [];

  final List<Map<String, dynamic>> openQuestionPostSearchService = [];
  final List<Map<String, dynamic>> postSearchService = [];

  int currentPage = 1;
  bool hasMoreData = true;

  void getPostForLocationAndService(String service, String location, int page) {
    emit(SearchPostLoadStateStates());
    postSearch.clear();
    openQuestionPostSearch.clear();
    currentPage = 1;
    hasMoreData = true;
    _fetchPosts(service, location, page);
  }

  void getPostForLocation(String location, int page) {
    emit(SearchPostOnlyLocationLoadStateStates());
    postSearchLocation.clear();
    openQuestionPostSearchLocation.clear();
    currentPage = 1;
    hasMoreData = true;
    _fetchPostsForLocation(location, page);
  }

  void getPostForService(String service, int page) {
    emit(SearchPostOnlyServiceLoadStateStates());
    postSearchService.clear();
    openQuestionPostSearchService.clear();
    currentPage = 1;
    hasMoreData = true;
    _fetchPostsForService(service, page);
  }

  void _fetchPosts(String service, String location, int page) {
    DioHelper.getData2(
      url: '/post/search?region=$location&skill=$service&page=$page&limit=10',
    ).then((value) {
      final List<Map<String, dynamic>> fetchedData = List<Map<String, dynamic>>.from(value.data);
      for (var post in fetchedData) {
        if (post['type'] == 'post') {
          postSearch.add(post);
        } else if (post['type'] == 'open_question') {
          openQuestionPostSearch.add(post);
        }
      }

      if (fetchedData.length < 10) {
        hasMoreData = false;
      } else {
        currentPage++;
      }

      emit(SearchPostSucssessfullStateStates());
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(SearchPostErrorStateStates(statusCode));
    });
  }

  void _fetchPostsForLocation(String location, int page) {
    DioHelper.getData2(
      url: 'post/search/region?region=$location&page=$page&limit=10',
    ).then((value) {
      final List<Map<String, dynamic>> fetchedData = List<Map<String, dynamic>>.from(value.data);
      for (var post in fetchedData) {
        if (post['type'] == 'post') {
          postSearchLocation.add(post);
        } else if (post['type'] == 'open_question') {
          openQuestionPostSearchLocation.add(post);
        }
      }

      if (fetchedData.length < 10) {
        hasMoreData = false;
      } else {
        currentPage++;
      }

      emit(SearchPostOnlyLocationSucssessfullStateStates());
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(SearchPostOnlyLocationErrorStateStates(statusCode));
    });
  }

  void _fetchPostsForService(String service, int page) {
    DioHelper.getData2(
      url: 'post/search/skill?skill=$service&page=$page&limit=10',
    ).then((value) {
      final List<Map<String, dynamic>> fetchedData = List<Map<String, dynamic>>.from(value.data);
      for (var post in fetchedData) {
        if (post['type'] == 'post') {
          postSearchService.add(post);
        } else if (post['type'] == 'open_question') {
          openQuestionPostSearchService.add(post);
        }
      }

      if (fetchedData.length < 10) {
        hasMoreData = false;
      } else {
        currentPage++;
      }

      emit(SearchPostOnlyServiceSucssessfullStateStates());
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(SearchPostOnlyServiceErrorStateStates(statusCode));
    });
  }
/////////////////////////////////////////////////////////////////////////////////////////
  void getPostForLocationAndServiceNext(String service, String location, int page) {
    emit(SearchPostLoadStateStatesNext());
    _fetchPosts(service, location, page);
  }

  void getPostForLocationNext(String location, int page) {
    emit(SearchPostOnlyLocationLoadStateStatesNext());
    _fetchPostsForLocation(location, page);
  }

  void getPostForServiceNext(String service, int page) {
    emit(SearchPostOnlyServiceLoadStateStatesNext());
    _fetchPostsForService(service, page);
  }



  void deletePost(String id){
    emit(DeletePostLoadStateStatesSearch());
    print("DeletePostLoadStateStates");
    DioHelper.deletePost(
      url:'post/$id',
    ).then((value)
    {

      print("DeletePostSucssessfullStateStates");
      emit(DeletePostSucssessfullStateStatesSearch());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("DeletePostErrorStateStates");
      print(error.toString());
      emit(DeletePostErrorStateStatesSearch(statusCode));
    });
  }

}
