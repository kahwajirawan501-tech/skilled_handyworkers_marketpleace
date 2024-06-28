import 'package:skilled_handyworkers_marketpleace/Model/signUpModel.dart';

import '../../Model/LoginModel.dart';

abstract class SignUpStates {}

class SignUpInitialStateStates extends SignUpStates {}

class SignUpSkilledLoadingState extends SignUpStates {}

class SignUpSkilledSuccessState extends SignUpStates {
  final SignUpModel signUpModel;
  var value;

  SignUpSkilledSuccessState(this.signUpModel, this.value);
}

class SignUpSkilledErrorState extends SignUpStates {
  var error;

  SignUpSkilledErrorState(this.error);
}


class LoginIsPasswordStateStates extends SignUpStates {
  bool isPassword = true;

  LoginIsPasswordStateStates(this.isPassword);
}
class LoginCreateStates extends SignUpStates {
  bool isFilterActive = true;

  LoginCreateStates(this.isFilterActive);
}
class ChangePassWordVisibilityState extends SignUpStates{}