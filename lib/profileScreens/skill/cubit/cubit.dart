import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profileScreen.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/skill/cubit/states.dart';

class SkillCubit extends Cubit<SkillStates> {
  SkillCubit() : super(SkillSucssessfullStateStates());

  static SkillCubit get(context) => BlocProvider.of(context);
  List<String>skill=[
    "Accounting & Finance",
    "Animal Care",
    "Art,Media,Design",
    "Bar Staff",
    "Barista",
    "Chef & Cook",
    "Cleaning",
    "Construction & Trades",
    "Customer Service",
    "Driver & Delivery",
    "Education",
    "Engineering",
  ];
  
}