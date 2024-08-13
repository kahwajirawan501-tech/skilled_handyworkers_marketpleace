import '../../Model/LoginModel.dart';

abstract class LoginStates {}

class LoginInitialStateStates extends LoginStates {}
class LoginSkilledLoadingState extends LoginStates {}
class LoginSkilledSuccessState extends LoginStates {
  final LoginModel loginModel;
  var value;
  LoginSkilledSuccessState(this.loginModel,this.value);


}
class LoginSkilledErrorState extends LoginStates {
  var error;

  LoginSkilledErrorState(this.error);
}

class LoginIsPasswordStateStates extends LoginStates {
   bool isPassword = true;

  LoginIsPasswordStateStates(this.isPassword);
}
class LoginCreateStates extends LoginStates {
  bool isFilterActive = true;

  LoginCreateStates(this.isFilterActive);
}
class ChangePassWordVisibilityState extends LoginStates{}
/////////////////////////////////////////////////////////////////////////////////
class ForgotPassInitialStateStates extends LoginStates {}
class ForgotPassSkilledLoadingState extends LoginStates {}
class ForgotPassSkilledSuccessState extends LoginStates {

  var value;
  ForgotPassSkilledSuccessState(this.value);


}
class ForgotPassSkilledErrorState extends LoginStates {
  var error;

  ForgotPassSkilledErrorState(this.error);
}
////////////////////////////////////////////////////////////////////////////////
class ChangePassInitialStateStates extends LoginStates {}
class ChangePassSkilledLoadingState extends LoginStates {}
class ChangePassSkilledSuccessState extends LoginStates {

  var value;
  ChangePassSkilledSuccessState(this.value);


}
class ChangePassSkilledErrorState extends LoginStates {
  var error;

  ChangePassSkilledErrorState(this.error);
}

////////////////////////////////////////////////////////////////////////////////
class EmailConfirmInitialStateStates extends LoginStates {}
class EmailConfirmSkilledLoadingState extends LoginStates {}
class EmailConfirmSkilledSuccessState extends LoginStates {

  var value;
  EmailConfirmSkilledSuccessState(this.value);


}
class EmailConfirmSkilledErrorState extends LoginStates {
  var error;

  EmailConfirmSkilledErrorState(this.error);
}