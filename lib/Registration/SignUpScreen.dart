import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:skilled_handyworkers_marketpleace/Registration/ForgotPasswordScreen.dart';
import 'package:skilled_handyworkers_marketpleace/Registration/cubitSignUp/cubit.dart';

import 'package:skilled_handyworkers_marketpleace/Registration/cubitSignUp/states.dart';

import '../profileScreens/profileScreen.dart';
import '../shared/components/components.dart';
import '../shared/styles/colors.dart';
import '../shared/styles/styles.dart';
import 'CheckYourEmailScreen.dart';
import 'cubitConfirmSignUp/cubit.dart';
import 'cubitConfirmSignUp/states.dart';

class SignUpScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var fullNameController = TextEditingController();

  var isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext content) => SignUplCubit(),
      child: BlocConsumer<SignUplCubit, SignUpStates>(
        listener: (context, state) {
          if (state is SignUpSkilledSuccessState) {
            if (state.value == 201) {
              // الانتقال إلى الشاشة التالية أو عرض رسالة النجاح
              navigateTo(context: context, widget: CheckYourEmailScreen(email: emailController.text,));
            }
            if (state.signUpModel.status == 400) {
              showToast(
                text: "Email already exists",
                state: ToastStates.EROOR,
              );
            }
          }

          if (state is SignUpSkilledErrorState) {
            if (state.error == 400) {
              showToast(
                text: "Email already exists",
                state: ToastStates.EROOR,
              );
            }
          }
        },
        // {
        //   if (state is SignUpSkilledSuccessState) //نجاح او فشل التسجيل
        //       {
        //     print(',d,,,,dd');
        //     if (state.value == 200) {
        //       print(',d,,,,dd');
        //       Get.to(() => CheckYourEmailScreen(), arguments: [
        //         fullNameController.text,
        //         emailController.text, //ايميل
        //         passwordController.text, //باسورد
        //       ]);
        //     }
        //     if (state.value == 400) {
        //       showToast(
        //           text: "Password must be at least 6 characters long",
        //           state: ToastStates.EROOR);
        //     }
        //   }
        //   if (state is SignUpSkilledErrorState) {
        //     if (state.error == 400) {
        //       showToast(
        //           text: "Password must be at least 6 characters long",
        //           state: ToastStates.EROOR);
        //     }
        //   }
        //   //else {
        //   //     showToast(
        //   //         text: "Wrong way to write the email",
        //   //         state: ToastStates.EROOR);
        //   //   }
        //   // }
        // },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: AppColor.backgroundColor,
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 130, right: 32, left: 32),
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
                                      fontSize: AppFontStyles
                                          .addressLoginLargeFontSize,
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
                            "14".tr,
                            style: TextStyle(
                                fontWeight: AppFontStyles.fontWeightSemiBold7,
                                fontSize:
                                    AppFontStyles.descriptionLoginFontSize,
                                color: AppColor.fontColor),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          defaultTextFieldLog(
                            controller: fullNameController,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "fullName must not be empty";
                              }
                              return null;
                            },
                            type: TextInputType.name,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "5".tr,
                            style: TextStyle(
                                fontWeight: AppFontStyles.fontWeightSemiBold7,
                                fontSize:
                                    AppFontStyles.descriptionLoginFontSize,
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
                          ),
                          Text(
                            "6".tr,
                            style: TextStyle(
                                fontWeight: AppFontStyles.fontWeightSemiBold7,
                                fontSize:
                                    AppFontStyles.descriptionLoginFontSize,
                                color: AppColor.fontColor),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          defaultTextFieldLog(
                            controller: passwordController,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "password must not be empty";
                              }
                              return null;
                            },
                            suffixPressed: () {
                              SignUplCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            suffix: SignUplCubit.get(context).suffix,
                            isPassword:
                                SignUplCubit.get(context).isPasswordShown,
                            type: TextInputType.visiblePassword,
                          ),
                          Row(
                            children: [
                              Spacer(),
                              defaultTextButton(
                                  text: "7".tr,
                                  function: () {
                                    navigateTo(
                                      context: context,
                                      widget: ForgotPasswordScreen(),
                                    );
                                  },
                                  fontWeight: AppFontStyles.fontWeightSemiBold4,
                                  fontSize:
                                      AppFontStyles.descriptionLoginFontSize,
                                  color: AppColor.fontColor)
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),

                          //ربط
                          Center(
                            child: ConditionalBuilder(
                              condition: state is! SignUpSkilledLoadingState,
                              builder: (context) => button(
                                text: '11'.toUpperCase().tr,
                                color: Colors.white,
                                fontSize: AppFontStyles
                                    .descriptionSplashScreenFontSize,
                                fontWeight: AppFontStyles.fontWeightSemiBold7,
                                height: 60,
                                width: 320,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    SignUplCubit.get(context).userSignUp(
                                      fullName: fullNameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );

                                  }
                                },
                                colorBackground: AppColor.navyBlueColor,
                              ),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator()),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Center(
                            child: Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                button(
                                  text: '9'.toUpperCase().tr,
                                  color: Colors.white,
                                  fontSize: AppFontStyles
                                      .descriptionSplashScreenFontSize,
                                  fontWeight: AppFontStyles.fontWeightSemiBold7,
                                  height: 60,
                                  width: 320,
                                  onPressed: () {},
                                  colorBackground: AppColor.googleColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 55.0, bottom: 20, right: 55.0),
                                  child:
                                      Image.asset("assets/images/google.png"),
                                ),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.symmetric(horizontal: 24.0),
                          //   child: Row(
                          //     children: [
                          //       Text(
                          //         "10".tr,
                          //         style: TextStyle(
                          //             fontWeight:
                          //                 AppFontStyles.fontWeightSemiBold4,
                          //             fontSize: AppFontStyles
                          //                 .descriptionSplashScreenFontSize,
                          //             color: AppColor.fontColor),
                          //       ),
                          //       defaultTextButton(
                          //           text: "11".tr,
                          //           function: () {
                          //             navigateTo(
                          //               context: context,
                          //               widget: SignUpScreen(),
                          //             );
                          //           },
                          //           fontWeight:
                          //               AppFontStyles.fontWeightSemiBold4,
                          //           fontSize: AppFontStyles
                          //               .descriptionSplashScreenFontSize,
                          //           color: AppColor.orangeColor),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
