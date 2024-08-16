import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:skilled_handyworkers_marketpleace/Registration/ChangePasswordScreen.dart';
import 'package:skilled_handyworkers_marketpleace/Registration/registertTitle.dart';

import '../shared/components/components.dart';
import '../shared/styles/colors.dart';
import '../shared/styles/styles.dart';
import 'LoginScreen.dart';
import 'cubitLogin/cubit.dart';
import 'cubitLogin/states.dart';

class ForgotPasswordScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is ForgotPassSkilledSuccessState) //نجاح او فشل التسجيل
        {
          if (state.value == 201) {

            Get.to(
                () =>ChangePasswordScreen(),
                arguments: [
                  emailController.text,
                ]);
          }
          //roaaalsawaf1@
        }
        if (state is ForgotPassSkilledErrorState) {
          if (state.error == 500) {
            showToast(text: "Email not found!", state: ToastStates.EROOR);
          } else {
            showToast(text: "error", state: ToastStates.EROOR);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColor.backgroundColor,
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 130, right: 32, left: 32),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RegisterTitle(
                          title1: "7".tr,
                          title2: "15".tr,
                          pathImage: "assets/images/forgotPassword.png",
                        ),
                        Text(
                          "5".tr,
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
                              return "email must not be empty !";
                            }
                            if (!value.endsWith('@gmail.com')) {
                              return "email must end with @gmail.com";
                            }
                            return null;
                          },
                          type: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 56,
                        ),
                        Center(
                          child: ConditionalBuilder(
                            condition: state is! ForgotPassSkilledLoadingState,
                            builder: (context) => button(
                              text: '18'.toUpperCase().tr,
                              color: Colors.white,
                              fontSize:
                                  AppFontStyles.descriptionSplashScreenFontSize,
                              fontWeight: AppFontStyles.fontWeightSemiBold7,
                              height: 60,
                              width: 320,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).sendEmailForget(
                                      email: emailController.text,
                                     );
                                }
                              },
                              colorBackground: AppColor.navyBlueColor,
                            ),
                            fallback: (context) =>
                                const Center(child: CircularProgressIndicator()),
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
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
