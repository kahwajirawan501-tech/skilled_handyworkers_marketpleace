import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
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
      token: accessToken
    ).then((value) {
      final List<Map<String, dynamic>> fetchedData = List<Map<String, dynamic>>.from(value.data);
      for (var post in fetchedData) {
        if (post['type'] == 'post') {

          post['createdAt']=formatFacebookTime(post['createdAt']);
          postSearch.add(post);
        } else if (post['type'] == 'open_question') {
          post['createdAt']=formatFacebookTime(post['createdAt']);

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
        token: accessToken

    ).then((value) {
      final List<Map<String, dynamic>> fetchedData = List<Map<String, dynamic>>.from(value.data);
      for (var post in fetchedData) {
        if (post['type'] == 'post') {
          post['createdAt']=formatFacebookTime(post['createdAt']);

          postSearchLocation.add(post);
        } else if (post['type'] == 'open_question') {
          post['createdAt']=formatFacebookTime(post['createdAt']);

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
        token: accessToken

    ).then((value) {
      print(value.data);
      final List<Map<String, dynamic>> fetchedData = List<Map<String, dynamic>>.from(value.data);
      for (var post in fetchedData) {
        if (post['type'] == 'post') {
         post['createdAt']=formatFacebookTime(post['createdAt']);

          postSearchService.add(post);
        } else if (post['type'] == 'open_question') {
          post['createdAt']=formatFacebookTime(post['createdAt']);

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
      print(error.toString());
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
  String formatFacebookTime(String postTimeStr) {
    // التحقق من أن التنسيق يتوافق مع HH:mm:ss AM/PM
    if (RegExp(r'^\d{1,2}:\d{2}:\d{2} [APM]{2}$').hasMatch(postTimeStr)) {
      return postTimeStr;
    }

    // إزالة الجزء الأخير الذي يحتوي على معلومات المنطقة الزمنية بين الأقواس
    postTimeStr = postTimeStr.split('(')[0].trim();

    // تحويل الوقت المستلم إلى كائن DateTime باستخدام التنسيق المناسب
    DateTime postTime = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'", 'en_US').parseUtc(postTimeStr).toLocal();

    // الحصول على الوقت الحالي (بتوقيت النظام المحلي)
    DateTime now = DateTime.now();

    // حساب الفرق بين الوقت الحالي ووقت نشر البوست
    Duration delta = now.difference(postTime);


    // في حال كان الفرق أقل من دقيقة واحدة
    if (delta < Duration(minutes: 1)) {
      return "336".tr;
    }
    // في حال كان الفرق أقل من ساعة واحدة
    else if (delta < Duration(hours: 1)) {
      int minutes = delta.inMinutes;
      if (minutes == 1) {
        return "337".tr;
      } else if (minutes == 2) {
        return "338".tr;
      } else if (minutes <= 10) {
        return "${"340".tr} $minutes ${"339".tr}";
      } else {
        return "${"340".tr} $minutes ${"341".tr}";
      }
    }
    // في حال كان الفرق أقل من يوم واحد
    else if (delta < Duration(days: 1)) {
      int hours = delta.inHours;
      if (hours == 1) {
        return "342".tr;
      } else if (hours == 2) {
        return "343".tr;
      } else if (hours <= 10) {
        return "${"340".tr} $hours ${"344".tr}";
      } else {
        return "${"340".tr} $hours ${"345".tr}";
      }
    }
    // في حال كان الفرق بين يوم واحد ويومين
    else if (delta < Duration(days: 2)) {
      return "${"346".tr}${DateFormat('HH:mm', 'ar').format(postTime)}";
    }
    // في حال كان الفرق أكثر من يومين
    else {
      return DateFormat('dd MMM yyyy الساعة HH:mm', 'ar').format(postTime);
    }
  }

}
