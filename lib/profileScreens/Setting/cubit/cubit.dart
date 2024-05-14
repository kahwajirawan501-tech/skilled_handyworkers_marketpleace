import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Setting/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profileScreen.dart';

class SettingCubit extends Cubit<SettingStates> {
  SettingCubit() : super(SettingStatesInitialStateStates());

  static SettingCubit get(context) => BlocProvider.of(context);

  IconData oldSuffix=Icons.visibility_outlined;
  bool isOldPasswordShown=true;
  void changeOldPasswordVisibility(){
    isOldPasswordShown=!isOldPasswordShown;
    oldSuffix=isOldPasswordShown?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ChangeOldPassWordVisibilityState ());
  }

  IconData newSuffix=Icons.visibility_outlined;
  bool isNewPasswordShown=true;
  void changeNewPasswordVisibility(){
    isNewPasswordShown=!isNewPasswordShown;
    newSuffix=isNewPasswordShown?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ChangeNewPassWordVisibilityState ());
  }

  IconData configSuffix=Icons.visibility_outlined;
  bool isConfigPasswordShown=true;
  void changeConfigPasswordVisibility(){
    isConfigPasswordShown=!isConfigPasswordShown;
    configSuffix=isConfigPasswordShown?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ChangeConfigPassWordVisibilityState ());
  }

}