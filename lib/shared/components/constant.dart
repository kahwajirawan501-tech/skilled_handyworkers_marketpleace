
import 'package:flutter/material.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/local/cache_helper.dart';


void signOut(context){// for signOut
  CacheHelper.removeData(key:'accessToken').then((value){
    if(value){

    }
  });
}
const green="3a8b91";
String? accessToken="";
String? refreshToken="";


class AppColors {
  static const white = Colors.white;
  static const secondary = Color(0xffa6a6a6);
  static const iconGray = Color(0xff767676);
  static const black = Colors.black;
  static const primary = Color(0xff262626);
  static const primaryBg = Color(0xfff5f5fd);
  static const secondaryBg = Color(0xffececf6);
  static const barBg = Color(0xffe3e3ee);

}