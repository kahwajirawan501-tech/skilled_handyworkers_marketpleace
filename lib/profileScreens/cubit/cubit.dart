import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profileScreen.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileStatesInitialStateStates());

  static ProfileCubit get(context) => BlocProvider.of(context);

  void editProfile(File image,String fullName,String dataOfBirth,String gender,
      String email,String number,String location,String service){
    emit(EditProfileStatesLoadingStateStates());
    print("EditProfileStatesLoadingStateStates");
    DioHelper.postData(
        url:'',
        token: '',
        data: {

        }
    ).then((value)
    {
      print("EditProfileSucssessfullStateStates");
      emit(EditProfileSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("EditProfileErrorStateStates");
      emit(EditProfileErrorStateStates(statusCode));
    });
  }


  void addAboutMy(String text){
    emit(AboutMeStatesLoadingStateStates());
    print("AboutMeStatesLoadingStateStates");
    DioHelper.postData(
      url:'',
      token: '',
      data: {
        'text':text
      }
    ).then((value)
    {
      print("AboutMeSucssessfullStateStates");
      emit(AboutMeSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("AboutMeErrorStateStates");
      emit(AboutMeErrorStateStates(statusCode));
    });
  }
  void editAboutMy(String text){
    emit(EditAboutMeStatesLoadingStateStates());
    print("EditAboutMeStatesLoadingStateStates");
    DioHelper.postData(
        url:'',
        token: '',
        data: {
          'text':text
        }
    ).then((value)
    {
      print("EditAboutMeSucssessfullStateStates");
      emit(EditAboutMeSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("EditAboutMeErrorStateStates");
      emit(EditAboutMeErrorStateStates(statusCode));
    });
  }




  void addWorkExperience(String title,String description){
    emit(WorkExperienceStatesLoadingStateStates());
    print("WorkExperienceStatesLoadingStateStates");
    DioHelper.postData(
        url:'',
        token: '',
        data: {
          'title':title,
          'description':description
        }
    ).then((value)
    {
      print("WorkExperienceSucssessfullStateStates");
      emit(AboutMeSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("WorkExperienceErrorStateStates");
      emit(WorkExperienceErrorStateStates(statusCode));
    });
  }
  void editWorkExperience(String title,String description){
    emit(EditWorkExperienceStatesLoadingStateStates());
    print("EditWorkExperienceStatesLoadingStateStates");
    DioHelper.postData(
        url:'',
        token: '',
        data: {
          'title':title,
          'description':description
        }
    ).then((value)
    {
      print("EditWorkExperienceSucssessfullStateStates");
      emit(EditAboutMeSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("EditWorkExperienceErrorStateStates");
      emit(EditWorkExperienceErrorStateStates(statusCode));
    });
  }




  void addEducation(String title,String description){
    emit(EducationStatesLoadingStateStates());
    print("EducationStatesLoadingStateStates");
    DioHelper.postData(
        url:'',
        token: '',
        data: {
          'title':title,
          'description':description
        }
    ).then((value)
    {
      print("EducationSucssessfullStateStates");
      emit(EducationSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("EducationErrorStateStates");
      emit(EducationErrorStateStates(statusCode));
    });
  }
  void editEducation(String title,String description){
    emit(EditEducationStatesLoadingStateStates());
    print("EditEducationStatesLoadingStateStates");
    DioHelper.postData(
        url:'',
        token: '',
        data: {
          'title':title,
          'description':description
        }
    ).then((value)
    {
      print("EditEducationSucssessfullStateStates");
      emit(EditEducationSucssessfullStateStates());

    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("EditEducationErrorStateStates");
      emit(EditEducationErrorStateStates(statusCode));
    });
  }




}