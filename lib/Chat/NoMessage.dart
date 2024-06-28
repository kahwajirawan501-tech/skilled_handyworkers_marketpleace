import 'package:flutter/material.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';



class NoMessage extends StatelessWidget {
  const NoMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/NoMessage.png"),
              SizedBox(height: 10,),
              Text("No Message",style: TextStyle(
                color: AppColor.bluColor,
                fontWeight: AppFontStyles.fontWeightSemiBold7,
                fontSize: AppFontStyles.aboutMe
              ),),
              SizedBox(height: 16,),
              Text("You currently have no incoming message",style: TextStyle(
                  color: AppColor.fontColorDescription,
                  fontWeight: AppFontStyles.fontWeightSemiBold4,
                  fontSize: AppFontStyles.sizeBetweenBoxAndSubTitle
              ),),
          SizedBox(height: 4,),
              Center(
                child: Text(" thank you",style: TextStyle(
                    color: AppColor.fontColorDescription,
                    fontWeight: AppFontStyles.fontWeightSemiBold4,
                    fontSize: AppFontStyles.sizeBetweenBoxAndSubTitle
                ),),
              ),
              SizedBox(height: 100,),
               button(
                text: 'Create a message'.toUpperCase(),
                color: Colors.white,
                fontSize:
                AppFontStyles.descriptionSplashScreenFontSize,
                fontWeight: AppFontStyles.fontWeightSemiBold7,
                height: 50,
                width: 213,
                onPressed: () {
                 },
                colorBackground: AppColor.navyBlueColor,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
