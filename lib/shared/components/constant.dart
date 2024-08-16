
import 'dart:io';

import 'package:skilled_handyworkers_marketpleace/shared/network/local/cache_helper.dart';


String signOut(context){// for signOut
  CacheHelper.removeData(key: "accessToken").then((value){
    accessToken="";
  });

if(CacheHelper.getData(key: "accessToken")==null){
  return "Logout Successful";
}
else{
  return "Logout Not Successful";
}

}
String? accessToken=CacheHelper.getData(key: "accessToken");

String? id="";

String? imageNetwork="";
String? imageCope="assets/images/downloadp.jpg";
String? name="";
String? email="";
String? gender="";
String? locationConst="";
String? numberConst="";
String pathImageCope="assets/images/aboutmy.png";
String api="http://192.168.43.142:3000";
 String?aboutMy="";
 String?workTittle="";
 String?workDescription="";
String?dateOfBirthh="";
 String?educationTittle="";
 String?educationDescription="";
 String?skill="";
 File ?imageFiles;