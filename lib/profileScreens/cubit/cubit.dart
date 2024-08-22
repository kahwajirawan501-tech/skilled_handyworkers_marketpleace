import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profileScreen.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';
import 'package:path/path.dart' as p;

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileStatesInitialStateStates());

  static ProfileCubit get(context) => BlocProvider.of(context);

  void editProfile(String imagee,String fullName,String dataOfBirth,String genderr,
      String email,String number,String location,String service,String role){
    emit(EditProfileStatesLoadingStateStates());
    print("EditProfileStatesLoadingStateStates");
    print(genderr);
    Map<String, dynamic> data = {};
    if (imagee.isNotEmpty) data['profileImage'] = imagee;
    if (fullName.isNotEmpty) data['fullName'] = fullName;
    if (email.isNotEmpty) data['email'] = email;
    if (dataOfBirth.isNotEmpty) data['dateOfBirth'] = dataOfBirth;
    if (genderr.isNotEmpty) data['gender'] = genderr;
   if (location.isNotEmpty) data['location'] = location;
    if (number.isNotEmpty) data['phoneNumber'] = number;
   if (service.isNotEmpty) data['skills'] = service;
    if (role.isNotEmpty) data['role'] = role;
    DioHelper.putData(
        url:'/users',
        token:accessToken,
        data:data
    ).then((value)
    { print("Response received");
    print("Data: ${value.data}");
    //Check if the response contains the expected data
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
      print("EditProfileSucssessfullStateStates");
      emit(EditProfileSucssessfullStateStates());

    }
      }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print(error.toString());
      print("EditProfileErrorStateStates");
      emit(EditProfileErrorStateStates(statusCode));
    });
  }

  String image="";
  Future<void> postFile(File images) async {
    emit(PostFileLoadStateStates());
    print("PostFileLoadStateStates");

  print(images);
    FormData formData = FormData.fromMap({
      'files': await MultipartFile.fromFile(images.path),
    });

    await  DioHelper.postDataWithFormData(
        url: 'upload/post',
        data: formData,
        token:accessToken
    ).then((value) {
      print(value.data);

      List<dynamic> responseData = value.data;

      for (var fileData in responseData) {
        String originalName = fileData['originalname'];
        String filePath = fileData['path'];
        String extension = p.extension(originalName).toLowerCase();
        image=filePath;
      }

      print("PostFileSucssessfullStateStates");
      emit(PostFileSucssessfullStateStates());
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      print("PostFileErrorStateStates");
      emit(PostFileErrorStateStates(statusCode,error.response.data['message']));
    });
  }




  Map<String,dynamic>aboutMyMap={};
  void addAboutMy(String text){
    emit(AboutMeStatesLoadingStateStates());
    print("AboutMeStatesLoadingStateStates");
    aboutMyMap.clear();
    DioHelper.postData(
      url:'/users/about',
      token: accessToken,
      data: {
        'aboutMe':text,

      }
    ).then((value)
    {
      print("Response received");
      print("Data: ${value.data}");
      // Check if the response contains the expected data
      if (value.data != null && value.data['aboutMe'] != null) {
        aboutMy = value.data['aboutMe'];
        print("AboutMeSucssessfullStateStates");
        emit(AboutMeSucssessfullStateStates());
      } else {
        print("AboutMeErrorStateStates");
        emit(AboutMeErrorStateStates(0));
      }


    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print(error.toString());

      print("AboutMeErrorStateStates");
      emit(AboutMeErrorStateStates(statusCode));
    });
  }
  void editAboutMy(String text){
    emit(EditAboutMeStatesLoadingStateStates());
    print("EditAboutMeStatesLoadingStateStates");
    aboutMyMap.clear();
    print(text);
    DioHelper.putData(
        url:'/users/about',
        token:accessToken,
        data: {
          'aboutMe':text
        }
    ).then((value)
    {
      print("Response received");
      print("Data: ${value.data}");
      // Check if the response contains the expected data
      if (value.data != null && value.data['aboutMe'] != null) {
        aboutMy = value.data['aboutMe'];
        print("EditAboutMeSuccessfulState emitted");
        emit(EditAboutMeSucssessfullStateStates());
      } else {
        print("Unexpected response data format");
        emit(EditAboutMeErrorStateStates(9));
      }
    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("EditAboutMeErrorStateStates");
      print(error.toString());
      emit(EditAboutMeErrorStateStates(statusCode));
    });
  }




  Future<void> addWorkExperience(String title,String description)async{
    emit(WorkExperienceStatesLoadingStateStates());
    print("WorkExperienceStatesLoadingStateStates");
 await   DioHelper.postData(
        url:'/users/jop',
        token: accessToken,
        data: {
          'jobTitle':title,
          'jobDescription':description
        }
    ).then((value)
    {
      print("Response received");
      print("Data: ${value.data}");
      // Check if the response contains the expected data
      if (value.data != null && value.data['jobTitle'] != null||value.data['jobDescription'] != null) {
        workTittle = value.data['jobTitle'];
        workDescription=value.data['jobDescription'];
        print("WorkExperienceSucssessfullStateStates");
        emit(WorkExperienceSucssessfullStateStates());
      } else {
        print("WorkExperienceErrorStateStates");
        emit(WorkExperienceErrorStateStates(0));
      }


    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("WorkExperienceErrorStateStates");
      emit(WorkExperienceErrorStateStates(statusCode));
    });
  }
  Future<void> editWorkExperience(String title,String description)async{
    emit(EditWorkExperienceStatesLoadingStateStates());
    print("EditWorkExperienceStatesLoadingStateStates");
    print(title);
    print(description);
   await DioHelper.putData(
        url:'/users/jop',
        token: accessToken,
        data: {
          'jobTitle':title,
          'jobDescription':description
        }
    ).then((value)
    {
      print("Response received");
      print("Data: ${value.data}");
      // Check if the response contains the expected data
      if (value.data != null && value.data['jobTitle'] != null||value.data['jobDescription'] != null) {
        workTittle = value.data['jobTitle'];
        workDescription=value.data['jobDescription'];
        print("EditWorkExperienceSucssessfullStateStates");
        emit(EditWorkExperienceSucssessfullStateStates());
      } else {
        print("EditWorkExperienceErrorStateStates");
        emit(EditWorkExperienceErrorStateStates(0));
      }


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
        url:'/users/institution',
        token: accessToken,
        data: {
          'institutionName':title,
          'institutionDescription':description
        }
    ).then((value)
    {
      print("Response received");
      print("Data: ${value.data}");
      // Check if the response contains the expected data
      if (value.data != null && value.data['institutionName'] != null||value.data['institutionDescription'] != null) {
        educationTittle = value.data['jobTitle'];
        educationDescription=value.data['jobDescription'];
        print("EducationSucssessfullStateStates");
        emit(EducationSucssessfullStateStates());
      } else {
        print("EducationErrorStateStates");
        emit(EducationErrorStateStates(0));
      }



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
    DioHelper.putData(
        url:'/users/institution',
        token: accessToken,
        data: {
          'institutionName':title,
          'institutionDescription':description
        }
    ).then((value)
    {
      print("Response received");
      print("Data: ${value.data}");
      // Check if the response contains the expected data
      if (value.data != null && value.data['institutionName'] != null||value.data['institutionDescription'] != null) {
        educationTittle = value.data['institutionName'];
        educationDescription=value.data['institutionDescription'];
        print("EditEducationSucssessfullStateStates");
        emit(EditEducationSucssessfullStateStates());
      } else {
        print("EditEducationErrorStateStates");
        emit(EditEducationErrorStateStates(0));
      }


    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      print("EditEducationErrorStateStates");
      emit(EditEducationErrorStateStates(statusCode));
    });
  }




}