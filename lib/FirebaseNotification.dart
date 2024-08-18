import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomeS extends StatefulWidget {
  @override
  _HomeSState createState() => _HomeSState();
}

class _HomeSState extends State<HomeS> {
  @override
  void initState() {
    super.initState();
    _setupFCM();
  }

  Future<void> _setupFCM() async {
    // طلب الإذن من المستخدم لتلقي الإشعارات
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }

    // الحصول على التوكن
    String? token = await messaging.getToken();
    print("FCM Token: $token");

    // الاستماع إلى رسائل FCM
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message: ${message.notification?.title}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FCM Example')),
      body: Center(child: Text('FCM Example')),
    );
  }
}