import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skilled_handyworkers_marketpleace/Logo/SplashScreen.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';

import '../shared/styles/styles.dart';

class LogoScreen extends StatefulWidget {
  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3), // تحديد مدة الشاشة الفارغة بالثواني
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SplashScreen(), // يتم التوجيه إلى الشاشة الرئيسية بعد انتهاء الوقت المحدد
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColor.navyBlueColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 350.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image.asset("assets/images/smile.png",)),
            SizedBox(height: 8,),
            Text("Jobspot",style: TextStyle(
                fontWeight:
                AppFontStyles.fontWeightSemiBold7,
                fontSize: AppFontStyles
                    .smallAddressFontSize,
                color:Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}