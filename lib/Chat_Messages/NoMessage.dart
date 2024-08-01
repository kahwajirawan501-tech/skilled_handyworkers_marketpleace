import 'package:flutter/material.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';



class NoMessage extends StatelessWidget {
  const NoMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/NoMessage.png"),
            SizedBox(height: 36,),
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


          ],
        ),
      ),
    );
  }
}
