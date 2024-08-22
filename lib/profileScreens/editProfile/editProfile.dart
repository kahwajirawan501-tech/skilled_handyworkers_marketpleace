import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Registration/cubitLogin/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/searchLocation.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/searchService.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/appBarProfile.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profileScreen.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
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

  int valueR=2;
  int valueRole=0;
  File? image;
  String? imageFile;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        fullName.text = name ?? "";
        dateOfBirth.text = dateOfBirthh ?? "";
        valueR = (gender?.isEmpty ?? true) ? valueR : (gender == "male" ? 1 : 2);
        valueRole=(role==null)?valueRole=0:role=="customer"?valueRole=1:valueRole=2;
        emailAddress.text = email ?? "";
        number.text = numberConst ?? "";
        service.text = skill ?? "";
        location.text = locationConst ?? "";
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ProfileCubit,ProfileStates>(
      listener: (context, state) {
        if(state is PostFileSucssessfullStateStates){

          ProfileCubit.get(context).editProfile(
            ProfileCubit.get(context).image,
            fullName.text,
            dateOfBirth.text,
            valueR == 2 ? "female" : "male",  // This will send "female" if valueR is 1, otherwise "male"
            emailAddress.text,
            number.text,
            location.text,
            service.text,
            valueRole==2?"service_provider":"customer"
          );

        }
        else if(state is PostFileErrorStateStates){
          showToast(text:"316\n".tr, state: ToastStates.EROOR);

        }
        if(state is EditProfileSucssessfullStateStates){
          showToast(text:"317".tr, state: ToastStates.EROOR);
          HomeCubit.get(context).getProfileInformation();


        }
        else if(state is EditProfileErrorStateStates){
          showToast(text:"318\n".tr, state: ToastStates.EROOR);

        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarProfile(
            arrBackVisibility: true,
            visibilitySetting: false,

            onTabArrBack: () {
              Navigator.pop(context);
            },
            email:email!,
            name: name!,
            pathImage:  imageNetwork!.isEmpty ? imageCope! : imageNetwork!,
            textButton: '319'.tr, visibility: false, left: 255, top: 30,
            onTapEditorChange: () {
              bottomSheet(context);
            },

          ),
          body:Container(
            color:AppColor.backgroundColor ,
            height: double.infinity,
            width: double.infinity,
            child:  ConditionalBuilder(
              condition: state is !PostFileLoadStateStates && state is !EditProfileStatesLoadingStateStates,
              builder: (context) =>  SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(left: AppFontStyles.padding,right: AppFontStyles.padding,bottom:AppFontStyles.sizeBetweenBoxAndSubTitle),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle+4,),
                      Text("320".tr,style: TextStyle(
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
                              borderRadius:BorderRadius.circular(

                                  AppFontStyles.borderRadiusTextField) ,
                            )

                        ),),
                      const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle-4,),
                      Text("321".tr,style: TextStyle(
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
                              type:TextInputType.text,
                              suffix: Icons.date_range_rounded,
                              height: 40,
                              borderRadius:BorderRadius.circular(AppFontStyles.borderRadiusTextField) ,
                            )

                        ),),
                      const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle-4,),
                      Text("108".tr,style: TextStyle(
                          fontWeight:AppFontStyles.fontWeightBold ,
                          fontSize: AppFontStyles.descriptionLoginFontSize,
                          color: AppColor.navyBlueColor
                      ),),
                      const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle-4,),
                      Row(
                        children: [
                          Expanded(
                            child: Box(
                              borderRadius: BorderRadius.circular(AppFontStyles.borderRadiusTextField),
                              height: 40,
                              widget: Row(
                                children: [
                                  Radio(
                                    activeColor: AppColor.orangeColor,
                                    value: 1,
                                    groupValue: valueR,
                                    onChanged: (value) {
                                      setState(() {
                                        valueR = value as int;
                                      });
                                    },
                                  ),
                                  Text(
                                    "322".tr,
                                    style: TextStyle(
                                      fontSize: AppFontStyles.descriptionLoginFontSize,
                                      color: AppColor.navyBlueColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: AppFontStyles.sizeBetweenBoxAndSubTitle + 8),
                          Expanded(
                            child: Box(
                              borderRadius: BorderRadius.circular(AppFontStyles.borderRadiusTextField),
                              height: 40,
                              widget: Row(
                                children: [
                                  Radio(
                                    activeColor: AppColor.orangeColor,
                                    value: 2,
                                    groupValue: valueR,
                                    onChanged: (value) {
                                      setState(() {
                                        valueR = value as int;
                                      });
                                    },
                                  ),
                                  Text(
                                    "323".tr,
                                    style: TextStyle(
                                      fontSize: AppFontStyles.descriptionLoginFontSize,
                                      color: AppColor.navyBlueColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle-4,),
                      Text("358".tr,style: TextStyle(
                          fontWeight:AppFontStyles.fontWeightBold ,
                          fontSize: AppFontStyles.descriptionLoginFontSize,
                          color: AppColor.navyBlueColor
                      ),),
                      const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle-4,),
                      Row(
                        children: [
                          Expanded(
                            child: Box(
                              borderRadius: BorderRadius.circular(AppFontStyles.borderRadiusTextField),
                              height: 40,
                              widget: Row(
                                children: [
                                  Radio(
                                    activeColor: AppColor.orangeColor,
                                    value: 1,
                                    groupValue: valueRole,
                                    onChanged: (value) {
                                      setState(() {
                                        valueRole = value as int;
                                      });
                                    },
                                  ),
                                  Text(
                                    "359".tr,
                                    style: TextStyle(
                                      fontSize: AppFontStyles.descriptionLoginFontSize,
                                      color: AppColor.navyBlueColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: AppFontStyles.sizeBetweenBoxAndSubTitle + 8),
                          Expanded(
                            child: Box(
                              borderRadius: BorderRadius.circular(AppFontStyles.borderRadiusTextField),
                              height: 40,
                              widget: Row(
                                children: [
                                  Radio(
                                    activeColor: AppColor.orangeColor,
                                    value: 2,
                                    groupValue: valueRole,
                                    onChanged: (value) {
                                      setState(() {
                                        valueRole = value as int;
                                      });
                                    },
                                  ),
                                  Text(
                                    "360".tr,
                                    style: TextStyle(
                                      fontSize: AppFontStyles.descriptionLoginFontSize,
                                      color: AppColor.navyBlueColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle-4,),

                      Text("324".tr,style: TextStyle(
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
                      Text("107".tr,style: TextStyle(
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
                      Text("109".tr,style: TextStyle(
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
                                    title: "37".tr,
                                    titleSearch: "38".tr,
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
                                service.text.isEmpty ? "39".tr : service.text,
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

                      Text("40".tr,style: TextStyle(
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
                                  print("location selected: $result");

                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding, vertical: 8),
                              child: Text(
                                location.text.isEmpty ? "41".tr : location.text,
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
                              if(image!=null) {
                                ProfileCubit.get(context).postFile(image!);
                              }
                              else{
                                print(image);
                                ProfileCubit.get(context).editProfile
                                  ("", fullName.text, dateOfBirth.text,valueR==2?"female":"male",
                                    emailAddress.text, number.text, location.text, service.text,valueRole==2?"service_provider":"customer");
                              }


                            },
                            text:"127".tr,
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
              fallback:(context) => Center(child: CircularProgressIndicator(color: AppColor.orangeColor,)),
            ),
          ) ,
        );
      },

    );
  }
  void bottomSheet(context) {
    return  showCustomModal(
      context,
      title:"319".tr,
      description:"325".tr,
      titleButton1: "326".tr,
      titleButton2: "327".tr,
      onPressed1: () {
        _getFromGallery();
        Navigator.pop(context);
      },
      onPressed2: () {
        _getFromCamera();
        Navigator.pop(context);
      },);
  }
  _getFromGallery() async {
    var picker=ImagePicker();
    // PickedFile?image;
    final pickFile=await picker.pickImage(source: ImageSource.gallery);

    if (pickFile!=null) {
     setState(() {
       imageFile = pickFile.path;
       image=File(pickFile.path);
       imageFiles=image;
       print(image);

     });
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
     setState(() {
       imageFile = pickFile.path;
       image=File(pickFile.path);
       imageFiles=image;
       print(image);

     });
      // bytes=File(image!.path).readAsBytesSync();
      // img64=base64Encode(bytes!);
    }
  }
}
