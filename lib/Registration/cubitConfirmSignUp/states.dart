import 'package:skilled_handyworkers_marketpleace/Model/signUpModel.dart';

import '../../Model/LoginModel.dart';

abstract class ConfirmSignUpStates {}

class ConfirmSignUpInitialStateStates extends ConfirmSignUpStates {}

class ConfirmSignUpSkilledLoadingState extends ConfirmSignUpStates {}

class ConfirmSignUpSkilledSuccessState extends ConfirmSignUpStates {

  var value;

  ConfirmSignUpSkilledSuccessState( this.value);
}

class ConfirmSignUpSkilledErrorState extends ConfirmSignUpStates {
  var error;

  ConfirmSignUpSkilledErrorState(this.error);
}
