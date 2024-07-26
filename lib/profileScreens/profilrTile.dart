import 'package:flutter/material.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class profilrTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTap;
 final Widget widget;
 final Widget line;
 final Widget text;
  final String addOrEdit;
 final bool trueOrFalse;
  const profilrTile({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.onTap,  required this.widget, required this.line, required this.text,   required this.trueOrFalse,required this.addOrEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppFontStyles.padding,right: AppFontStyles.padding,bottom:AppFontStyles.sizeBetweenBoxAndSubTitle),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppFontStyles.borderRadius),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(imagePath),
                  SizedBox(width: 12),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                      fontWeight: AppFontStyles.fontWeightBold,
                      color: AppColor.bluColor,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: onTap,
                    child: Image.asset(addOrEdit),
                  ),
                   widget,

                ],
              ),
             Visibility(
               visible: trueOrFalse,
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 12),
                 child: line,
               ),
             ),
              Visibility(
                visible: trueOrFalse,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: text,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}