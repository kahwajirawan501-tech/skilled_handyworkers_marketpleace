import 'package:flutter/material.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/Component/style.dart';

import 'package:skilled_handyworkers_marketpleace/Dashboard/config/responsive.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';

class Header extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryText(
                      text: 'Dashboard',
                      size: 30,
                      fontWeight: FontWeight.w800,
                    color: AppColor.navyBlueColor,),
                  PrimaryText(
                    text: 'Payments updates',
                    size: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColor.fontColorDescription,
                  )
                ]),
          ),
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: Responsive.isDesktop(context) ? 1 : 3,
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey,
                  contentPadding:
                  EdgeInsets.only(left: 40.0, right: 5),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color:Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.black, fontSize: 14)
              ),
            ),
          ),
        ]);
  }
}