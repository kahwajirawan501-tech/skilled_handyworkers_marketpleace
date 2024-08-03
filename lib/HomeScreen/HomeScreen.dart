import 'package:flutter/material.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/Search.dart';
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
      backgroundColor: Colors.white,
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding,vertical:  AppFontStyles.padding+24),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
           SizedBox(height: 34,),
            Row(children: [
              Text("Hello",style: TextStyle(
                fontSize: AppFontStyles.sizeFontInHome,color: AppColor.fontColor,fontWeight: AppFontStyles.fontWeightBold

              ),)
            ],),
            Row(children: [
              Text("Orlando Diggs .",style: TextStyle(
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
                        const Text("Find the Service \n you need",style:
                        TextStyle(color: Colors.white,fontSize: AppFontStyles.smallAddressFontSize),),
                        SizedBox(height: AppFontStyles.padding,),
                        button(
                            onPressed:() {
                           navigateTo(context: context,widget: Search());
                            },
                            text:"Search Now",
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
