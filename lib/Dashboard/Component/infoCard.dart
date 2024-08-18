import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/Component/style.dart';

import '../../shared/styles/colors.dart';
import '../config/responsive.dart';
import '../config/size_config.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String amount;
  final Color color;

  InfoCard({required this.icon, required this.label, required this.amount, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: Responsive.isDesktop(context) ? 200 : SizeConfig.screenWidth/2 - 40),
      padding: EdgeInsets.only(
          top: 20, bottom: 20, left: 20, right: Responsive.isMobile(context) ? 20 : 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          PrimaryText(
              text: label,
              color: Colors.black,
              size: 16),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          PrimaryText(
            text: amount,
            size: 18,
            fontWeight: FontWeight.w700,
            color:AppColor.orangeColor ,
          )
        ],
      ),);
  }
}