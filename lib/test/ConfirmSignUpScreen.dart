import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

import '../shared/components/components.dart';
import '../shared/styles/colors.dart';
import '../shared/styles/styles.dart';
import '../Registration/cubitSignUp/cubit.dart';
import '../Registration/cubitSignUp/states.dart';

class ConfirmSignUpScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  ConfirmSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUplCubit, SignUpStates>(
      listener: (context, state) {},
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
                        Center(
                          child: Column(
                            children: [
                              Text(
                                "13".tr,
                                style: TextStyle(
                                    fontWeight:
                                        AppFontStyles.fontWeightSemiBold7,
                                    fontSize:
                                        AppFontStyles.addressLoginLargeFontSize,
                                    color: AppColor.fontColor),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32.0),
                                child: Text(
                                  "4".tr,
                                  style: TextStyle(
                                      fontWeight:
                                          AppFontStyles.fontWeightMedium,
                                      fontSize: AppFontStyles
                                          .descriptionLoginFontSize,
                                      color: AppColor.fontColorDescription),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
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
                              return "email must not be empty";
                            }
                            return null;
                          },
                          type: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 16,
                        ), Text(
                          "Code",
                          style: TextStyle(
                              fontWeight: AppFontStyles.fontWeightSemiBold7,
                              fontSize: AppFontStyles.descriptionLoginFontSize,
                              color: AppColor.fontColor),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        OtpTextField(
                          numberOfFields: 5,
                          cursorColor: AppColor.navyBlueColor,
                          borderColor: AppColor.navyBlueColor,
                          showFieldAsBox: false,
                          onCodeChanged: (String code) {
                            // تتفاعل عند تغيير كل خانة
                          },
                          onSubmit: (String verificationCode) {
                            // تتفاعل عند إدخال الكود بالكامل
                            print("OTP Code: $verificationCode");
                          },
                        ),

                        SizedBox(
                          height: 50,
                        ),

                        //ربط
                        Center(
                          child: ConditionalBuilder(
                            condition: state is! SignUpSkilledLoadingState,
                            builder: (context) => button(
                              text: '11'.toUpperCase().tr,
                              color: Colors.white,
                              fontSize:
                                  AppFontStyles.descriptionSplashScreenFontSize,
                              fontWeight: AppFontStyles.fontWeightSemiBold7,
                              height: 50,
                              width: 213,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  navigateTo(
                                      context: context,
                                      widget: ConfirmSignUpScreen());
                                }
                              },
                              colorBackground: AppColor.navyBlueColor,
                            ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
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
    // return  Scaffold(
    //
    //   body: Center(
    //     child:OtpTextField(
    //       numberOfFields: 6,
    //         borderColor: Color(0xFF512DA8),
    //         showFieldAsBox: true,
    //         onCodeChanged: (String code) {
    //           // تتفاعل عند تغيير كل خانة
    //         },
    //         onSubmit: (String verificationCode) {
    //           // تتفاعل عند إدخال الكود بالكامل
    //           print("OTP Code: $verificationCode");
    //         },
    //     )
    //   ),
    //       // child: OtpTextField(
    //       //   numberOfFields: 6,
    //       //   borderColor: Color(0xFF512DA8),
    //       //   showFieldAsBox: true,
    //       //   onCodeChanged: (String code) {
    //       //     // تتفاعل عند تغيير كل خانة
    //       //   },
    //       //   onSubmit: (String verificationCode) {
    //       //     // تتفاعل عند إدخال الكود بالكامل
    //       //     print("OTP Code: $verificationCode");
    //       //   },
    //       // ),
    //
    //
    // );
  }
}
