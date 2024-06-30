
import 'package:skilled_handyworkers_marketpleace/shared/network/local/cache_helper.dart';


void signOut(context){// for signOut
  CacheHelper.removeData(key:'accessToken').then((value){
    if(value){

    }
  }
  );
}
String?accessToken='';
int? id=1;
String? image="assets/images/Mask group.png";
String? name="Orlando Diggs";
String? gender="male";
String? location="Damascus";
String? number="0975345628";
String?token="";