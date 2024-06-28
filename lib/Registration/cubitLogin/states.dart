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