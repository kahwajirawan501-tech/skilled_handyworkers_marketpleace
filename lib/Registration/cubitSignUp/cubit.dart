import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Model/signUpModel.dart';
import 'package:skilled_handyworkers_marketpleace/Registration/cubitSignUp/states.dart';

import '../../shared/network/local/cache_helper.dart';
import '../../shared/network/remote/dio_helper.dart';

class SignUplCubit extends Cubit<SignUpStates> {
  SignUplCubit() : super(SignUpInitialStateStates());

  static SignUplCubit get(context) => BlocProvider.of(context);

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

  late SignUpModel signUpModel;

  void userSignUp({
    required String fullName,
    required String email,
    required String password,


  }) {
    //هل لح اكتبن بايدي طبعا لا لح اخدن من اليوزر
    emit(SignUpSkilledLoadingState());
    print("SignUpSkilledLoadingState");

    DioHelper.postData(url: "auth/signup", data: {
      'fullName': fullName,
      'email': email,
      'password': password,

    } //post=>body=>from_data
    ).then((value) {
      print("data");

      signUpModel = SignUpModel.fromJson(value.data);
      emit(SignUpSkilledSuccessState(signUpModel, value.statusCode));
      print("UserSuccessState");
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      print("object");
      print(error.response.toString()+"asdfghjk");
      print(error.toString);
      emit(SignUpSkilledErrorState(statusCode));

      print(statusCode);
    });
  }
}