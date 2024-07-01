import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/searchLocation.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/searchService.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/appBarProfile.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profileScreen.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class EditProfile extends StatefulWidget {
   EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var fullName=TextEditingController();

   var dateOfBirth=TextEditingController();

   var emailAddress=TextEditingController();

   var number=TextEditingController();

   var location=TextEditingController();

  var service=TextEditingController();

  int _value=2;

  File? image;
  String? imageFile;

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarProfile(
        arrBackVisibility: true,
        visibilitySetting: false,
           onTabArrBack: () {
             navigateAndFinish(context:context,widget: ProfileScreen());
},
        email:"OrlandoDiggs@gmail.com" ,
        name: "Orlando Diggs",pathImage: "assets/images/Mask group.png",
       textButton: 'Change image', visibility: false, left: 255, top: 30,
        onTapEditorChange: () {
          bottomSheet(context);
        },

      ),
      body:Container(
        color:AppColor.backgroundColor ,
        height: double.infinity,
        width: double.infinity,
        child:  SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: AppFontStyles.padding,right: AppFontStyles.padding,bottom:AppFontStyles.sizeBetweenBoxAndSubTitle),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle+4,),
                Text("Full name",style: TextStyle(
                    fontWeight:AppFontStyles.fontWeightBold ,
                    fontSize: AppFontStyles.descriptionLoginFontSize,
                    color: AppColor.navyBlueColor
                ),),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle-4,),
                Box(
                  borderRadius: BorderRadius.circular(AppFontStyles.borderRadiusTextField),
                  height: 40,
                  widget:Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding),
                      child: defaultTextField(
                        controller: fullName,
                        type:TextInputType.text,

                        height: 50,
                        borderRadius:BorderRadius.circular(AppFontStyles.borderRadiusTextField) ,
                      )

                  ),),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle-4,),
                Text("Date of birth",style: TextStyle(
                    fontWeight:AppFontStyles.fontWeightBold ,
                    fontSize: AppFontStyles.descriptionLoginFontSize,
                    color: AppColor.navyBlueColor
                ),),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle-4,),
                Box(
                  borderRadius: BorderRadius.circular(AppFontStyles.borderRadiusTextField),
                  height: 40,
                  widget:Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding),
                      child: defaultTextField(
                        controller: dateOfBirth,
                        type:TextInputType.datetime,
                        suffix: Icons.date_range_rounded,
                        height: 40,
                        borderRadius:BorderRadius.circular(AppFontStyles.borderRadiusTextField) ,
                      )

                  ),),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle-4,),
                Text("Gender",style: TextStyle(
                    fontWeight:AppFontStyles.fontWeightBold ,
                    fontSize: AppFontStyles.descriptionLoginFontSize,
                    color: AppColor.navyBlueColor
                ),),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle-4,),
                Row(
                  children: [
                    Expanded(

                      child:Box(
                       borderRadius: BorderRadius.circular(AppFontStyles.borderRadiusTextField),
                       height: 40,
                       widget:Row(
                        children: [
                             Radio(
                    activeColor:AppColor.orangeColor,
                    value:2,
                    groupValue:_value,
                    onChanged:(value){
                      setState(() {
                        print(_value);
                        _value=value as int;

                      });
                    }),
                         Text("Male",style: TextStyle(
                    fontSize: AppFontStyles.descriptionLoginFontSize,
                    color:AppColor.navyBlueColor
                ),),


              ],
            ),
          )
                    ),
                    const SizedBox(width: AppFontStyles.sizeBetweenBoxAndSubTitle+8,),

                    Expanded(

                      child: Box(
                        borderRadius: BorderRadius.circular(AppFontStyles.borderRadiusTextField),
                        height: 40,
                        widget:Row(
                          children: [
                            Radio(
                                activeColor:AppColor.orangeColor,
                                value:1,
                                groupValue:_value,
                                onChanged:(value){
                                  setState(() {
                                    print(_value);
                                    _value=value as int;

                                  });
                                }),
                            Text("Female",style: TextStyle(
                                fontSize: AppFontStyles.descriptionLoginFontSize,
                                color:AppColor.navyBlueColor
                            ),),


                          ],
                        ),
                    )
                    ),
                  ],
                ),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle-4,),
                Text("Email address",style: TextStyle(
                    fontWeight:AppFontStyles.fontWeightBold ,
                    fontSize: AppFontStyles.descriptionLoginFontSize,
                    color: AppColor.navyBlueColor
                ),),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle-4,),
                Box(
                  borderRadius: BorderRadius.circular(AppFontStyles.borderRadiusTextField),
                  height: 40,
                  widget:Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding),
                      child: defaultTextField(
                        controller: emailAddress,
                        type:TextInputType.emailAddress,
                        height: 40,
                        borderRadius:BorderRadius.circular(AppFontStyles.borderRadiusTextField) ,
                      )

                  ),),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle-4,),
                Text("Phone number",style: TextStyle(
                    fontWeight:AppFontStyles.fontWeightBold ,
                    fontSize: AppFontStyles.descriptionLoginFontSize,
                    color: AppColor.navyBlueColor
                ),),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle-4,),
                Box(
                  borderRadius: BorderRadius.circular(AppFontStyles.borderRadiusTextField),
                  height: 40,
                  widget:Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding),
                      child: defaultTextField(
                        controller: number,
                        type:TextInputType.number,
                        height: 40,
                        borderRadius:BorderRadius.circular(AppFontStyles.borderRadiusTextField) ,
                      )

                  ),),

                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle-4,),
                Text("Skill",style: TextStyle(
                    fontWeight:AppFontStyles.fontWeightBold ,
                    fontSize: AppFontStyles.descriptionLoginFontSize,
                    color: AppColor.navyBlueColor
                ),),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle-4,),
                Box(
                  widget: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Service(
                              title: "Add Service",
                              titleSearch: "Search",
                              textController: service,
                              widget:  EditProfile(),
                            ),
                          ),
                        );
                        if (result != null && result is String) {
                          setState(() {
                            service.text = result;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding, vertical: 8),
                        child: Text(
                          service.text.isEmpty ? "Select service" : service.text,
                          style: TextStyle(
                            color: AppColor.grayColorFont,
                            fontSize: AppFontStyles.descriptionLoginFontSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                  height: 40,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle-4,),

                Text("Location",style: TextStyle(
                    fontWeight:AppFontStyles.fontWeightBold ,
                    fontSize: AppFontStyles.descriptionLoginFontSize,
                    color: AppColor.navyBlueColor
                ),),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle-4,),
                Box(
                  widget: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Location(
                              textController: location,
                              widget:  EditProfile(),
                            ),
                          ),
                        );
                        if (result != null && result is String) {
                          setState(() {
                            location.text = result;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding, vertical: 8),
                        child: Text(
                          location.text.isEmpty ? "Select location" : location.text,
                          style: TextStyle(
                            color: AppColor.grayColorFont,
                            fontSize: AppFontStyles.descriptionLoginFontSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                  height: 40,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),

                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle+24,),

                Center(
                  child: button(
                      colorBackground: AppColor.navyBlueColor,
                      onPressed:(){

                      },
                      text:"Save",
                      height: 50,
                      width: 213,
                      fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                      fontWeight: AppFontStyles.fontWeightBold,
                      color:Colors.white),
                ),
              ],

            ),
          ),
        ),
      ) ,
    );
  }
  void bottomSheet(context) {
    return  showCustomModal(
      context,
      title:"Change Image",
      description:" choose the picture from the Gallery or Camera ? ",
      titleButton1: "From Gallery",
      titleButton2: "From Camera",
      onPressed1: () {
        _getFromCamera();
      },
      onPressed2: () {
        _getFromGallery();
      },);
  }
  _getFromGallery() async {
    var picker=ImagePicker();
    // PickedFile?image;
    final pickFile=await picker.pickImage(source: ImageSource.gallery);

    if (pickFile!=null) {
      imageFile = pickFile.path;
      image=File(pickFile.path);
      // bytes=File(image!.path).readAsBytesSync();
      // img64=base64Encode(bytes!);

    }

  }

  /// Get from Camera
  _getFromCamera() async {
    var picker=ImagePicker();
    // PickedFile?image;
    final pickFile=await picker.pickImage(source: ImageSource.camera);

    if (pickFile!=null) {
      imageFile = pickFile.path;
      image=File(pickFile.path);
      // bytes=File(image!.path).readAsBytesSync();
      // img64=base64Encode(bytes!);

    }
  }
}
