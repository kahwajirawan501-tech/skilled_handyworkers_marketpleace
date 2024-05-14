import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Setting/password.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profileScreen.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isNotificationSwitched = false;
 bool isDartModeSwitched=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(
          icon:Icon( Icons.arrow_back,color: AppColor.arrowBackColor,),
          onPressed: () {
            navigateAndFinish(widget:const ProfileScreen() ,context: context);
          },

        ),
        elevation: 0.0,
        backgroundColor: AppColor.backgroundColor,
      ),
      body:Stack(

        children: [
          Container(
            color:AppColor.backgroundColor ,
            height: double.infinity,
            width: double.infinity,
            child:  SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(AppFontStyles.padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Settings",style: TextStyle(
                        fontSize:AppFontStyles.aboutMe,
                        fontWeight:   AppFontStyles.fontWeightSemiBold,
                        color: AppColor.bluColor
                    ),),
                    const SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle,),
                    Box(
                      borderRadius: BorderRadius.circular(AppFontStyles.borderRadiusTextField),
                      height: 60,
                      widget:Padding(
                        padding: const EdgeInsets.all( AppFontStyles.padding-8),
                        child: Row(
                          children: [
                            Image.asset("assets/images/notification.png"),
                            const SizedBox(width: 12,),
                            Text("Notification",style: TextStyle(
                                fontSize: AppFontStyles.descriptionLoginFontSize,
                                color:AppColor.navyBlueColor
                            ),),
                            Spacer(),
                            Transform.scale(
                              scale: 0.7,
                              child: Switch(
                                materialTapTargetSize: MaterialTapTargetSize.padded, // تغيير حجم العرض

                                value: isNotificationSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isNotificationSwitched = value;
                                  });
                                },

                                thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                                  if (!isNotificationSwitched) {
                                    return AppColor.thumbColor; // لون الدائرة في حالة الإيقاف
                                  }
                                  return Colors.white; // لون الدائرة في حالة التشغيل
                                }),
                                //overlayColor: MaterialStateProperty.all(Colors.transparent), // إزالة الخط الغامق
                                trackColor:MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                                  if (!isNotificationSwitched) {
                                    return AppColor.inactiveTrackColor; // لون الدائرة في حالة الإيقاف
                                  }
                                  return AppColor.greenColor; // لون الدائرة في حالة التشغيل
                                }),//لون الداخل
                                trackOutlineColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                                  if (!isNotificationSwitched) {
                                    return AppColor.inactiveTrackColor; // لون لخط في حالة الإيقاف
                                  }
                                  return AppColor.greenColor; // لون لخط في حالة التشغيل
                                }),
                              ),
                            ),

                          ],
                        ),
                      ),),//Notification
                    const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle,),
                    Box(
                      borderRadius: BorderRadius.circular(AppFontStyles.borderRadiusTextField),
                      height: 60,
                      widget:Padding(
                        padding: const EdgeInsets.all( AppFontStyles.padding-8),
                        child: Row(
                          children: [
                            Image.asset("assets/images/Subtract.png"),
                            const SizedBox(width: 12,),
                            Text("Dark mode",style: TextStyle(
                                fontSize: AppFontStyles.descriptionLoginFontSize,
                                color:AppColor.navyBlueColor
                            ),),
                            Spacer(),
                            Transform.scale(
                              scale: 0.7,
                              child: Switch(
                                materialTapTargetSize: MaterialTapTargetSize.padded, // تغيير حجم العرض

                                value: isDartModeSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isDartModeSwitched = value;
                                  });
                                },

                                thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                                  if (!isDartModeSwitched) {
                                    return AppColor.thumbColor; // لون الدائرة في حالة الإيقاف
                                  }
                                  return Colors.white; // لون الدائرة في حالة التشغيل
                                }),
                                //overlayColor: MaterialStateProperty.all(Colors.transparent), // إزالة الخط الغامق
                                trackColor:MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                                  if (!isDartModeSwitched) {
                                    return AppColor.inactiveTrackColor; // لون الدائرة في حالة الإيقاف
                                  }
                                  return AppColor.greenColor; // لون الدائرة في حالة التشغيل
                                }),//لون الداخل
                                trackOutlineColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                                  if (!isDartModeSwitched) {
                                    return AppColor.inactiveTrackColor; // لون لخط في حالة الإيقاف
                                  }
                                  return AppColor.greenColor; // لون لخط في حالة التشغيل
                                }),
                              ),
                            ),


                          ],
                        ),
                      ),),//Dark mode
                    const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle,),
                    Box(
                      borderRadius: BorderRadius.circular(AppFontStyles.borderRadiusTextField),
                      height: 60,
                      widget:Padding(
                        padding: const EdgeInsets.all( AppFontStyles.padding-8),
                        child: Row(
                          children: [
                            Image.asset("assets/images/IconDartLight.png"),
                            const SizedBox(width: 12,),
                            Text("Password",style: TextStyle(
                                fontSize: AppFontStyles.descriptionLoginFontSize,
                                color:AppColor.navyBlueColor
                            ),),
                            Spacer(),
                            IconButton(
                              onPressed:() {
                            navigateTo(context: context,widget: PassWord());
                              }, icon:Icon(Icons.arrow_forward_ios_outlined),
                              color: AppColor.navyBlueColor,iconSize: 12,)

                          ],
                        ),
                      ),),//Password
                    const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle,),
                    Box(
                      borderRadius: BorderRadius.circular(AppFontStyles.borderRadiusTextField),
                      height: 60,
                      widget:Padding(
                        padding: const EdgeInsets.all( AppFontStyles.padding-8),
                        child: Row(
                          children: [
                            Image.asset("assets/images/Iconlogout.png"),
                            const SizedBox(width: 12,),
                            Text("Logout",style: TextStyle(
                                fontSize: AppFontStyles.descriptionLoginFontSize,
                                color:AppColor.navyBlueColor
                            ),),
                            Spacer(),
                            IconButton(

    onPressed:(){
    showCustomModal(
    context,
    title: "Log out",
    description: "Are you sure you want to leave?",
    titleButton1: "Yes",
    titleButton2: "Cancel",
    onPressed1:() {
    Navigator.pop(context); // إغلاق القائمة السفلية
    },
    onPressed2: () {
    Navigator.pop(context); // إغلاق القائمة السفلية
    },
    );
                              }, icon:Icon(Icons.arrow_forward_ios_outlined),
                              color: AppColor.navyBlueColor,iconSize: 12,)

                          ],
                        ),
                      ),),//Logout

                  ],

                ),
              ),

            ),
          ),
          Positioned(
            top: 600,
            left: MediaQuery.of(context).size.width / 2 - 106.5, // محور الأفقي (العرض) لتوسيط العنصر
            child: button(
                colorBackground: AppColor.navyBlueColor,
                onPressed:(){

                },
                text:"Save",
                height: 50,
                width: 213,
                fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                fontWeight: AppFontStyles.fontWeightBold,
                color:Colors.white),
          ),
        ],
      ) ,
    );
  }
}
