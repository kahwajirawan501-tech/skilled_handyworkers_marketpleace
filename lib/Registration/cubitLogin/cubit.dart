import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Registration/cubitLogin/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';

import '../../Model/LoginModel.dart';
import '../../shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialStateStates());

  static LoginCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.visibility_off_outlined;
  bool isPasswordShown = true;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = !isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePassWordVisibilityState());
  }

  bool isFilterActive = false;

  void chickLog() {
    isFilterActive = !isFilterActive;
    emit(LoginIsPasswordStateStates(isFilterActive));
  }


  Future<void> login({
    required String email,
    required String password,
  }) async {
    //هل لح اكتبن بايدي طبعا لا لح اخدن من اليوزر
    emit(LoginSkilledLoadingState());
    print("UserLoadingState");

    print("respons");

    await DioHelper.postData(url: "auth/signin", data: {
      'email': email,
      'password': password,
    } //post=>body=>from_data

        ).then((value) {
      print("data");
      print(value.data);
      emit(LoginSkilledSuccessState(value.data['token'], value.statusCode));
      print("UserSuccessState");
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;

      emit(LoginSkilledErrorState(statusCode));
      print(error);
      print(statusCode);
    });
  }

////////////////////////////////////////////////////////////////////////////////////
  Future<void> sendEmailForget({
    required String email,
  }) async {
    emit(ForgotPassSkilledLoadingState());

    DioHelper.postData(url: 'auth/forgot-password', data: {
      'email': email,
    }).then((value) {
      print("send email succ");

      emit(ForgotPassSkilledSuccessState(value.statusCode));
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;

      emit(ForgotPassSkilledErrorState(statusCode));

      print(statusCode);
    });
  }

///////////////////////////
  void ResetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) {
    emit(ChangePassSkilledLoadingState());

    DioHelper.postData(url: 'auth/reset-password', data: {
      'email': email,
      'token': token,
      'newPassword': newPassword,
    }).then((value) {
      emit(ChangePassSkilledSuccessState(value.statusCode));
      print("object");
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;

      emit(ChangePassSkilledErrorState(statusCode));
      print("roaa");
      print(statusCode);
    });
  }
  //////////////////////////////////////////////////////////////////////////
  Future<void> sendEmailConfirm({
    required String email,
    required String code ,
  }) async {
    emit(EmailConfirmSkilledLoadingState());

    DioHelper.postData(url: 'auth/signup_confiramtion', data: {
      'email': email,
      'code' :code,
    }).then((value) {
      print("send email succ");
      print(value.data);
      emit(EmailConfirmSkilledSuccessState(value.statusCode,value.data['token']));
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;

      emit(EmailConfirmSkilledErrorState(statusCode));

      print(statusCode);
    });
  }


}
