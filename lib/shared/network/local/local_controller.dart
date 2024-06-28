
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'cache_helper.dart';


class MyLocalController extends GetxController{
  Locale intiallang =CacheHelper.getData(key: "lang")==null?Get.deviceLocale!: Locale(CacheHelper.getData(key: "lang"));
  void changeLang(String code){
    Locale local=Locale(code);
    CacheHelper.saveData(key: "lang", value: code);
    Get.updateLocale(local);
  }
}