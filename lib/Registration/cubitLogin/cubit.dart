import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Registration/cubitLogin/states.dart';


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

  late LoginModel loginModel;

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

      loginModel = LoginModel.fromJson(value.data);
      print(loginModel);
      emit(LoginSkilledSuccessState(loginModel, value.statusCode));
      print("UserSuccessState");
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;

      emit(LoginSkilledErrorState(statusCode));
      print(error);
      print(statusCode);
    });
  }
}
