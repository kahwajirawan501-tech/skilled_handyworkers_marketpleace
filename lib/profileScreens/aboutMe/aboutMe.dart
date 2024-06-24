import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profileScreen.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor:  AppColor.backgroundColor,

        leading:IconButton(
          icon:Icon( Icons.arrow_back,color: AppColor.arrowBackColor,),
          onPressed: () {
            Navigator.pop(context);
            // navigateAndFinish(widget:const ProfileScreen() ,context: context);
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
                padding:  EdgeInsets.all(AppFontStyles.padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("About me",style: TextStyle(
                        fontSize:AppFontStyles.aboutMe,
                        fontWeight:   AppFontStyles.fontWeightSemiBold,
                        color: AppColor.bluColor
                    ),),
                    const SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle,),
                    Box(
                      borderRadius: BorderRadius.circular(AppFontStyles.borderRadius),
                      height: 232,
                      widget:Padding(

                        padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding),
                        child: TextFormField(
                          maxLines: 6, // حدد الحد الأقصى لعدد الأسطر
                          decoration:  InputDecoration(

                            hintText:'Tell me about you.',
                            hintStyle: TextStyle(
                                color:AppColor.grayColorFont,
                                fontSize: AppFontStyles.descriptionLoginFontSize

                            ),
                            border: InputBorder.none,

                            // هنا يمكنك تحديد نص التلميح
                          ),
                          cursorColor: AppColor.grayColorFont,
                          cursorHeight:24,
                        ),

                      ),),




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
                showCustomModal(
                  context,
                  title: "Undo Changes ?",
                  description: "Are you sure you want to change what you entered?",
                  titleButton1: "Continue Filling",
                  titleButton2: "Undo Changes",
                  onPressed1:() {
                    Navigator.pop(context); // إغلاق القائمة السفلية
                  },
                  onPressed2: () {
                    Navigator.pop(context); // إغلاق القائمة السفلية
                  },
                );
              },
              text:"Save",
              height: 50,
              width: 213,
              fontSize: AppFontStyles.descriptionSplashScreenFontSize,
              fontWeight: AppFontStyles.fontWeightBold,
              color:Colors.white,
            ),
          )

        ],
      ) ,

    );
  }
}






