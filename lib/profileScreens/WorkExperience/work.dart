import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profileScreen.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class Work extends StatelessWidget {
  final String title;
  final String field1;
  final String field2;
  final String description;
  final String titleButton1;
  final String titleButton2;
  final VoidCallback? onPressed1 ;
  final VoidCallback? onPressed2 ;
  final bool buttonTF;
  const Work({Key? key, required this.title, required this.field1, required this.field2, required this.description, required this.titleButton1, required this.titleButton2, this.onPressed1, this.onPressed2, required this.buttonTF}) : super(key: key);

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
                padding: const EdgeInsets.all(AppFontStyles.padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,style: TextStyle(
                        fontSize:AppFontStyles.aboutMe,
                        fontWeight:   AppFontStyles.fontWeightSemiBold,
                        color: AppColor.bluColor
                    ),),
                    const SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle,),
                    Text(field1,style: TextStyle(
                        fontWeight:AppFontStyles.fontWeightBold ,
                        fontSize: AppFontStyles.descriptionLoginFontSize,
                        color: AppColor.navyBlueColor
                    ),),
                    SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle,),
                    Box(
                      borderRadius: BorderRadius.circular(AppFontStyles.borderRadiusTextField),
                      height: 40,
                      widget:Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding),
                        child: TextFormField(
                          maxLines: 1, // حدد الحد الأقصى لعدد الأسطر
                          decoration:  InputDecoration(

                            border: InputBorder.none,

                          ),
                          cursorColor: AppColor.grayColorFont,
                        ),

                      ),),
                    SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle,),

                    Text(field2,style: TextStyle(
                        fontWeight:AppFontStyles.fontWeightBold ,
                        fontSize: AppFontStyles.descriptionLoginFontSize,
                        color: AppColor.navyBlueColor
                    ),),
                    SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle,),
                    Box(
                      borderRadius: BorderRadius.circular(AppFontStyles.borderRadiusTextField),
                      height: 155,
                      widget:Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding),
                        child: TextFormField(
                          maxLines: 1, // حدد الحد الأقصى لعدد الأسطر
                          decoration:  InputDecoration(
                            hintText:description,
                            hintStyle: TextStyle(
                                color:AppColor.grayColorFont,
                                fontSize: AppFontStyles.descriptionLoginFontSize

                            ),
                            border: InputBorder.none,

                          ),
                          cursorColor: AppColor.grayColorFont,
                        ),

                      ),),
                    Visibility(
                      visible: buttonTF,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:  const EdgeInsets.symmetric(vertical: 240),
                              child: button(
                                  colorBackground: AppColor.navyBlueColor,
                                  onPressed:onPressed1,
                                  text:titleButton1,
                                  height: 50,
                                  width: 213,
                                  fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                                  fontWeight: AppFontStyles.fontWeightBold,
                                  color:Colors.white),
                            ),
                          ],
                        ) ),
                    Visibility(
                        visible: !buttonTF,
                        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding:  const EdgeInsets.symmetric(vertical: 240),
                              child: Row(
                                children: [

                                  button(
                                      colorBackground: AppColor.googleColor,
                                      onPressed:onPressed2,
                                      text:titleButton2,
                                      height: 50,
                                      width: 160,
                                      fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                                      fontWeight: AppFontStyles.fontWeightBold,
                                      color:Colors.white),
                                  SizedBox(width: 10,),
                                  button(
                                      colorBackground: AppColor.navyBlueColor,
                                      onPressed:onPressed1,
                                      text:titleButton1,
                                      height: 50,
                                      width: 160,
                                      fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                                      fontWeight: AppFontStyles.fontWeightBold,
                                      color:Colors.white),

                                ],
                              ),
                            ),
                          ],
                        ) ),

                  ],

                ),
              ),
            ),
          ),
          Positioned(
            top: 600,
            left: MediaQuery.of(context).size.width / 2 - 106.5, // محور الأفقي (العرض) لتوسيط العنصر

            child: Visibility(
                visible: buttonTF,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:  const EdgeInsets.symmetric(vertical: 240),
                      child: button(
                          colorBackground: AppColor.navyBlueColor,
                          onPressed:onPressed1,
                          text:titleButton1,
                          height: 50,
                          width: 213,
                          fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                          fontWeight: AppFontStyles.fontWeightBold,
                          color:Colors.white),
                    ),
                  ],
                ) ),
          ),
          Positioned(
            top: 600,
            left: MediaQuery.of(context).size.width / 2 - 106.5, // محور الأفقي (العرض) لتوسيط العنصر

            child: Visibility(
                visible: !buttonTF,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding:  const EdgeInsets.symmetric(vertical: 240),
                      child: Row(
                        children: [

                          button(
                              colorBackground: AppColor.googleColor,
                              onPressed:onPressed2,
                              text:titleButton2,
                              height: 50,
                              width: 160,
                              fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                              fontWeight: AppFontStyles.fontWeightBold,
                              color:Colors.white),
                          SizedBox(width: 10,),
                          button(
                              colorBackground: AppColor.navyBlueColor,
                              onPressed:onPressed1,
                              text:titleButton1,
                              height: 50,
                              width: 160,
                              fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                              fontWeight: AppFontStyles.fontWeightBold,
                              color:Colors.white),

                        ],
                      ),
                    ),
                  ],
                ) ),
          ),

        ],
      ) ,
    );
  }
}
