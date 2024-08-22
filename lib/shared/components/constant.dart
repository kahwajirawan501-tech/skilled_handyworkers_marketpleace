
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
String ?tokenDashbord="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2YzJlNjA0OWNjYjU3ZDFlYWI2MWZkMiIsImZ1bGxOYW1lIjoiYWRtaW4gYWRtaW4iLCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcyNDA1MjA0MCwiZXhwIjoxNzI0MzExMjQwfQ.BfG_XEGLnWnrFu_eb6WsyIB1BYr-MuUL0Fro3B3iEG0";
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
 String? role;