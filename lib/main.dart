import 'dart:typed_data';
import 'firebase_options.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:skilled_handyworkers_marketpleace/AddPosting/cubit/cubit.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/BottonNavigationBar.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Chat_Messages/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/dashboard.dart';
import 'package:skilled_handyworkers_marketpleace/EditPost/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Chat_Messages/Message.dart';
import 'package:skilled_handyworkers_marketpleace/FirebaseNotification.dart';
import 'package:skilled_handyworkers_marketpleace/Logo/Logo.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Registration/cubitSignUp/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/cubitLocation/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/cubitService/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Setting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profileScreen.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/skill/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/local/cache_helper.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/local/local.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/local/local_controller.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';
import 'package:get/get.dart';
import 'Registration/LoginScreen.dart';
import 'Registration/cubitConfirmSignUp/cubit.dart';
import 'Registration/cubitLogin/cubit.dart';
import 'StartScreen/StartScreen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  requestNotificationPermission();
  await initializeNotifications();
  await initializeDateFormatting('en_US', null);
  DioHelper.init();
  await CacheHelper.init();
  Get.lazyPut<MyLocalController>(() => MyLocalController());
  runApp(const MyApp());

}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
  // يمكنك هنا التعامل مع الإشعار مثل حفظ البيانات في قاعدة البيانات أو تنفيذ أي عملية أخرى
}
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> requestNotificationPermission() async {
  final status = await Permission.notification.request();
  if (status.isGranted) {
    print("Notification permission granted");
  } else {
    print("Notification permission denied");
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MyLocalController controller = MyLocalController();


    // إعداد استماع للإشعارات عند وصولها في المقدمة
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('On Message: ${message.messageId}');
      if (message.notification != null) {
        print('Notification Title: ${message.notification!.title}');
        print('Notification Body: ${message.notification!.body}');
        // هنا يمكنك استخدام FlutterLocalNotificationsPlugin لإظهار إشعار محلي عند تلقي إشعار من Firebase
        _showForegroundNotification(message);
      }
    });

    // إعداد استماع للإشعارات عند فتح التطبيق من إشعار
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('On Message Opened App: ${message.messageId}');
      // التعامل مع الإشعار عندما يفتح المستخدم التطبيق من إشعار
    });

    return MultiBlocProvider(
      providers: [
        BlocProvider(

          create:(context) =>SkillCubit(),


        ),

        BlocProvider(

          create:(context) =>ProfileCubit(),


        ),
        BlocProvider(

          create:(context) =>SettingCubit(),


        ),
        BlocProvider(

          create:(context) =>HomeCubit(),


        ),
        BlocProvider(

          create:(context) =>ServiceCubit()..getService(),


        ),
        BlocProvider(

          create:(context) =>LocationCubit()..getLocation(),


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


        ),
        BlocProvider(

          create:(context) =>EditPostCubit(),


        ),
        BlocProvider(

          create:(context) =>ChatCubit(),


        )
        ,
        BlocProvider(

          create:(context) =>DashBoardCubit(),


        )
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Skilled handyWorker marketplace System',
        locale:controller.intiallang,
        translations: MyLocal(),
        home: Dashboard(),
      ),
    );
  }
  void _showForegroundNotification(RemoteMessage message) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: message.data['payload'],
    );
  }


}
