import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

import '../styles/colors.dart';

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
).then((_) {
 // Refresh the state when returning back
});

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
            color=AppColor.grayColorFont;

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

Widget button({
  required VoidCallback? onPressed ,
  required String text,
  required double height,
  required double width,
  required double fontSize,
  required FontWeight? fontWeight,
  required Color color,
  required Color colorBackground,
  Function? function,

})=>Container(
  height: height,
  width:width ,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(6),
    color: colorBackground
  ),
  child:TextButton(

    onPressed:onPressed ,
    child:Center(child: Text(text.toUpperCase(), style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight
        ,color: color
    ),)) ,
  ),
);

void showCustomModal(BuildContext context,{
  required String title,
  required String  description,
  required String titleButton1,
  required String titleButton2,
  required VoidCallback? onPressed1 ,
  required VoidCallback? onPressed2 ,





}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 300,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white, // لون خلفية القائمة
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppFontStyles.borderRadius + 10),
            topRight: Radius.circular(AppFontStyles.borderRadius + 10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppFontStyles.padding),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColor.navyBlueColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppFontStyles.borderRadius),
                  ),
                ),
                width: 30,
                height: 3,
              ),
              const SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle),
              Text(
                title,
                style: TextStyle(
                  color: AppColor.navyBlueColor,
                  fontSize: AppFontStyles.aboutMe,
                  fontWeight: AppFontStyles.fontWeightBold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  color: AppColor.fontColorDescription,
                  fontSize: AppFontStyles.descriptionLoginFontSize,
                  fontWeight: AppFontStyles.fontWeightBold,
                ),
              ),
              const SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle + 16),
              button(
                onPressed:onPressed1,
                text: titleButton1,
                height: 50,
                width: 213,
                fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                fontWeight: AppFontStyles.fontWeightBold,
                color: Colors.white,
                colorBackground: AppColor.navyBlueColor,
                function: (){},
              ),
              const SizedBox(height: 8),
              button(
                onPressed: onPressed2,
                text: titleButton2,
                height: 50,
                width: 213,
                fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                fontWeight: AppFontStyles.fontWeightBold,
                color: Colors.white,
                colorBackground: AppColor.googleColor, function: (){},
              ),
            ],
          ),
        ),
      );
    },
  );
}
Widget defaultTextFieldLog({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  bool isPassword = false,
  required validate,
  String? label,
  String? hint,
  IconData? prefix,
  IconData? suffix,
  Function? suffixPressed,

}) =>
    TextFormField(
      cursorColor:AppColor.navyBlueColor,//تغير لون المؤشر
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      // onFieldSubmitted: onSubmit!(),
      //onChanged: onChange!(),
      validator: validate,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0), // ضبط موضع النص
        hintStyle: TextStyle(
          fontSize: 14,
          color: HexColor("6C6D72"),
          overflow: TextOverflow.visible,
          shadows:[Shadow(color:Colors.cyan)]
        ),
        //isDense: false,
        alignLabelWithHint: false,
        filled: true,
        fillColor:Colors.white,
        labelText: label,
        hintText: hint,
        // focusColor: P,
        border: OutlineInputBorder(
         borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
      //  prefixIcon: Icon(prefix,color: AppColor.orangeColor),
//icon:Icons.email,
        suffixIcon: IconButton(
          onPressed: () {
            suffixPressed!();
          },
          icon: Icon(suffix,color: Colors.black,),
        ),
//icon:Icons.email,
      ),
    );

Widget defaultTextButton({
  required Function function,
  required String text,
  FontWeight? fontWeight,
  double? fontSize,
   Color? color,

}) =>
    TextButton(onPressed: () {
      function();
    }, child: Text( style: TextStyle(
      fontWeight: fontWeight,
        fontSize:fontSize ,
        color: color,

        // fontWeight: AppFontStyles.fontWeightSemiBold4,
        // fontSize: AppFontStyles.descriptionLoginFontSize,
        // color:AppColor.welcomeColor
    ),
        text),
    );

Widget defaultTextField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  bool isPassword = false,
  String? label,
  String? hint,
   IconData? prefix,
  IconData? suffix,
  Function()?suffixPressed,
   FormFieldValidator? validate,
  FormFieldSetter? onSaved,
  required double height,
  final BorderRadiusGeometry? borderRadius//

}) =>
    Box(
      height:height ,
      borderRadius: borderRadius,
      widget: TextFormField(
          controller: controller,
          keyboardType: type,
          obscureText: isPassword,
          onSaved: onSaved,
          validator: validate,
          cursorColor: AppColor.grayColorFont,
          cursorWidth: 0.5,

          decoration: InputDecoration(

              suffixIconConstraints: BoxConstraints(maxWidth: 24),

              contentPadding: EdgeInsetsDirectional.zero,

              border: OutlineInputBorder(
                borderSide: BorderSide.none,

              ) ,
              suffixIcon: IconButton(icon: Icon(suffix,color:Colors.white), onPressed:suffixPressed)
          )),

    );
