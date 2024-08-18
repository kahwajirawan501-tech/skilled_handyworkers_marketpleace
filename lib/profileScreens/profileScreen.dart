import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Education/addEducation.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Language/language.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Setting/setting.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/WorkExperience/addWorkExperienc.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/aboutMe/aboutMe.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/appBarProfile.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/editProfile/editProfile.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profilrTile.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/skill/skill.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ProfileCubit,ProfileStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return  Scaffold(
          appBar: AppBarProfile(
            email:email!,
            name: name!,pathImage:imageNetwork!.isEmpty?imageCope!:imageNetwork!,
            onTapSetting: () {
              navigateTo(context: context,widget: const Setting());//AddWorkExperience
            }, textButton: '315'.tr, visibility: true, left: 260, top: 30,

            onTapEditorChange: () {
              navigateTo(widget: EditProfile(),context: context);
            }, visibilitySetting: true, arrBackVisibility: false,



          ),
          body: Container(
            height: double.infinity,
            color: AppColor.backgroundColor,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle,),
                  profilrTile(
                      imagePath: "assets/images/aboutmy.png",
                      title:"106".tr,
                      addOrEdit:aboutMy!.isEmpty?"assets/images/Add.png":"assets/images/Edit.png",
                      onTap:(){
                        navigateTo(context: context,widget: const AboutMe());//AddWorkExperience
                      },
                      trueOrFalse:aboutMy!.isEmpty?false:true ,
                      widget:const Text("") ,
                      line: myLineTwo(),
                      text:Text(aboutMy!,style: TextStyle(
                          color: AppColor.fontColorDescription,
                          fontSize: AppFontStyles.descriptionSplashScreenFontSize
                      ),)

                  ),
                  profilrTile(
                    imagePath: "assets/images/work.png",
                    title:"111".tr,
                    onTap:(){
                      navigateTo(context: context,widget: const AddWorkExperience());//AddEducation

                    },
                    trueOrFalse:workTittle!.isEmpty&&workDescription!.isEmpty?false:true ,
                    addOrEdit:workTittle!.isEmpty&&workDescription!.isEmpty?"assets/images/Add.png":"assets/images/Edit.png",
                    widget:const Text("")
                    ,line: myLineTwo(),
                    text:Text("${workTittle!}\n${workDescription!}",style: TextStyle(
                        color: AppColor.fontColorDescription,
                        fontSize: AppFontStyles.descriptionSplashScreenFontSize
                    ),) ,
                  ),
                  profilrTile(
                      imagePath: "assets/images/experience.png",
                      title:"112".tr,
                      onTap:(){
                        navigateTo(context: context,widget: const AddEducation());//AddEducation

                      },
                      trueOrFalse:educationTittle!.isEmpty&&educationDescription!.isEmpty?false:true ,

                      addOrEdit:educationTittle!.isEmpty&&educationDescription!.isEmpty?"assets/images/Add.png":"assets/images/Edit.png",
                      widget:const Text(""),
                      line: myLineTwo(),
                      text:Text("${educationTittle!}\n${educationDescription!}",style: TextStyle(
                          color: AppColor.fontColorDescription,
                          fontSize: AppFontStyles.descriptionSplashScreenFontSize
                      ),)
                  ),

                  profilrTile(imagePath: "assets/images/language.png", title:"133".tr, onTap:(){
                    navigateTo(context: context,widget: const Language());//AddEducation

                  },
                      addOrEdit: "assets/images/Add.png",
                      trueOrFalse: false,
                      widget:const Text(""),
                      line: myLineTwo(),
                      text:Text("hhhhhhhhhhhhhhhhhhhhhhhh",style: TextStyle(
                          color: AppColor.fontColorDescription,
                          fontSize: AppFontStyles.descriptionSplashScreenFontSize
                      ),)
                  ),

                ],
              ),
            ),
          ),
        );
      },

    );
  }
}

