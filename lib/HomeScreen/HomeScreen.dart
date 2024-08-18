import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/HomeScreen/AllOpenQuestion.dart';
import 'package:skilled_handyworkers_marketpleace/HomeScreen/AllPost.dart';
import 'package:skilled_handyworkers_marketpleace/HomeScreen/FindPerson.dart';
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
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return  Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,

            actions: [

              Padding(
                padding: const EdgeInsets.symmetric(horizontal:24),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications_none_outlined, size: 24),
                      color: AppColor.navyBlueColor,
                      onPressed: () {
                        setState(() {

                        });
                      },
                    ),
                    GestureDetector(
                      onTap: () {

                        setState(() {
                          navigateTo(context: context,widget: const ProfileScreen());
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
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [

                    Row(
                      children: [
                        Text("98".tr,style: TextStyle(
                            fontSize: AppFontStyles.sizeFontInHome,color: AppColor.fontColor,fontWeight: AppFontStyles.fontWeightBold

                        ),),
                        SizedBox(width: 12,),
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
                                const TextStyle(color: Colors.white,fontSize: AppFontStyles.smallAddressFontSize),),
                                const SizedBox(height: AppFontStyles.padding,),
                                button(
                                    onPressed:() {
                                      navigateTo(context: context,widget: const Search());
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
                    const SizedBox(height: 16,),
                    Row(
                      children: [
                        Text("350".tr,style: TextStyle(
                            fontSize: AppFontStyles.sizeFontInHome,color: AppColor.fontColor,fontWeight: AppFontStyles.fontWeightBold

                        ),),

                      ],),
                  const SizedBox(height: 16,),
                  GridView(
                    shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // عدد الأعمدة
                  crossAxisSpacing: 0.1,
                  mainAxisSpacing: 0.1,
                  childAspectRatio: 2 / 3, // نسبة العرض إلى الارتفاع

                ),
                children: [
                  GridTile(
                    child: GestureDetector(
                      onTap: () {
                     navigateTo(widget: FindPerson(),context: context);
                      },
                      child: JobCard(
                        color: HexColor("#AFECFE").withOpacity(0.5),
                        count: "351".tr,
                        image: "assets/images/headhunting (1) 1.png",
                      ),
                    ),

                  ),
                  Column(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
navigateTo(context: context,widget: AllPost());
HomeCubit.get(context).getPostForLocationAndService(HomeCubit.get(context).currentPage);
                          },
                          child: JobCard2(
                            color: HexColor("#BEAFFE").withOpacity(0.4),
                            count: "103".tr,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            navigateTo(context: context,widget: AllOpenQuestion());
                            HomeCubit.get(context).getPostForLocationAndServiceOpenQuestion(HomeCubit.get(context).currentPageOpenQuestion);
                          },
                          child: JobCard2(
                            color:HexColor("#FFD6AD").withOpacity(0.5),
                             count: "104".tr,
                          ),
                        ),
                      ),
                    ],
                  ),
],)

                  ],
                ),
              ),
            ),
          ),
        );
      },

    );
  }

}
class JobCard extends StatelessWidget {
  final Color color;
  final String count;
  final IconData? icon;
 final String? image;
  const JobCard({
    Key? key,
    required this.color,
    required this.count,
     this.icon, this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image!,width: 40,height: 40,),
          const SizedBox(height: 10),
          Text(
            count,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

        ],
      ),
    );
  }
}
class JobCard2 extends StatelessWidget {
  final Color color;
  final String count;

  const JobCard2({
    Key? key,
    required this.color,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

        ],
      ),
    );
  }
}
