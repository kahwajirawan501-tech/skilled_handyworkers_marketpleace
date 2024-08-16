import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profileScreen.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController editingController=TextEditingController();
   editingController.text=(aboutMy!.isNotEmpty?aboutMy:"")!;
    return BlocConsumer<ProfileCubit,ProfileStates>(
      listener:(context, state) {
        if(state is AboutMeSucssessfullStateStates){
          showToast(text:"117".tr, state: ToastStates.EROOR);
          Navigator.pop(context);
        }
        else if(state is AboutMeErrorStateStates){
          showToast(text:"118\n".tr, state: ToastStates.EROOR);

        }
        if(state is EditAboutMeSucssessfullStateStates){
          showToast(text:"119".tr, state: ToastStates.EROOR);
          Navigator.pop(context);
        }
        else if(state is EditAboutMeErrorStateStates){
          showToast(text:"120\n".tr, state: ToastStates.EROOR);

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
                        ConditionalBuilder(
                          condition: state is !AboutMeStatesLoadingStateStates && state is !EditAboutMeStatesLoadingStateStates,
                          builder: (context) => const SizedBox(),
                          fallback:(context) => LinearProgressIndicator(color: AppColor.orangeColor,minHeight: 1.0,),),
                        SizedBox(height:AppFontStyles.aboutMe,),
                        Text("121".tr,style: TextStyle(
                            fontSize:AppFontStyles.aboutMe,
                            fontWeight:   AppFontStyles.fontWeightSemiBold,
                            color: AppColor.bluColor
                        ),),
                        const SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle,),
                        Box(
                          borderRadius: BorderRadius.circular(AppFontStyles.borderRadius),
                          height: 232,
                          widget:Padding(

                            padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.aboutMe),
                            child: TextFormField(
                              controller: editingController,
                              maxLines: 6,
                              textInputAction: TextInputAction.newline,// حدد الحد الأقصى لعدد الأسطر

                              style: TextStyle(

                                color: AppColor.grayColorFont,
                                fontSize: AppFontStyles.descriptionLoginFontSize,
                              ),
                              // حدد الحد الأقصى لعدد الأسطر
                              decoration:  InputDecoration(
                                hintText:'122'.tr,
                                hintStyle: TextStyle(
                                    color:AppColor.grayColorFont,
                                    fontSize: AppFontStyles.descriptionLoginFontSize

                                ),
                                border: InputBorder.none,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    clearTextField(editingController);

                                  },
                                  child: const Icon(Icons.clear,size: 15,),

                                ),


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
                      title: "123".tr,
                      description: "124".tr,
                      titleButton1: "125".tr,
                      titleButton2: "126".tr,
                      onPressed1:() {
                        aboutMy!.isEmpty?ProfileCubit.get(context).addAboutMy(editingController.text):
                        ProfileCubit.get(context).editAboutMy(editingController.text);
                        Navigator.pop(context);
                      },
                      onPressed2: () {
                        Navigator.pop(context); // إغلاق القائمة السفلية
                      },
                    );
                  },
                  text:"127".tr,
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
      },
    );
  }
}






void clearTextField(TextEditingController controller) {
  controller.clear();
}