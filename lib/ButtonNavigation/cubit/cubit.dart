import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/BottonNavigationBar.dart';
import 'package:skilled_handyworkers_marketpleace/Chat_Messages/chat_List.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/commintSceren.dart';
import 'package:skilled_handyworkers_marketpleace/HomeScreen/HomeScreen.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/TabBarScreen.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/informationCustomer.dart';
import 'package:skilled_handyworkers_marketpleace/Save/save.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Language/language.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Setting/setting.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profileScreen.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/skill/skill.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';

import '../../shared/components/constant.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit ():super(HomeStatesInitialStateStates());
  static HomeCubit get(context)=>BlocProvider.of(context);

  // for BottomNavigationBar
  int selectedIndex=0;
   final List<Widget> pages = [
     HomeScreen(),
     ProfileScreen(),
     TabBarPosting() ,
     ChatList(),
     Save(),
     Save(),
   ];
  void onItemTappedForBottomNavigationBar(int index) {

      selectedIndex = index;
      print(selectedIndex);
  }
  Future<void>getProfileInformation()async{
    emit(GetInformationStatesLoadingStateStates());
    print("GetInformationStatesLoadingStateStates");
    await  DioHelper.getData2(
      url:'/users/$id',

    ).then((value)
    {
      print("Response received");
      print("Data: ${value.data}");
      // Check if the response contains the expected data
      if (value.data != null ) {
        imageNetwork=value.data['profileImage'] ?? "";
        name=value.data['fullName'] ?? "";
        email=value.data['email'] ?? "";
        dateOfBirthh=value.data['dateOfBirth'] ?? "";
        gender=value.data['gender'] ?? "";
        locationConst=value.data['location'] ?? "";
        numberConst=value.data['phoneNumber'] ?? "";
        aboutMy=value.data['aboutMe'] ?? "";
        workTittle=value.data['jobTitle'] ?? "";
        workDescription=value.data['jobDescription'] ?? "";
        educationTittle=value.data['institutionName'] ?? "";
        educationDescription=value.data['institutionDescription'] ?? "";
        skill=value.data['skills'] ?? "";
        role=value.data['role'];
        print("GetInformationSucssessfullStateStates");
        emit(GetInformationSucssessfullStateStates());
        print(imageNetwork);

      } else {
        print("GetInformationErrorStateStates");
        emit(GetInformationErrorStateStates(0));
      }


    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print(error.toString());

      print("GetInformationErrorStateStates");
      emit(GetInformationErrorStateStates(statusCode));
    });
  }
  Future<void>getProfileId()async{
    print(accessToken);
    emit(GetInformationIDStatesLoadingStateStates());
    print("GetInformationIDStatesLoadingStateStates");
    print("token: $accessToken");
    await  DioHelper.getData2(
        url:'/users/info',
        token: accessToken
    ).then((value)
    {
      print(" 79029");
      print(value.data);

      print("Data: ${value.data}");
      // Check if the response contains the expected data
      if (value.data != null ) {
        id=value.data['_id'] ?? "";
        getProfileInformation();

        print("GetInformationIDSucssessfullStateStates");
        emit(GetInformationIDSucssessfullStateStates());

      } else {
        print("GetInformationIdErrorStateStates");
        emit(GetInformationIdErrorStateStates(0));
      }


    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print(error.toString());

      print("GetInformationErrorStateStates");
      emit(GetInformationErrorStateStates(statusCode));
    });
  }

/////////////////////
  List<Map<String, dynamic>>users=[];
 Future<void> searchUser(String name) async{
    emit(GetUserSearchStatesLoadingStateStates());
    print("GetUserSearchStatesLoadingStateStates");
  await  DioHelper.getData(
        url: '/users/search/$name',
        token:accessToken

    ).then((value) {
      users=List<Map<String, dynamic>>.from(value.data);
      emit(GetUserSearchSucssessfullStateStates());
      print("GetUserSearchSucssessfullStateStates");
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(GetUserSearchErrorStateStates(statusCode));
      print("GetUserSearchErrorStateStates");
    });
  }

  int currentPage = 1;
  bool hasMoreData = true;
  final List<Map<String, dynamic>> postList = [];
  void getPostForLocationAndService( int page) {
    emit(PostLoadStateStates());
    postList.clear();
    currentPage = 1;
    hasMoreData = true;
    _fetchPosts( page);
  }
  void _fetchPosts(int page) {

    DioHelper.getData2(
        url: '/post/posts?page=$page&limit=10',///post?page=1&limit=10
        token: accessToken
    ).then((value) {

      final List<Map<String, dynamic>> fetchedData = List<Map<String, dynamic>>.from(value.data);
      for (var post in fetchedData) {
        if (post['type'] == 'post') {

          post['createdAt']=formatFacebookTime(post['createdAt']);
          postList.add(post);
        }
      }

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
    else {
      return DateFormat('dd MMM yyyy الساعة HH:mm', 'ar').format(postTime);
    }
  }
  void getPostForLocationAndServiceNext( int page) {
    emit(PostLoadStateStatesNext());
    _fetchPosts(page);
  }



  int currentPageOpenQuestion = 1;
  bool hasMoreDataOpenQuestion = true;
  final List<Map<String, dynamic>> openQuestionPost = [];
  void getPostForLocationAndServiceOpenQuestion( int page) {
    emit(PostLoadStateStatesOpenQuestion());
    openQuestionPost.clear();
    currentPageOpenQuestion = 1;
    hasMoreDataOpenQuestion = true;
    _fetchPostsOpenQuestion( page);
  }
  void _fetchPostsOpenQuestion(int page) {
    DioHelper.getData2(
        url: '/post/open-questions?page=$page&limit=10',////post/open-questions?page=1&limit=10
        token: accessToken
    ).then((value) {
      final List<Map<String, dynamic>> fetchedData = List<Map<String, dynamic>>.from(value.data);
      for (var post in fetchedData) {
       if (post['type'] == 'open_question') {
          post['createdAt']=formatFacebookTime(post['createdAt']);

          openQuestionPost.add(post);
        }
      }

      if (fetchedData.length < 10) {
        hasMoreDataOpenQuestion = false;
      } else {
        currentPageOpenQuestion++;
      }

      emit(PostSucssessfullStateStatesOpenQuestion());
    }).catchError((error) {
      //int statusCode = error.response?.statusCode ?? -1;
      emit(PostErrorStateStatesOpenQuestion());
    });
  }
  void getPostForLocationAndServiceNextOpenQuestion( int page) {
    emit(PostLoadStateStatesNextOpenQuestion());
    _fetchPostsOpenQuestion(page);
  }

}