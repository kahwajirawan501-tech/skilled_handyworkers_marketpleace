import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Setting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Setting/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Setting/setting.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class PassWord extends StatelessWidget {
   PassWord({Key? key}) : super(key: key);
  var oldPasswordController=TextEditingController();
   var newPasswordController=TextEditingController();
   var confirmPasswordController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SettingCubit,SettingStates>(
      listener:  (context, state) {
        if(state is ChangeSucsessfulPassWord){
          Navigator.pop(context);
        }
        if(state is ChangeErrorPassWord){
          showToast(text:"error", state: ToastStates.EROOR);
        }
      },
      builder: (context, state) {
        return  Scaffold(
          appBar: AppBar(
            surfaceTintColor:  AppColor.backgroundColor,

            leading:IconButton(
              icon:Icon( Icons.arrow_back,color: AppColor.arrowBackColor,),
              onPressed: () {
                Navigator.pop(context);

                // navigateAndFinish(widget:const Setting() ,context: context);
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
                child:  ConditionalBuilder(
                  condition: state is !ChangeLoadPassWord,
                  builder: (context) => SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(AppFontStyles.padding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Update Password",style: TextStyle(
                              fontSize:AppFontStyles.aboutMe,
                              fontWeight:   AppFontStyles.fontWeightSemiBold,
                              color: AppColor.bluColor
                          ),),
                          const SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle,),
                          Text("Old Password",style: TextStyle(
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
                                child: defaultTextField(
                                  controller: oldPasswordController,
                                  type:TextInputType.visiblePassword,
                                  isPassword: SettingCubit.get(context).isOldPasswordShown,

                                  suffixPressed: () {
                                    SettingCubit.get(context).changeOldPasswordVisibility();
                                  },
                                  suffix:SettingCubit.get(context).oldSuffix,
                                  validate:(value){
                                    if (value!.isEmpty) {
                                      return "Your password must not be empty";
                                    }
                                    return null;
                                  },
                                  height: 50,
                                  borderRadius:BorderRadius.circular(AppFontStyles.borderRadiusTextField) ,
                                )

                            ),),
                          SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle,),
                          Text("New Password",style: TextStyle(
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
                                child: defaultTextField(
                                  controller: newPasswordController,
                                  type:TextInputType.visiblePassword,
                                  isPassword: SettingCubit.get(context).isNewPasswordShown,

                                  suffixPressed: () {
                                    SettingCubit.get(context).changeNewPasswordVisibility();
                                  },
                                  suffix:SettingCubit.get(context).newSuffix,
                                  validate:(value){
                                    if (value!.isEmpty) {
                                      return "Your password must not be empty";
                                    }
                                    return null;
                                  },
                                  height: 50,
                                  borderRadius:BorderRadius.circular(AppFontStyles.borderRadiusTextField) ,
                                )

                            ),),
                          SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle,),

                          // Text("Confirm Password",style: TextStyle(
                          //     fontWeight:AppFontStyles.fontWeightBold ,
                          //     fontSize: AppFontStyles.descriptionLoginFontSize,
                          //     color: AppColor.navyBlueColor
                          // ),),
                          // SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle,),
                          // Box(
                          //   borderRadius: BorderRadius.circular(AppFontStyles.borderRadiusTextField),
                          //   height: 40,
                          //   widget:Padding(
                          //       padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding),
                          //       child: defaultTextField(
                          //         controller: confirmPasswordController,
                          //         type:TextInputType.visiblePassword,
                          //         isPassword: SettingCubit.get(context).isConfigPasswordShown,
                          //
                          //         suffixPressed: () {
                          //           SettingCubit.get(context).changeConfigPasswordVisibility();
                          //         },
                          //         suffix:SettingCubit.get(context).configSuffix,
                          //         validate:(value){
                          //           if (value!.isEmpty) {
                          //             return "Your password must not be empty";
                          //           }
                          //           return null;
                          //         },
                          //         height: 50,
                          //         borderRadius:BorderRadius.circular(AppFontStyles.borderRadiusTextField) ,
                          //       )
                          //
                          //   ),),

                        ],

                      ),
                    ),
                  ),
                  fallback: (context) => Center(child: CircularProgressIndicator(color: AppColor.orangeColor,),),

                ),

              ),

              Positioned(
                top: 600,
                left: MediaQuery.of(context).size.width / 2 - 106.5, // محور الأفقي (العرض) لتوسيط العنصر
                child: button(
                    colorBackground: AppColor.navyBlueColor,
                    onPressed:(){
                      if(email!.isEmpty||oldPasswordController.text.isEmpty||newPasswordController.text.isEmpty){
                        String messge=email.toString().isNotEmpty?
                        email.toString():oldPasswordController.text.isNotEmpty?oldPasswordController.text:newPasswordController.text;
                        showToast(text:"please enter the $messge ", state: ToastStates.EROOR);
                      }
                      if(email!.isNotEmpty&&oldPasswordController.text.isNotEmpty&&newPasswordController.text.isNotEmpty){
     SettingCubit.get(context).changePassword(email.toString(),oldPasswordController.text, newPasswordController.text);

                      }
                    },
                    text:"Update",
                    height: 50,
                    width: 213,
                    fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                    fontWeight: AppFontStyles.fontWeightBold,
                    color:Colors.white),
              ),
            ],
          ) ,
        );
      },
    );
  }
}
