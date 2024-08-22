import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/BottonNavigationBar.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Registration/SignUpScreen.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import '../shared/components/components.dart';
import '../shared/network/local/cache_helper.dart';
import '../shared/styles/colors.dart';
import '../shared/styles/styles.dart';
import 'ForgotPasswordScreen.dart';
import 'cubitLogin/cubit.dart';
import 'cubitLogin/states.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
      if (state is LoginSkilledSuccessState) //نجاح او فشل التسجيل
          {
        if (state.value == 201) {
          CacheHelper.saveData(
              key: 'accessToken', value: state.token)
              .then(
                (value) {
              setState(() {
                accessToken = state.token;
              });
            },
          );
          HomeCubit.get(context).getProfileId();
          navigateAndFinish(
              context: context, widget: BottomNavigationScreen());
        }
      }
      if (state is LoginGoogleSkilledSuccessState) //نجاح او فشل التسجيل
          {
        if (state.value == 201) {

              CacheHelper.saveData(key: 'accessToken', value: state.data['token'])
                  .then((_) {
                setState(() {
                  accessToken = state.data['token'];
                });
              });
            }
          HomeCubit.get(context).getProfileId();
          navigateAndFinish(
              context: context, widget: BottomNavigationScreen());

      }
      if (state is LoginSkilledErrorState) {
        if (state.error == 401) {
          showToast(
              text: "invalid email or password.", state: ToastStates.EROOR);
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
    Center(
    child: Column(
    children: [
    Text(
    "12".tr,
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
    Padding(padding: const EdgeInsets.symmetric(
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
    if (!value.endsWith('@gmail.com')) {
    return "email must end with @gmail.com";
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
    fontSize: AppFontStyles.descriptionLoginFontSize,
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
    LoginCubit.get(context).changePasswordVisibility();
    },
    suffix: LoginCubit
        .get(context)
        .suffix,
    isPassword: LoginCubit
        .get(context)
        .isPasswordShown,
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
    ],),
    SizedBox(
    height: 24,
    ),
    Center(
    child: ConditionalBuilder(
    condition: state is! LoginSkilledLoadingState,
    builder: (context) =>
    button(
    // function: () {
    //   if (formKey.currentState!.validate()) {
    //     LoginCubit.get(context).login(
    //         email: emailController.text,
    //         password: passwordController.text);
    //   }
    // },
    text: '8'
        .toUpperCase()
        .tr,
    color: Colors.white,
    fontSize:
    AppFontStyles.descriptionSplashScreenFontSize,
    fontWeight: AppFontStyles.fontWeightSemiBold7,
    height: 60,
    width: 320,
    onPressed: () {
    if (formKey.currentState!.validate()) {
    LoginCubit.get(context).login(
    email: emailController.text,
    password: passwordController.text);
    // navigateTo(
    //     widget: ProfileScreen(), context: context);
    }
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
    child: Stack(
    alignment: AlignmentDirectional.bottomStart,
    children: [
    ConditionalBuilder(
    condition: state is! LoginGoogleSkilledLoadingState,
    builder: (context) =>    button(
    function: () {},
    text: '9'
        .toUpperCase()
        .tr,
    color: AppColor.navyBlueColor,
    fontSize: AppFontStyles
        .descriptionSplashScreenFontSize,
    fontWeight: AppFontStyles.fontWeightSemiBold7,
    height: 60,
    width: 320,
    onPressed: () async {
    LoginCubit.get(context).loginWithGoogle();
    // var user =await Signingoogle.login();
    // print("oke nih");
    // print(user!.displayName);
    // print(user.email);
    // print(user.!acc);

    // _googleLogin();
    },
    colorBackground: AppColor.googleColor,
    ),
    fallback:(context) => const Center(
    child: CircularProgressIndicator()) ,
    ),Padding(
        padding: const EdgeInsets.only(
            bottom: 20, right: 55, left: 55),
        child: Image.asset("assets/images/google.png"),
      ),
    ],
    ),
    ),
      SizedBox(height: 10,),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(
          children: [
            Text(
              "10".tr,
              style: TextStyle(
                  fontWeight:
                  AppFontStyles.fontWeightSemiBold4,
                  fontSize: AppFontStyles
                      .descriptionSplashScreenFontSize,
                  color: AppColor.fontColor),
            ),
            GestureDetector(
                onTap: () {
                  navigateTo(
                      widget: SignUpScreen(),
                      context: context);
                },
                child: Text("11".tr, style: TextStyle(
                    color: AppColor.orangeColor,
                    fontSize: AppFontStyles
                        .descriptionLoginFontSize),))

          ],
        ),
      )
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
//    Future _googleLogin() async {
//      final user = await Signingoogle.login();
//
//
//      if (user != null) {
//        GoogleSignInAuthentication googleSignInAuthentication = await user
//           .authentication;
//       String? acc = googleSignInAuthentication.accessToken;
//       print("User Access Token: ${googleSignInAuthentication.accessToken}");
//
//       print(user.toString());
//       Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (context) => Logininfo(user: user, acc: '${acc}',)));
//     }
//   }
// }
// class Signingoogle {
//
//   // static final _webid =  '518469709569-2dc83j3m9ubb6q274m0014mvqmiqcqh4.apps.googleusercontent.com';
//   //static final _googlesignin = GoogleSignIn(clientId: _webid);
//   static final _googlesignin = GoogleSignIn();
//
//   static Future<GoogleSignInAccount?> login() => _googlesignin.signIn();
//
//
//   static Future logout() => _googlesignin.disconnect();
// }
//
//
//
// class Logininfo extends StatelessWidget {
//   final GoogleSignInAccount user;
//   final String? acc;
//   Logininfo({
//     required this.user,
//     required this.acc
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Center(
//               child:
//               Text(
//                   user.displayName!
//               )
//
//           ),
//           SizedBox(height: 20,),
//           Center(
//               child:   Text(
//                   user.email
//               )),
//           SizedBox(height: 20,),
//           Center(
//               child:   Text(
//                   user.id
//               )),
//           SizedBox(height: 20,),
//           Center(
//               child:   Text(
//                   acc!
//               )),
//           //SizedBox(height: 20,),
//           // Center(
//           //     child:   Text(
//           //         user.authentication.toString()
//           //     )),
//           SizedBox(height: 20,),
//           Center(
//               child://               ElevatedButton(
// //                 child: Text(
// //                     "Logout"
// //                 ),
// //                 onPressed: (){
// //                   _googleLogout(context);
// //                 },
// //               )
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //   Future _googleLogout(context)async {
// //     await  Signingoogle.logout();
// //     Navigator.of(context).pushReplacement( MaterialPageRoute(builder:(context) =>LoginScreen()  ));
// //   }
// //
// // }