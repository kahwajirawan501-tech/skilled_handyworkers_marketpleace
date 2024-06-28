import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:skilled_handyworkers_marketpleace/Registration/LoginScreen.dart';
import 'package:skilled_handyworkers_marketpleace/Registration/cubitLogin/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Registration/cubitLogin/states.dart';
import 'package:skilled_handyworkers_marketpleace/Registration/registertTitle.dart';

import '../shared/components/components.dart';
import '../shared/styles/colors.dart';
import '../shared/styles/styles.dart';
import 'ChangePasswordScreen.dart';


class CheckYourEmailScreen extends StatelessWidget {
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext content) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              backgroundColor: AppColor.backgroundColor,
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Center(
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 130, right: 32, left: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RegisterTitle(
                          title1: "19".tr,
                          title2: "20".tr,
                          pathImage: "assets/images/checkEmail.png",
                        ),
                        Text(
                          "24".tr,
                          style: TextStyle(
                              fontWeight: AppFontStyles.fontWeightSemiBold7,
                              fontSize: AppFontStyles.descriptionLoginFontSize,
                              color: AppColor.fontColor),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        defaultTextFieldLog(
                          controller: emailController,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "email must not be empty";
                            }
                            return null;
                          },
                          type: TextInputType.emailAddress,
                        ),

                        SizedBox(
                          height: 56,
                        ),
                        Center(
                          child: button(
                            text: '21'.toUpperCase().tr,
                            color: Colors.white,
                            fontSize:
                            AppFontStyles.descriptionSplashScreenFontSize,
                            fontWeight: AppFontStyles.fontWeightSemiBold7,
                            height: 60,
                            width: 320,
                            onPressed: () {
                              navigateTo(
                                context: context,
                                widget: ChangePasswordScreen(),
                              );
                            },
                            colorBackground: AppColor.navyBlueColor,
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Center(
                          child: button(
                            text: '17'.toUpperCase().tr,
                            color: Colors.white,
                            fontSize:
                            AppFontStyles.descriptionSplashScreenFontSize,
                            fontWeight: AppFontStyles.fontWeightSemiBold7,
                            height: 60,
                            width: 320,
                            onPressed: () {
                              navigateTo(
                                context: context,
                                widget: LoginScreen(),
                              );
                            },
                            colorBackground: AppColor.googleColor,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Row(
                            children: [
                              Text("22".tr,style: TextStyle(

                                  fontWeight: AppFontStyles.fontWeightSemiBold4,
                                  fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                                  color:AppColor.fontColor
                              ),),
                              //  SizedBox(width: 24,),
                              defaultTextButton(

                                  text: "23".tr,
                                  function: (){

                                  },
                                  fontWeight: AppFontStyles.fontWeightSemiBold4,
                                  fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                                  color:AppColor.orangeColor
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }

}
