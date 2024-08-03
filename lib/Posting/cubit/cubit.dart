import 'package:flutter_bloc/flutter_bloc.dart';
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
    ).then((value)
    {
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(value.data);

    data.forEach((comment) {

      comment['publishedAt'] = formatFacebookTime(comment['publishedAt']);

    });
      post.addAll(data);
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
    {  List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(value.data);

    data.forEach((comment) {

      comment['publishedAt'] = formatFacebookTime(comment['publishedAt']);

    });
    openQuestion.addAll(data);

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
    ).then((value)
    {
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(value.data);

      data.forEach((comment) {

        comment['publishedAt'] = formatFacebookTime(comment['publishedAt']);

      });
      postCustomer.addAll(data);

      print("CustomerPostPostSucssessfullStateStates");
      emit(CustomerPostPostSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("CustomerPostPostErrorStateStates");
      emit(CustomerPostPostErrorStateStates(statusCode));
    });
  }
  void getOpenQuestionCustomer(String userId){
    emit(CustomerOpenQuestionPostLoadStateStates());
    print("CustomerOpenQuestionPostLoadStateStates");
    openQuestionCustomer.clear();
    DioHelper.getData(
      url:'post/$userId/open-questions',
    ).then((value)
    {
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(value.data);

      data.forEach((comment) {

        comment['publishedAt'] = formatFacebookTime(comment['publishedAt']);

      });
      openQuestionCustomer.addAll(data);
      print("CustomerOpenQuestionPostSucssessfullStateStates");
      emit(CustomerOpenQuestionPostSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("CustomerOpenQuestionPostErrorStateStates");
      emit(CustomerOpenQuestionPostErrorStateStates(statusCode));
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




  List<Map<String,dynamic>>favoritesPost=[];
  List<Map<String,dynamic>>favoritesOpenQuestion=[];

  bool favorite=false;

  void getFavorites(){
    emit(LoadingGetFavoritesDateState());
    print("LoadingGetFavoritesDateState");
    favoritesPost.clear();
    favoritesOpenQuestion.clear();
    DioHelper.getData(
      url:'/users/saved-posts',
      token:accessToken,
    ).then((value)
    {
      final List<Map<String, dynamic>> fetchedData = List<Map<String, dynamic>>.from(value.data);
      for (var post in fetchedData) {
        if (post['type'] == 'post') {
          post['publishedAt']=formatFacebookTime( post['publishedAt']);
          favoritesPost.add(post);
        } else if (post['type'] == 'open_question') {
          post['publishedAt']=formatFacebookTime( post['publishedAt']);
          favoritesOpenQuestion.add(post);
        }
      }       emit(SuccessGetFavoritesDateState());
    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      emit(ErrorGetFavoritesDateState(statusCode));
    });
  }
  void savePost(String idPost){
    favorite=true;
    emit(SaveLoadingFavoritesDateState());
    print("SaveLoadingFavoritesDateState");
    DioHelper.getData(
      url:'/post/save/$idPost',
      token: accessToken,
    ).then((value)
    {
      emit(SaveSuccessFavoritesDateState());
      getFavorites();
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
    DioHelper.getData(
      url:'/post/unsave/$idPost',
      token: accessToken,
    ).then((value)
    {
      emit(UnSaveSuccessFavoritesDateState());
      print("UnSaveSuccessFavoritesDateState");
      getFavorites();

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      emit(UnSaveErrorFavoritesDateState(statusCode));
      print("UnSaveErrorFavoritesDateState");
      favorite=true;
    });
  }


  String formatFacebookTime(String postTimeStr) {
    if (RegExp(r'^\d{1,2}:\d{2}:\d{2} [APM]{2}$').hasMatch(postTimeStr)) {
      // إذا كان التنسيق صحيحًا، نعيد الوقت كما هو
      return postTimeStr;
    }


    // إزالة الجزء الأخير الذي يحتوي على معلومات المنطقة الزمنية بين الأقواس
    postTimeStr = postTimeStr.split('(')[0].trim();

    // تحويل الوقت المستلم إلى كائن DateTime
    DateTime postTime = DateFormat("EEE MMM dd yyyy HH:mm:ss 'GMT'Z", 'en_US').parse(postTimeStr);
    print(postTime);
    // الحصول على الوقت الحالي (بتوقيت النظام المحلي)
    DateTime now = DateTime.now();

    print(now);
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


}