import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/Component/style.dart';

import '../../shared/styles/colors.dart';
import '../config/responsive.dart';
import '../config/size_config.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;

  final Color color;
  //final Function function;

  InfoCard(
      {required this.icon,
        required this.label,
        required this.color,
        // required this.function
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          minWidth: SizeConfig.screenWidth / 2 - 80
      ),
      padding: EdgeInsets.only(
          top: 20,
          bottom: 20,
          left: 20,
          right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon,color:AppColor.orangeColor),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 4,
          ),
          PrimaryText(text: label, color: AppColor.bluColor, size: 16),
        ],
      ),
    );
  }
}