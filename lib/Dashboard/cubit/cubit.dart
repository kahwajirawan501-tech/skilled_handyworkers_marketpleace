import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/cubit/state.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';


class DashBoardCubit extends Cubit<DashBoardStates> {
  DashBoardCubit() : super(LocationStatesInitialStateStates());

  static DashBoardCubit get(context) => BlocProvider.of(context);

  List<Map<String, dynamic>> location = [];


  List<Map<String, dynamic>> filteredLocation = [];

  void searchLocation(String query) {
    if (query.isEmpty) {
      emit(LocationStatesInitialStateStates());
    } else {
      filteredLocation = location
          .where((element) => element['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(LocationStatesSearchResultState(filteredLocation));
    }
  }

  void getLocation() {
    emit(LocationLoadingStatesStateStates());
    print("LocationLoadingStatesStateStates");
    DioHelper.getData(
      url: 'regions/governorate',
    ).then((value) {
      location=List<Map<String, dynamic>>.from(value.data);
      emit(LocationSucssessfullStateStates());
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(LocationErrorStateStates(statusCode));
    });
  }
  void deleteLocation(String regin) {
    print(regin);
    emit(DeletedLocationLoadStateStates());
    print("DeletedLocationLoadStateStates");
    DioHelper.deletePost(
      url: '/regions/$regin',
      token:tokenDashbord
    ).then((value) {
     emit(DeletedLocationSucssessfullStateStates());
     print("DeletedLocationSucssessfullStateStates");
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      print(error.toString());
      emit(DeletedLocationErrorStateStates(statusCode));
    });
  }
  void addLocation(String regin) {
    print(regin);
    emit(ADDLocationLoadStateStates());
    print("ADDLocationLoadStateStates");
    DioHelper.postData(
        url: '/regions',
        data: {
          "name":regin ,
          "type": "محافظة"
        },
        token:tokenDashbord
    ).then((value) {
      emit(ADDLocationSucssessfullStateStates());
      print("ADDLocationSucssessfullStateStates");
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      print(error.toString());
      emit(ADDLocationErrorStateStates(statusCode));
    });
  }





  List<Map<String, dynamic>>service = [

  ];

  List<Map<String, dynamic>> filteredService = [];

  void searchService(String query) {
    if (query.isEmpty) {
      emit(ServiceStatesInitialStateStates());
    } else {
      filteredService = service
          .where((element) => element['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(ServiceStatesSearchResultState(filteredService));
    }
  }
  void getService() {
    emit(ServiceLoadingStateStates());
    print("ServiceLoadingStateStates");
    DioHelper.getData(
      url: '/skills',
    ).then((value) {
      service=List<Map<String, dynamic>>.from(value.data);
      emit(ServiceSucssessfullStateStates());
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(ServiceErrorStateStates(statusCode));
    });
  }
  void deletedService(String services) {
    print(services);
    emit(DeletedServiceLoadStateStates());
    print("DeletedServiceLoadStateStates");
    DioHelper.deletePost(
      url: '/skills/$services',
      // token:"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjU2YWI2NjBlN2FjNGU0NjhjNDI1ZDA5OSIsImZ1bGxOYW1lIjoiYWRtaW4gYWRtaW4iLCJlbWFpbCI6ImFkbWluQGFkbWluLmNvbSIsImlhdCI6MTcyMzYyMDc5OSwiZXhwIjoxNzIzODc5OTk5fQ.6ySLkc4qvUTwfajeuxCgRQuY7Sx5ck3eF1RQajX81vo"
    ).then((value) {

      emit(DeletedServiceSucssessfullStateStates());
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(DeletedServiceErrorStateStates(statusCode));
    });
  }
  void addService(String services) {
    print(services);
    emit(ADDServiceLoadStateStates());
    print("ADDServiceLoadStateStates");
    DioHelper.postData(
        url: '/skills',
        data: {
          "name":services
        },
        token:tokenDashbord
    ).then((value) {
      emit(ADDServiceSucssessfullStateStates());
      print("ADDServiceSucssessfullStateStates");
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      print(error.toString());
      emit(ADDServiceErrorStateStates(statusCode));
    });
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////////post
  int currentPage = 1;
  bool hasMoreData = true;
  final List<Map<String, dynamic>> openQuestionPost = [];
  final List<Map<String, dynamic>> postList = [];
  void getPostForLocationAndService( int page) {
    print("PostLoadStateStates");
    emit(PostLoadStateStates());
    postList.clear();
    openQuestionPost.clear();
    currentPage = 1;
    hasMoreData = true;
    _fetchPosts( page);
  }
  void _fetchPosts(int page) {
    DioHelper.getData2(
        url: '/post?page=$page&limit=10',
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2YzJlNjA0OWNjYjU3ZDFlYWI2MWZkMiIsImZ1bGxOYW1lIjoiYWRtaW4gYWRtaW4iLCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcyNDA1MjA0MCwiZXhwIjoxNzI0MzExMjQwfQ.BfG_XEGLnWnrFu_eb6WsyIB1BYr-MuUL0Fro3B3iEG0"
    ).then((value) {
        print(value);
      final List<Map<String, dynamic>> fetchedData = List<Map<String, dynamic>>.from(value.data);
      for (var post in fetchedData) {
        if (post['type'] == 'post') {

          post['createdAt']=formatFacebookTime(post['createdAt']);
          postList.add(post);
        } else if (post['type'] == 'open_question') {
          post['createdAt']=formatFacebookTime(post['createdAt']);

          openQuestionPost.add(post);
        }
      }
      print(postList);
      print(openQuestionPost);

      if (fetchedData.length < 10) {
        hasMoreData = false;
      } else {
        currentPage++;
      }

      emit(PostSucssessfullStateStates());
    }).catchError((error) {
      //int statusCode = error.response?.statusCode ?? -1;
      emit(PostErrorStateStates());
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
      return "الآن";
    }
    // في حال كان الفرق أقل من ساعة واحدة
    else if (delta < Duration(hours: 1)) {
      int minutes = delta.inMinutes;
      if (minutes == 1) {
        return "منذ دقيقة واحدة";
      } else if (minutes == 2) {
        return "منذ دقيقتين";
      } else if (minutes <= 10) {
        return "منذ $minutes دقائق";
      } else {
        return "منذ $minutes دقيقة";
      }
    }
    // في حال كان الفرق أقل من يوم واحد
    else if (delta < Duration(days: 1)) {
      int hours = delta.inHours;
      if (hours == 1) {
        return "منذ ساعة واحدة";
      } else if (hours == 2) {
        return "منذ ساعتين";
      } else if (hours <= 10) {
        return "منذ $hours ساعات";
      } else {
        return "منذ $hours ساعة";
      }
    }
    // في حال كان الفرق بين يوم واحد ويومين
    else if (delta < Duration(days: 2)) {
      return "أمس الساعة ${DateFormat('HH:mm', 'ar').format(postTime)}";
    }
    // في حال كان الفرق أكثر من يومين
    else {
      return DateFormat('dd MMM yyyy الساعة HH:mm', 'ar').format(postTime);
    }
  }
  void getPostForLocationAndServiceNext( int page) {
    emit(PostLoadStateStatesNext());
    _fetchPosts(page);
  }




  void deletePost(String id){

    emit(DeletePostLoadStateStatesSearch());
    print("DeletePostLoadStateStates");
    DioHelper.deletePost(

      url:'/post/$id',
        token:tokenDashbord

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
  List<Map<String, dynamic>>users = [

  ];

  List<Map<String, dynamic>> filteredUsers = [];

  void searchUsers(String query) {
    if (query.isEmpty) {
      emit(GetUserMessageInitialStateStates());
    } else {
      filteredUsers = users
          .where((element) => element['fullName'].toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(GetUserMessageSearchResultState(filteredUsers));
    }
  }

  void getUsers() {
    emit(GetUsersLoadStateStatesSearch());
    print("GetUsersLoadStateStatesSearch");
    DioHelper.getData(
      url: '/users',
        token:tokenDashbord

    ).then((value) {
      users=List<Map<String, dynamic>>.from(value.data);
      emit(GetUsersSucssessfullStateStatesSearch());
      print("GetUsersSucssessfullStateStatesSearch");
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(GetUsersErrorStateStatesSearch(statusCode));
      print("GetUsersErrorStateStatesSearch");
    });
  }
  void blockUsers(String id, bool isBlocked) {
    emit(DeletedUsersLoadStateStatesSearch());
    print("DeletedUsersLoadStateStatesSearch");
    DioHelper.putData(
        url: '/users/block',
      data: {
    "id": id,
    "isBlocked": isBlocked
    },
        token:tokenDashbord
    ).then((value) {
      emit(DeletedUsersSucssessfullStateStatesSearch());
      print("DeletedUsersSucssessfullStateStatesSearch");
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(DeletedUsersErrorStateStatesSearch(statusCode));
      print("DeletedUsersErrorStateStatesSearch");
    });
  }
}
