import 'package:flutter/material.dart';

import 'package:skilled_handyworkers_marketpleace/profileScreens/profilrTile.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class SeeMore extends StatefulWidget {
  final String nameCustomer;
  final String aboutMyCustomer;
  final String phoneCustomer;
  final String genderCustomer;
  final String locationCustomer;
  final String skillCustomer;
  final String jobTittleCustomer;
  final String jobDescriptionCustomer;
  final String educationCustomer;
  final String educationDescriptionCustomer;

  const SeeMore({Key? key, required this.nameCustomer, required this.aboutMyCustomer,
    required this.phoneCustomer, required this.genderCustomer, required this.locationCustomer, required this.skillCustomer, required this.jobTittleCustomer, required this.jobDescriptionCustomer, required this.educationCustomer, required this.educationDescriptionCustomer}) : super(key: key);

  @override
  State<SeeMore> createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> {
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
                visible: widget.nameCustomer.isNotEmpty,
                child: profilrTile(
                    addOrEdit:"assets/images/Edit1.png" ,
                    imagePath: "assets/images/aboutmy.png",
                    title:"Full Name",

                    onTap:(){
                    },
                    trueOrFalse:widget.nameCustomer.isEmpty?false:true ,
                    widget:const Text("") ,
                    line: myLineTwo(),
                    text:Text(widget.nameCustomer,style: TextStyle(
                        color: AppColor.fontColorDescription,
                        fontSize: AppFontStyles.descriptionSplashScreenFontSize
                    ),)

                ),
              ),
              Visibility(
                visible: widget.aboutMyCustomer.isNotEmpty,
                child: profilrTile(
                    addOrEdit:"assets/images/Edit1.png" ,
                    imagePath: "assets/images/aboutmy.png",
                    title:"About me",

                    onTap:(){
                    },
                    trueOrFalse:widget.aboutMyCustomer.isEmpty?false:true ,
                    widget:const Text("") ,
                    line: myLineTwo(),
                    text:Text(widget.aboutMyCustomer,style: TextStyle(
                        color: AppColor.fontColorDescription,
                        fontSize: AppFontStyles.descriptionSplashScreenFontSize
                    ),)

                ),
              ),
              Visibility(
                visible:widget.phoneCustomer.isNotEmpty,
                child: profilrTile(
                    addOrEdit:"assets/images/Edit1.png" ,
                    imagePath: "assets/images/Icon Call.png",
                    title:"Phone Number",

                    onTap:(){
                    },
                    trueOrFalse:widget.phoneCustomer.isEmpty?false:true ,
                    widget:const Text("") ,
                    line: myLineTwo(),
                    text:Text(widget.phoneCustomer,style: TextStyle(
                        color: AppColor.fontColorDescription,
                        fontSize: AppFontStyles.descriptionSplashScreenFontSize
                    ),)

                ),
              ),
              Visibility(
                visible:widget.genderCustomer.isNotEmpty,
                child: profilrTile(
                    addOrEdit:"assets/images/Edit1.png" ,
                    imagePath: "assets/images/aboutmy.png",
                    title:"Gender",

                    onTap:(){
                    },
                    trueOrFalse:widget.genderCustomer.isEmpty?false:true ,
                    widget:const Text("") ,
                    line: myLineTwo(),
                    text:Text(widget.genderCustomer,style: TextStyle(
                        color: AppColor.fontColorDescription,
                        fontSize: AppFontStyles.descriptionSplashScreenFontSize
                    ),)

                ),
              ),
              Visibility(
                visible: widget.skillCustomer.isNotEmpty,
                child: profilrTile(
                    addOrEdit:"assets/images/Edit1.png" ,
                    imagePath: "assets/images/skill.png",
                    title:"Skill",

                    onTap:(){
                    },
                    trueOrFalse:widget.skillCustomer.isEmpty?false:true ,
                    widget:const Text("") ,
                    line: myLineTwo(),
                    text:Text(widget.skillCustomer,style: TextStyle(
                        color: AppColor.fontColorDescription,
                        fontSize: AppFontStyles.descriptionSplashScreenFontSize
                    ),)

                ),
              ),
              Visibility(
                visible:widget.locationCustomer.isNotEmpty,
                child: profilrTile(
                    addOrEdit:"assets/images/Edit1.png" ,
                    imagePath: "assets/images/Icon Location.png",
                    title:"Location",

                    onTap:(){
                    },
                    trueOrFalse:widget.locationCustomer.isEmpty?false:true ,
                    widget:const Text("") ,
                    line: myLineTwo(),
                    text:Text(widget.locationCustomer,style: TextStyle(
                        color: AppColor.fontColorDescription,
                        fontSize: AppFontStyles.descriptionSplashScreenFontSize
                    ),)

                ),
              ),
              Visibility(
                visible:widget.jobTittleCustomer.isNotEmpty||widget.jobDescriptionCustomer.isNotEmpty ,
                child: profilrTile(
                  addOrEdit:"assets/images/Edit1.png" ,

                  imagePath: "assets/images/work.png",
                  title:"Work experience",
                  onTap:(){

                  },
                  trueOrFalse:widget.jobTittleCustomer.isEmpty&&widget.jobDescriptionCustomer.isEmpty?false:true ,
                  widget:const Text("")
                  ,line: myLineTwo(),
                  text:Text("${widget.jobTittleCustomer}\n${widget.jobDescriptionCustomer}",style: TextStyle(
                      color: AppColor.fontColorDescription,
                      fontSize: AppFontStyles.descriptionSplashScreenFontSize
                  ),) ,
                ),
              ),
              Visibility(
                visible: widget.educationCustomer.isNotEmpty||widget.educationDescriptionCustomer.isNotEmpty,
                child: profilrTile(
                    addOrEdit:"assets/images/Edit1.png" ,

                    imagePath: "assets/images/experience.png",
                    title:"Education",

                    onTap:(){

                    },
                    trueOrFalse: widget.educationCustomer.isEmpty&&widget.educationDescriptionCustomer.isEmpty?false:true ,

                    widget:const Text(""),
                    line: myLineTwo(),
                    text:Text("${ widget.educationCustomer}\n${widget.educationDescriptionCustomer}",style: TextStyle(
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
