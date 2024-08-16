import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
}