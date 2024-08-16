import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/Search.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profileScreen.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,

        actions: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal:24),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.notifications_none_outlined, size: 24),
                  color: AppColor.navyBlueColor,
                  onPressed: () {
                    setState(() {

                    });
                  },
                ),
                GestureDetector(
                  onTap: () {

                      setState(() {
                        navigateTo(context: context,widget: ProfileScreen());
                      });

                  },
                  child: ClipOval(
                    child:imageNetwork!.isNotEmpty?Image.network(api+imageNetwork!, fit: BoxFit.cover,
                      height: 30,
                      width: 30,):  Icon(Icons.perm_identity_outlined, size: 25,color:  AppColor.navyBlueColor ,),


                    ),
                ),



              ],
            ),
          ),

        ],
      ),
      backgroundColor: Colors.white,
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding,vertical:  AppFontStyles.padding),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [

            Row(
              children: [
              Text("98".tr,style: TextStyle(
                fontSize: AppFontStyles.sizeFontInHome,color: AppColor.fontColor,fontWeight: AppFontStyles.fontWeightBold

              ),),

            ],),
            Row(children: [
              Text(name!,style: TextStyle(
                  fontSize: AppFontStyles.sizeFontInHome,color: AppColor.fontColor,fontWeight: AppFontStyles.fontWeightBold

              ),)
            ],),
            Stack(
              children: [
                Image.asset("assets/images/Mask group new.png",fit: BoxFit.cover,width: double.infinity,),
                 Positioned(
                    left: 12,
                    top:42,
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text("${"99".tr}\n${"100".tr}",style:
                        TextStyle(color: Colors.white,fontSize: AppFontStyles.smallAddressFontSize),),
                        SizedBox(height: AppFontStyles.padding,),
                        button(
                            onPressed:() {
                           navigateTo(context: context,widget: Search());
                            },
                            text:"101".tr,
                            height: 26,
                            width: 90,
                            fontSize:9,
                            fontWeight: AppFontStyles.fontWeightMedium,
                            color: Colors.white,
                            colorBackground: AppColor.orangeColor)
                      ],
                    )
                )
              ],
            ),

          ],
        ),
      ),
    ),
    );
  }
}
