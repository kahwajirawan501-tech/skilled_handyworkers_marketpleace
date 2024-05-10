import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';

void navigateTo({context,widget})=>Navigator.push(//الصفحات لسا معي اذا عملت باك
    context
    , MaterialPageRoute(
    builder: (context)=>widget,
));
void navigateAndFinish({context,widget})=>Navigator.pushAndRemoveUntil(//هي ماعد ارجع ع صفحة متل تسجيل الدخول
    context
    , MaterialPageRoute(
  builder: (context)=>widget,
),
    ( Route<dynamic>route)=>false,//هاد الصفحة يلي فاتت بدي ياها ولا لا
);

void showToast({
  required String text,
  required ToastStates state,
})=>Fluttertoast.showToast(
          msg: text,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,//ظهور
          timeInSecForIosWeb: 5,
          backgroundColor: chooseToastColor(state),
          textColor: Colors.white,
          fontSize: 16.0,

      );
      enum ToastStates{
        SUCCESS,EROOR,WARNING
      }
      Color chooseToastColor(ToastStates state)
      {  Color color;
        switch(state){
          case ToastStates.SUCCESS:
            color= HexColor(green.toString());

            break;
          case ToastStates.EROOR:
            color=  Colors.grey;
            break;
          case ToastStates.WARNING:
            color=  Colors.amber;
            break;

        }
        return color;

      }


 Widget myLine()=>Padding(
   padding: const EdgeInsets.symmetric(vertical: 8.0),
   child: Container(width:double.infinity ,height: 1,color:Colors.grey,),
 );

