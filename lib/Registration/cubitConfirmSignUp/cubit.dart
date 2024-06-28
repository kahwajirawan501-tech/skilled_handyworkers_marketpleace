

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Registration/cubitConfirmSignUp/states.dart';

import '../../shared/network/remote/dio_helper.dart';

class ConfirmSignUpCubit extends Cubit<ConfirmSignUpStates> {
  ConfirmSignUpCubit() : super(ConfirmSignUpInitialStateStates());

  static ConfirmSignUpCubit get(context) => BlocProvider.of(context);

  void sendCode({
    required String email,
   // required String code,
  }) {
    emit(ConfirmSignUpSkilledLoadingState());

    DioHelper.postData(url: 'auth/signup_confiramtion', data: {
      'email': email,
    //  'code': code,
    }).then((value) {
      print("send email succ");
      print(value.data);
      emit(ConfirmSignUpSkilledSuccessState(value.statusCode));
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;

      emit(ConfirmSignUpSkilledErrorState(statusCode));
      print(error);
      print(statusCode);
    });
  }
}
