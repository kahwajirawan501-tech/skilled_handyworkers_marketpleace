import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/AddPosting/addOpenQuestion.dart';
import 'package:skilled_handyworkers_marketpleace/AddPosting/addPost.dart';
import 'package:skilled_handyworkers_marketpleace/Chat_Messages/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: cubit.pages[cubit.selectedIndex],
          bottomNavigationBar: Container(
            padding: const EdgeInsets.only(bottom: 10), // Adjust padding if necessary
            color: Colors.white, // Set background color for the navigation bar
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Spacer(),
                IconButton(
                  icon: Icon(Icons.home_outlined, size: 24),
                  color: cubit.selectedIndex == 0 ? AppColor.bottomNavigationBar : AppColor.unSelectItemBottomBar,
                  onPressed: () {
                    setState(() {
                      cubit.onItemTappedForBottomNavigationBar(0);

                    });
                  },
                ),
                // Spacer(),
                // IconButton(
                //   icon: Icon(Icons.perm_identity_outlined, size: 24),
                //   color: cubit.selectedIndex == 1 ? AppColor.bottomNavigationBar : AppColor.unSelectItemBottomBar,
                //   onPressed: () {
                //     setState(() {
                //       cubit.onItemTappedForBottomNavigationBar(1);
                //
                //     });
                //   },
                // ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.group_work_outlined, size: 24),
                  color: cubit.selectedIndex == 2 ? AppColor.bottomNavigationBar : AppColor.unSelectItemBottomBar,
                  onPressed: () {
                    setState(() {
                      cubit.onItemTappedForBottomNavigationBar(2);

                    });
                  },
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                   if(role==null){
      showToast(text:"356".tr, state: ToastStates.SUCCESS)   ;
                   }
                   else if(role=="service_provider"){
                     showCustomModal(
                       context,
                       title: "64".tr,
                       description: "65".tr,
                       titleButton1: "66".tr,
                       titleButton2: "67".tr,
                       onPressed1: () {
                         Navigator.pop(context);

                         navigateTo(context: context,widget: AddPost());
                       },
                       onPressed2: () {
                         Navigator.pop(context);

                         navigateTo(context: context,widget: AddOpenQuestion());

                       },);
                   }
                   else if(role=="customer"){
                     showCustomModalCustomer(
                       context,
                       title: "64".tr,
                       description: "357".tr,
                       titleButton2: "67".tr,

                       onPressed2: () {
                         Navigator.pop(context);

                         navigateTo(context: context,widget: AddOpenQuestion());

                       },);
                   }
                  },
                  icon: Icon(
                    Icons.add_circle,
                    color: AppColor.navyBlueColor,
                    size: 36,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(CupertinoIcons.bubble_left, size: 24),
                  color: cubit.selectedIndex == 3 ? AppColor.bottomNavigationBar : AppColor.unSelectItemBottomBar,
                  onPressed: () {
                    setState(() {
                      cubit.onItemTappedForBottomNavigationBar(3);
                //    ChatCubit.get(context).getUsersMessage();
                    });
                  },
                ),
                // Spacer(),
                // IconButton(
                //   icon: Icon(Icons.notifications_none_outlined, size: 24),
                //   color: cubit.selectedIndex == 4? AppColor.bottomNavigationBar : AppColor.unSelectItemBottomBar,
                //   onPressed: () {
                //     setState(() {
                //       cubit.onItemTappedForBottomNavigationBar(4);
                //
                //     });
                //   },
                // ),
                Spacer(),

                IconButton(
                  icon: Icon(Icons.bookmark_border_outlined, size: 24),
                  color: cubit.selectedIndex == 5 ? AppColor.bottomNavigationBar : AppColor.unSelectItemBottomBar,
                  onPressed: () {
                    setState(() {
                      cubit.onItemTappedForBottomNavigationBar(5);

                    });
                  },
                ),
                Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
