import 'package:flutter/material.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profileScreen.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  int _value=1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor:  AppColor.backgroundColor,

        leading:IconButton(
          icon:Icon( Icons.arrow_back,color: AppColor.arrowBackColor,),
          onPressed: () {
            navigateAndFinish(widget:const ProfileScreen() ,context: context);
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
                padding: const EdgeInsets.all(AppFontStyles.padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Language",style: TextStyle(
                        fontSize:AppFontStyles.aboutMe,
                        fontWeight:   AppFontStyles.fontWeightSemiBold,
                        color: AppColor.bluColor
                    ),),
                    const SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle,),
                    Box(
                      borderRadius: BorderRadius.circular(AppFontStyles.borderRadiusTextField),
                      height: 80,
                      widget:Padding(
                        padding: const EdgeInsets.only(left: AppFontStyles.padding-10,top: AppFontStyles.padding,bottom:AppFontStyles.padding ),
                        child: Row(
                          children: [
                            Image.asset("assets/images/Arabic.png"),
                            const SizedBox(width: 12,),
                            Text("Arabic",style: TextStyle(
                              fontSize: AppFontStyles.descriptionLoginFontSize,
                              color:AppColor.navyBlueColor
                            ),),
                            Spacer(),

                            Radio(
                                activeColor:AppColor.orangeColor,
                                value:1,
                                groupValue:_value,
                                onChanged:(value){
                                  setState(() {
                                    print(_value);
                                    _value=value as int;

                                  });
                                })
                          ],
                        ),
                      ),),
                    const SizedBox(height: 12,),
                    Box(
                      borderRadius: BorderRadius.circular(AppFontStyles.borderRadiusTextField),
                      height: 80,
                      widget:Padding(
                        padding: const EdgeInsets.only(left: AppFontStyles.padding-10,top: AppFontStyles.padding,bottom:AppFontStyles.padding ),
                        child: Row(
                          children: [
                            Image.asset("assets/images/English.png"),
                            const SizedBox(width: 12,),
                            Text("English",style: TextStyle(
                                fontSize: AppFontStyles.descriptionLoginFontSize,
                                color:AppColor.navyBlueColor
                            ),),
                            Spacer(),
                            Radio(
                                activeColor:AppColor.orangeColor,
                                value:2,
                                groupValue:_value,
                                onChanged:(value){
                                  setState(() {
                                    _value=value as int;

                                  });
                                }),
                          ],
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

              child:  button(
                  colorBackground: AppColor.navyBlueColor,
                  onPressed:(){

                  },
                  text:"Save",
                  height: 50,
                  width: 213,
                  fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                  fontWeight: AppFontStyles.fontWeightBold,
                  color:Colors.white), )
        ],
      ) ,
    );
  }
}
