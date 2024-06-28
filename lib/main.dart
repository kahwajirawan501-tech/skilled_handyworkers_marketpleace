import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/AddPosting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/BottonNavigationBar.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/ListOfPosting.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/TabBarScreen.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/postModel.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/cubitLocation/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/cubitService/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/AddPosting/addPost.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Setting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profileScreen.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/skill/cubit/cubit.dart';


import 'SearchModel/searchService.dart';
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
        BlocProvider(

          create:(context) =>HomeCubit(),


        ),
        BlocProvider(

          create:(context) =>ServiceCubit(),


        ),
        BlocProvider(

          create:(context) =>LocationCubit(),


        ),
        BlocProvider(

          create:(context) =>CubitSearch(),


        ),
        BlocProvider(

          create:(context) =>CommitCubit(),


        ),
        BlocProvider(

          create:(context) =>CubitYourPost(),


        ),
        BlocProvider(

          create:(context) =>AddPostCubit(),


        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        home:BottomNavigationScreen(),

      ),
    );
  }
}