import 'package:flutter/material.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/Component/paymentLlistTile.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/Component/style.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/config/size_config.dart';

import '../data.dart';


class PaymentDetailList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: SizeConfig.blockSizeVertical * 5,
      ),
      Container(
        decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(30), boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 15.0,
            offset: const Offset(
              10.0,
              15.0,
            ),
          )
        ]),
        child: Image.asset('assets/card.png'),
      ),
      SizedBox(
        height: SizeConfig.blockSizeVertical * 5,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryText(
              text: 'Recent Activities', size: 18, fontWeight: FontWeight.w800),
          PrimaryText(
            text: '02 Mar 2021',
            size: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ],
      ),
      SizedBox(
        height: SizeConfig.blockSizeVertical * 2,
      ),
      // Column(
      //   children: List.generate(
      //     recentActivities.length,
      //         (index) => PaymentListTile(
      //         icon: recentActivities[index]["icon"],
      //         label: recentActivities[index]["label"],
      //         amount: recentActivities[index]["amount"]),
      //   ),
      // ),
      SizedBox(
        height: SizeConfig.blockSizeVertical * 5,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryText(
              text: 'Upcoming Payments', size: 18, fontWeight: FontWeight.w800),
          PrimaryText(
            text: '02 Mar 2021',
            size: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ],
      ),
      SizedBox(
        height: SizeConfig.blockSizeVertical * 2,
      ),
      // Column(
      //   children: List.generate(
      //     upcomingPayments.length,
      //         (index) => PaymentListTile(
      //         icon: upcomingPayments[index]["icon"],
      //         label: upcomingPayments[index]["label"],
      //         amount: upcomingPayments[index]["amount"]),
      //   ),
      // ),
    ]);
  }
}