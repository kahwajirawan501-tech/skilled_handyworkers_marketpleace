import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Setting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profileScreen.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/skill/cubit/cubit.dart';


import 'StartScreen/StartScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(

          create:(context) =>SkillCubit(),


        ),
        BlocProvider(

          create:(context) =>SettingCubit(),


        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        home: ProfileScreen(),
      ),
    );
  }
}