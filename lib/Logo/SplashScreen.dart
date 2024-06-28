import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilled_handyworkers_marketpleace/Registration/LoginScreen.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';

import '../shared/styles/styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Spacer(),
                  Text("Jobspot",style: TextStyle(
                  fontWeight:
                  AppFontStyles.fontWeightSemiBold7,
                  fontSize: AppFontStyles
                      .smallAddressFontSize,
                  color:Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 100,),
              Center(child: Image.asset("assets/images/SplashScreen.png")),
              SizedBox(height: 80,),
              Text("1".toUpperCase().tr,style: TextStyle(
                  fontWeight:
                  AppFontStyles.fontWeightSemiBold7,
                  fontSize: AppFontStyles
                      .addressLargeFontSize,
                  color:Colors.black),
              ),
              Text("2".toUpperCase().tr,style: TextStyle(
                decoration: TextDecoration.underline,
                  decorationColor:AppColor.orangeColor ,
                  fontWeight:
                  AppFontStyles.fontWeightSemiBold7,
                  fontSize: AppFontStyles
                      .addressLargeFontSize,
                  color:AppColor.orangeColor),

              ),
              Text("3".toUpperCase().tr,style: TextStyle(
                  fontWeight:
                  AppFontStyles.fontWeightSemiBold7,
                  fontSize: AppFontStyles
                      .addressLargeFontSize,
                  color:Colors.black),
              ),
        Text(
          "4".tr,
          style: TextStyle(
              fontWeight: AppFontStyles.fontWeightMedium,
              fontSize: AppFontStyles.descriptionLoginFontSize,
              color: AppColor.fontColorDescription
          ),
        ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Spacer(),
                  FloatingActionButton(

                    onPressed: (){
                      navigateTo(
                        context: context,
                        widget: LoginScreen(),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(30),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    backgroundColor: AppColor.navyBlueColor,

                    child: Icon(color: Colors.white,
                    Icons.arrow_forward,
                  ),
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
