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
import 'config/responsive.dart';


class Dashboard extends StatelessWidget {

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
TextEditingController textEditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor:Colors.white ,
      key: _drawerKey,
      drawer: SizedBox(width: 100, child: SideMenu()),
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              _drawerKey.currentState!.openDrawer();
            },
            icon: Icon(Icons.menu, color: Colors.black)),
        actions: [
          AppBarActionItems(),
        ],
      )
          : PreferredSize(
        preferredSize: Size.zero,
        child: SizedBox(),
      ),
      body: SafeArea(

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 1,
                child: SideMenu(),
              ),
            Expanded(
                flex: 10,
                child: SafeArea(
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
                              InfoCard(
                                  icon: Icons.post_add_outlined,
                                  label: 'Posts',
                                  amount: '\$1200',
                              color:HexColor("#FFD6AD").withOpacity(0.5)),
                              InfoCard(
                                  icon: Icons.account_circle_outlined,
                                  label: 'User',
                                  amount: '\$1200',
                                  color:HexColor("#FFD6AD").withOpacity(0.5)),
                              InfoCard(
                                  icon: Icons.add_location_alt_outlined,
                                  label: 'Region',
                                  amount: '\$1200',
                                  color:HexColor("#BEAFFE").withOpacity(0.4)),
                              InfoCard(
                                  icon: Icons.add_card_outlined,
                                  label: 'Services',
                                  amount: '\$1200',
                                  color:HexColor("#FFD6AD").withOpacity(0.5)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryText(
                                  onTap: () {
                                    navigateTo(widget: LocationDashboard(),context: context
                                    );
                                    DashBoardCubit.get(context).getLocation();
                                  },
                                  text: 'Balance',
                                  size: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.yellow,
                                ),
                                PrimaryText(
                                  onTap: () {
                                    navigateTo(widget: DashBoardPost(),context: context);
                                    DashBoardCubit.get(context).getPostForLocationAndService(DashBoardCubit.get(context).currentPage);
                                  },
                                    text: '\$1500',
                                    size: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800),
                              ],
                            ),
                            PrimaryText(
                              onTap: () {
                                navigateTo(widget: ServiceDashboard(),context: context);
                                DashBoardCubit.get(context).getService();

                              },
                              text: 'Past 30 DAYS',
                              size: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.orange,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 3,
                        ),
                        // Container(
                        //   height: 180,
                        //   child: BarChartCopmponent(),
                        // ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimaryText(
                              onTap: () {
                                navigateTo(context: context,widget: ListUser());
                              },
                                color: Colors.blue,
                                text: 'History',
                                size: 30,
                                fontWeight: FontWeight.w800),
                            PrimaryText(
                              text: 'Transaction of lat 6 month',
                              size: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 3,
                        ),
                       Container(),
                        if (!Responsive.isDesktop(context)) PaymentDetailList()
                      ],
                    ),
                  ),
                )),
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 4,
                child: SafeArea(
                  child: Container(
                    width: double.infinity,
                    height: SizeConfig.screenHeight,
                    decoration: BoxDecoration(color: Colors.white),
                    child: SingleChildScrollView(
                      padding:
                      EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                      child: Column(
                        children: [
                          AppBarActionItems(),
                          PaymentDetailList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}