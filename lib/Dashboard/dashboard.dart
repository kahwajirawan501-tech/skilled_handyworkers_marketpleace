import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/DashboardLocation/Location_DashBord.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/DashboardPost/ListPost.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/DashbordServices/Service_DashBord.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/GetUser/ListUser.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/config/size_config.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';

import 'Component/AppBarActionItem.dart';
import 'Component/header.dart';
import 'Component/infoCard.dart';
import 'Component/paymentDetailList.dart';
import 'Component/sideMenu.dart';
import 'Component/style.dart';
// استيراد المسؤول عن التحجيم
import 'config/responsive.dart';

class Dashboard extends StatelessWidget {

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    // اجعل واجهة المستخدم تعرض دائماً تصميم الموبايل
    return Scaffold(
        backgroundColor: Colors.white,
        key: _drawerKey,
        // إخفاء قائمة جانبية لأجهزة سطح المكتب
        drawer: SizedBox(width: 100, child: SideMenu()),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              _drawerKey.currentState!.openDrawer();
            },
            icon: Icon(Icons.menu, color: Colors.black),
          ),
          actions: [
            AppBarActionItems(),
          ],
        ),
        body: SafeArea(
        child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Header(),
    SizedBox(
    height: SizeConfig.blockSizeVertical * 4,
    ),
    SizedBox(
    width: SizeConfig.screenWidth,
    child: Wrap(
    spacing: 20,
    runSpacing: 20,
    alignment: WrapAlignment.spaceBetween,
    children: [
    GestureDetector(
    onTap: () {
    navigateTo(widget: DashBoardPost(), context: context);
    DashBoardCubit.get(context).getPostForLocationAndService(DashBoardCubit.get(context).currentPage);
    },
    child: InfoCard(
    icon: Icons.post_add_outlined,
    label: 'Posts',
    color: HexColor("#FFD6AD").withOpacity(0.5)),
    ),
    GestureDetector(
    onTap: () {
    navigateTo(context: context, widget: ListUser());
    },
    child: InfoCard(
    icon: Icons.account_circle_outlined,
    label: 'User',
    color: HexColor("#BEAFFE").withOpacity(0.4)),
    ),
    GestureDetector(
    onTap: () {
    navigateTo(widget: LocationDashboard(), context: context);
    DashBoardCubit.get(context).getLocation();
    },
    child: InfoCard(
    icon: Icons.add_location_alt_outlined,
    label: 'Region',
    color: HexColor("#BEAFFE").withOpacity(0.4)),
    ),
    GestureDetector(
    onTap: () {
    navigateTo(widget: ServiceDashboard(), context: context);
    DashBoardCubit.get(context).getService();},
      child: InfoCard(
          icon: Icons.add_card_outlined,
          label: 'Services',
          color: HexColor("#FFD6AD").withOpacity(0.5)),
    ),
    ],
    ),
    ),
    ],
    ),
        ),
        ),
    );
  }
}