import 'package:flutter/material.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/TabBarScreen.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/imageView.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profilrTile.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class InformationCustomer extends StatefulWidget {
  const InformationCustomer({Key? key}) : super(key: key);

  @override
  State<InformationCustomer> createState() => _InformationCustomerState();
}

class _InformationCustomerState extends State<InformationCustomer> {
  @override
  Widget build(BuildContext context) {
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
      body: Container(
        color: AppColor.backgroundColor,
        width: double.infinity,
        height:double.infinity ,
        child: SingleChildScrollView(

          physics: BouncingScrollPhysics(),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Visibility(
                visible: name!.isNotEmpty,
                child: profilrTile(
                    addOrEdit:"assets/images/Edit1.png" ,
                    imagePath: "assets/images/aboutmy.png",
                    title:"Full Name",

                    onTap:(){
                    },
                    trueOrFalse:name!.isEmpty?false:true ,
                    widget:const Text("") ,
                    line: myLineTwo(),
                    text:Text(name!,style: TextStyle(
                        color: AppColor.fontColorDescription,
                        fontSize: AppFontStyles.descriptionSplashScreenFontSize
                    ),)

                ),
              ),
              Visibility(
                visible: aboutMy!.isNotEmpty,
                child: profilrTile(
                    addOrEdit:"assets/images/Edit1.png" ,
                    imagePath: "assets/images/aboutmy.png",
                    title:"About me",

                    onTap:(){
                    },
                    trueOrFalse:aboutMy!.isEmpty?false:true ,
                    widget:const Text("") ,
                    line: myLineTwo(),
                    text:Text(aboutMy!,style: TextStyle(
                        color: AppColor.fontColorDescription,
                        fontSize: AppFontStyles.descriptionSplashScreenFontSize
                    ),)

                ),
              ),
              Visibility(
                visible:numberConst!.isNotEmpty,
                child: profilrTile(
                    addOrEdit:"assets/images/Edit1.png" ,
                    imagePath: "assets/images/Icon Call.png",
                    title:"Phone Number",

                    onTap:(){
                    },
                    trueOrFalse:numberConst!.isEmpty?false:true ,
                    widget:const Text("") ,
                    line: myLineTwo(),
                    text:Text(numberConst!,style: TextStyle(
                        color: AppColor.fontColorDescription,
                        fontSize: AppFontStyles.descriptionSplashScreenFontSize
                    ),)

                ),
              ),
              Visibility(
                visible:gender!.isNotEmpty,
                child: profilrTile(
                    addOrEdit:"assets/images/Edit1.png" ,
                    imagePath: "assets/images/aboutmy.png",
                    title:"Gender",

                    onTap:(){
                    },
                    trueOrFalse:gender!.isEmpty?false:true ,
                    widget:const Text("") ,
                    line: myLineTwo(),
                    text:Text(gender!,style: TextStyle(
                        color: AppColor.fontColorDescription,
                        fontSize: AppFontStyles.descriptionSplashScreenFontSize
                    ),)

                ),
              ),
              Visibility(
                visible: skill!.isNotEmpty,
                child: profilrTile(
                    addOrEdit:"assets/images/Edit1.png" ,
                    imagePath: "assets/images/skill.png",
                    title:"Skill",

                    onTap:(){
                    },
                    trueOrFalse:skill!.isEmpty?false:true ,
                    widget:const Text("") ,
                    line: myLineTwo(),
                    text:Text(skill!,style: TextStyle(
                        color: AppColor.fontColorDescription,
                        fontSize: AppFontStyles.descriptionSplashScreenFontSize
                    ),)

                ),
              ),
              Visibility(
                visible:locationConst!.isNotEmpty,
                child: profilrTile(
                    addOrEdit:"assets/images/Edit1.png" ,
                    imagePath: "assets/images/Icon Location.png",
                    title:"Location",

                    onTap:(){
                    },
                    trueOrFalse:locationConst!.isEmpty?false:true ,
                    widget:const Text("") ,
                    line: myLineTwo(),
                    text:Text(locationConst!,style: TextStyle(
                        color: AppColor.fontColorDescription,
                        fontSize: AppFontStyles.descriptionSplashScreenFontSize
                    ),)

                ),
              ),
              Visibility(
                visible:workTittle!.isNotEmpty||workDescription!.isNotEmpty ,
                child: profilrTile(
                  addOrEdit:"assets/images/Edit1.png" ,

                  imagePath: "assets/images/work.png",
                  title:"Work experience",
                  onTap:(){

                  },
                  trueOrFalse:workTittle!.isEmpty&&workDescription!.isEmpty?false:true ,
                  widget:const Text("")
                  ,line: myLineTwo(),
                  text:Text("${workTittle!}\n${workDescription!}",style: TextStyle(
                      color: AppColor.fontColorDescription,
                      fontSize: AppFontStyles.descriptionSplashScreenFontSize
                  ),) ,
                ),
              ),
              Visibility(
                visible: educationTittle!.isNotEmpty||educationDescription!.isNotEmpty,
                child: profilrTile(
                    addOrEdit:"assets/images/Edit1.png" ,

                    imagePath: "assets/images/experience.png",
                    title:"Education",

                    onTap:(){

                    },
                    trueOrFalse:educationTittle!.isEmpty&&educationDescription!.isEmpty?false:true ,

                    widget:const Text(""),
                    line: myLineTwo(),
                    text:Text("${educationTittle!}\n${educationDescription!}",style: TextStyle(
                        color: AppColor.fontColorDescription,
                        fontSize: AppFontStyles.descriptionSplashScreenFontSize
                    ),)
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
