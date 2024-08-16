import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
        token: accessToken
    ).then((value)
    {print("value.data");
      print(value.data);
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(value.data);

    data.forEach((comment) {

      comment['createdAt'] = formatFacebookTime(comment['createdAt']);

    });
      post.addAll(data);
      print("YourPostPostSucssessfullStateStates");
      emit(YourPostPostSucssessfullStateStates());

    }
    ).catchError((error){
     // int statusCode = error.response?.statusCode ?? -1;
      print("YourPostPostErrorStateStates");
      print(error.toString());
      emit(YourPostPostErrorStateStates());
    });
  }
 void getOpenQuestion(){
    emit(YourOpenQuestionPostLoadStateStates());
    print("YourOpenQuestionPostLoadStateStates");
    openQuestion.clear();
    DioHelper.getData(
      url:'post/$id/open-questions',
      token: accessToken
    ).then((value)
    {
      print(value.data);
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(value.data);
    data.forEach((comment) {
      comment['createdAt'] = formatFacebookTime(comment['createdAt']);
    });
    openQuestion.addAll(data);
      print("YourOpenQuestionPostSucssessfullStateStates");
      emit(YourOpenQuestionPostSucssessfullStateStates());
    }
    ).catchError((error){
      print(error.toString());
     // int statusCode = error.response?.statusCode ?? -1;
      print("YourOpenQuestionPostErrorStateStates");
      emit(YourOpenQuestionPostErrorStateStates());
    });
  }
  void deletePost(String id){
    emit(DeletePostLoadStateStates());
    print("DeletePostLoadStateStates");
    DioHelper.deletePost(
      url:'post/$id',
      token: accessToken
    ).then((value)
    {

      print("DeletePostSucssessfullStateStates");
      emit(DeletePostSucssessfullStateStates());
     getOpenQuestion();
     getPost();
     getFavorites();
    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("DeletePostErrorStateStates");
      print(error.toString());
      emit(DeletePostErrorStateStates(statusCode));
    });
  }

  final List<Map<String,dynamic>>postCustomer=[];
  final List<Map<String,dynamic>>openQuestionCustomer=[];

  void getPostCustomer(String userId){
    emit(CustomerPostPostLoadStateStates());
    print("CustomerPostPostLoadStateStates");
    postCustomer.clear();
    DioHelper.getData(
      url:'post/$userId/posts',
        token: accessToken
    ).then((value)
    {
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(value.data);

      data.forEach((comment) {

        comment['createdAt'] = formatFacebookTime(comment['createdAt']);

      });
      postCustomer.addAll(data);

      print("CustomerPostPostSucssessfullStateStates");
      emit(CustomerPostPostSucssessfullStateStates());

    }
    ).catchError((error){
     // int statusCode = error.response?.statusCode ?? -1;
      print("CustomerPostPostErrorStateStates");
      emit(CustomerPostPostErrorStateStates());
    });
  }
  void getOpenQuestionCustomer(String userId){
    emit(CustomerOpenQuestionPostLoadStateStates());
    print("CustomerOpenQuestionPostLoadStateStates");
    openQuestionCustomer.clear();
    DioHelper.getData(
      url:'post/$userId/open-questions',
        token: accessToken
    ).then((value)
    {
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(value.data);

      data.forEach((comment) {

        comment['createdAt'] = formatFacebookTime(comment['createdAt']);

      });
      openQuestionCustomer.addAll(data);
      print("CustomerOpenQuestionPostSucssessfullStateStates");
      emit(CustomerOpenQuestionPostSucssessfullStateStates());

    }
    ).catchError((error){
     // int statusCode = error.response?.statusCode ?? -1;
      print("CustomerOpenQuestionPostErrorStateStates");
      emit(CustomerOpenQuestionPostErrorStateStates());
    });
  }
  Map<String,dynamic>information={};
  Future<void>getProfileInformationCustomer(String idUser)async{
    emit(GetInformationStatesLoadingStateStates());
    print("GetInformationStatesLoadingStateStates");
    await  DioHelper.getData2(
      url:'/users/$idUser',

    ).then((value)
    {
      print("Response received");
      print("Data: ${value.data}");
      // Check if the response contains the expected data
      if (value.data != null ) {
        information=Map<String,dynamic>.from(value.data);
        print("GetInformationSucssessfullStateStates");
        emit(GetInformationSucssessfullStateStates());
      } else {
        print("GetInformationErrorStateStates");
        emit(GetInformationErrorStateStates());
      }


    }
    ).catchError((error){
     // int statusCode = error.response?.statusCode ?? -1;
      print(error.toString());

      print("GetInformationErrorStateStates");
      emit(GetInformationErrorStateStates());
    });
  }




  List<Map<String,dynamic>>favoritesPost=[];
  List<Map<String,dynamic>>favoritesOpenQuestion=[];

  bool favorite=false;

  void getFavorites(){
    emit(LoadingGetFavoritesDateState());
    print("LoadingGetFavoritesDateState");
    favoritesPost.clear();
    favoritesOpenQuestion.clear();
    DioHelper.getData(
      url:'/favorite-post/all',
      token: accessToken
    ).then((value)
    {
       //print(value.data);
      final List<Map<String, dynamic>> fetchedData = List<Map<String, dynamic>>.from(value.data);
      for (var post in fetchedData) {
        if (post['type'] == 'post') {
          post['createdAt']=formatFacebookTime( post['createdAt']);
          favoritesPost.add(post);
        } else if (post['type'] == 'open_question') {
          post['createdAt']=formatFacebookTime( post['createdAt']);
          favoritesOpenQuestion.add(post);
        }
      }
      print(favoritesOpenQuestion);
      emit(SuccessGetFavoritesDateState());
    }
    ).catchError((error){
   //   int statusCode = error.response?.statusCode ?? -1;
      emit(ErrorGetFavoritesDateState());
      print("ErrorGetFavoritesDateState");
      print(error.toString());
    });
  }
  void savePost(String idPost){
    favorite=true;
    emit(SaveLoadingFavoritesDateState());
    print("SaveLoadingFavoritesDateState");
    DioHelper.postData(
      url:'/favorite-post/create',
      data: {
        "postId":idPost
      },
      token: accessToken,
    ).then((value)
    {
      emit(SaveSuccessFavoritesDateState());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      emit(SaveErrorFavoritesDateState(statusCode));
      favorite=false;
    });
  }
  void unSavePost(String idPost){
    favorite=false;
    emit(UnSaveLoadingFavoritesDateState());
    print("UnSaveLoadingFavoritesDateState");
    DioHelper.deletePost(
      url:'/favorite-post/$idPost',
      token: accessToken,
    ).then((value)
    {
      emit(UnSaveSuccessFavoritesDateState());
      print("UnSaveSuccessFavoritesDateState");

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      emit(UnSaveErrorFavoritesDateState(statusCode));
      print("UnSaveErrorFavoritesDateState");
      favorite=true;
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