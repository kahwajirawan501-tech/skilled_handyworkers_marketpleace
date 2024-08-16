import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';



class NoMessage extends StatelessWidget {
  const NoMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/NoMessage.png"),
          SizedBox(height: 36,),
          Text("76".tr,style: TextStyle(
              color: AppColor.bluColor,
              fontWeight: AppFontStyles.fontWeightSemiBold7,
              fontSize: AppFontStyles.aboutMe
          ),),
          SizedBox(height: 16,),
          Text("78".tr,style: TextStyle(
              color: AppColor.fontColorDescription,
              fontWeight: AppFontStyles.fontWeightSemiBold4,
              fontSize: AppFontStyles.sizeBetweenBoxAndSubTitle
          ),),
          SizedBox(height: 4,),
          Center(
            child: Text("79".tr,style: TextStyle(
                color: AppColor.fontColorDescription,
                fontWeight: AppFontStyles.fontWeightSemiBold4,
                fontSize: AppFontStyles.sizeBetweenBoxAndSubTitle
            ),),
          ),


        ],
      ),
    );
  }
}
