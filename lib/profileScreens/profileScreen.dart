import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Education/addEducation.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Language/language.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Setting/setting.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/WorkExperience/addWorkExperienc.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/aboutMe/aboutMe.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/appBarProfile.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/editProfile/editProfile.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profilrTile.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/skill/skill.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

import 'WorkExperience/changeWorkExperience.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBarProfile(
        email:"OrlandoDiggs@gmail.com" ,
        name: "Orlando Diggs",pathImage: "assets/images/Mask group.png",
        onTapSetting: () {
          navigateTo(context: context,widget: Setting());//AddWorkExperience
        }, textButton: 'Edit Profile', visibility: true, left: 255, top: 30,

        onTapEditorChange: () {
          navigateTo(widget: EditProfile(),context: context);
        }, visibilitySetting: true, arrBackVisibility: false,



      ),
      body: Container(
        height: double.infinity,
        color: AppColor.backgroundColor,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle,),
              profilrTile(imagePath: "assets/images/aboutmy.png", title:"About me", onTap:(){
                 navigateTo(context: context,widget: AboutMe());//AddWorkExperience
              },widget:Text("") ,),
              profilrTile(imagePath: "assets/images/work.png", title:"Work experience", onTap:(){
                navigateTo(context: context,widget: ChangeWorkExperience());//AddEducation

              },widget:Text("")),
              profilrTile(imagePath: "assets/images/experience.png", title:"Education", onTap:(){
                navigateTo(context: context,widget: AddEducation());//AddEducation

              },widget:Text("")),
              profilrTile(imagePath: "assets/images/skill.png", title:"Skill", onTap:(){
                navigateTo(context: context,widget: Skill());//AddEducation

              },widget:Text("")),
              profilrTile(imagePath: "assets/images/language.png", title:"Language", onTap:(){
                navigateTo(context: context,widget: Language());//AddEducation

              },widget:Text("")),

            ],
          ),
        ),
      ),
    );
  }
}

