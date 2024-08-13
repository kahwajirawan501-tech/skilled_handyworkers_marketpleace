import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:skilled_handyworkers_marketpleace/Registration/registertTitle.dart';

import '../shared/components/components.dart';
import '../shared/styles/colors.dart';
import '../shared/styles/styles.dart';
import 'LoginScreen.dart';
import 'cubitLogin/cubit.dart';
import 'cubitLogin/states.dart';


class ChangePasswordScreen extends StatelessWidget {
  var data = Get.arguments;
  var codeController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext content) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is ChangePassSkilledSuccessState) {
              if (state.value == 201) {
                Get.to(() => LoginScreen(), arguments: [
                  data[0],
                ]);
              }
            }
            if (state is ChangePassSkilledErrorState) {
              if (state.error == 400) {
                showToast(
                  text: "The code not correct",
                  state: ToastStates.EROOR,
                );
              } else {
                showToast(
                  text: "error".toString(),
                  state: ToastStates.EROOR,
                );
              }

              // تسجيل تفاصيل الخطأ لمزيد من التحقق
              print("رمز الخطأ: ${state.error}");
              // print("رسالة الخطأ: ${state.errorMessage}");
            }
          },
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
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RegisterTitle(
                                title1: "19".tr,
                                title2: "20".tr,
                                pathImage: "assets/images/successfully.png",
                              ),

                              Text(
                                "codeController".tr,
                                style: TextStyle(
                                    fontWeight: AppFontStyles
                                        .fontWeightSemiBold7,
                                    fontSize: AppFontStyles
                                        .descriptionLoginFontSize,
                                    color: AppColor.fontColor),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              defaultTextFieldLog(
                                controller: codeController,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return "email must not be empty";
                                  }
                                  return null;
                                },
                                type: TextInputType.emailAddress,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "passController".tr,
                                style: TextStyle(
                                    fontWeight: AppFontStyles
                                        .fontWeightSemiBold7,
                                    fontSize: AppFontStyles
                                        .descriptionLoginFontSize,
                                    color: AppColor.fontColor),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              defaultTextFieldLog(
                                controller: passController,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return "email must not be empty";
                                  }
                                  return null;
                                },
                                type: TextInputType.emailAddress,
                              ),

                              SizedBox(
                                height: 36,
                              ),
                              Center(
                                child: ConditionalBuilder(

                                  condition: state is! ChangePassSkilledLoadingState,
                                  builder: (context) =>
                                      button(
                                        text: '21'
                                            .toUpperCase()
                                            .tr,
                                        color: Colors.white,
                                        fontSize:
                                        AppFontStyles
                                            .descriptionSplashScreenFontSize,
                                        fontWeight: AppFontStyles
                                            .fontWeightSemiBold7,
                                        height: 60,
                                        width: 320,
                                        onPressed: () {
                                          LoginCubit.get(context).ResetPassword(
                                              email: data[0],
                                              token: codeController.text,
                                              newPassword: passController.text);

                                          print(data[0]);
                                          print(codeController.text);

                                        },
                                        colorBackground: AppColor.navyBlueColor,
                                      ),
                                  fallback: (context) =>
                                  const Center(
                                      child: CircularProgressIndicator()),


                                ),

                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Center(
                                child: button(
                                  text: '17'
                                      .toUpperCase()
                                      .tr,
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