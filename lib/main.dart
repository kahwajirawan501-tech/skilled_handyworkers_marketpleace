import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/AddPosting/cubit/cubit.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:skilled_handyworkers_marketpleace/Registration/cubitSignUp/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Setting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profileScreen.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/skill/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/local/cache_helper.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/local/local.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/local/local_controller.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';
import 'package:get/get.dart';
import 'Registration/LoginScreen.dart';
import 'Registration/cubitConfirmSignUp/cubit.dart';
import 'Registration/cubitLogin/cubit.dart';
import 'StartScreen/StartScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Get.lazyPut<MyLocalController>(() => MyLocalController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MyLocalController controller = MyLocalController();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SkillCubit(),
        ),
        BlocProvider(
          create: (context) => SettingCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => SignUplCubit(),
        ),
        BlocProvider(
          create: (context) => ConfirmSignUpCubit(),
        ),
        BlocProvider(

          create:(context) =>AddPostCubit(),


        )
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Skilled handyWorker marketplace System',
        locale: controller.intiallang,
        translations: MyLocal(),
        home: LoginScreen(),
      ),
    );
  }
}
