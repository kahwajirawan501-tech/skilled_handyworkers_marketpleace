import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/BottonNavigationBar.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/commintSceren.dart';
import 'package:skilled_handyworkers_marketpleace/HomeScreen/HomeScreen.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/TabBarScreen.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/informationCustomer.dart';
import 'package:skilled_handyworkers_marketpleace/Save/save.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Language/language.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Setting/setting.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profileScreen.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/skill/skill.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit ():super(HomeStatesInitialStateStates());
  static HomeCubit get(context)=>BlocProvider.of(context);

  // for BottomNavigationBar
  int selectedIndex=0;
   final List<Widget> pages = [
     HomeScreen(),
     ProfileScreen(),
     TabBarPosting() ,
     Save(),
     Save(),
     Save(),
   ];
  void onItemTappedForBottomNavigationBar(int index) {

      selectedIndex = index;
      print(selectedIndex);
  }
  /////////////////////
}