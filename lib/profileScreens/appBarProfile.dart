import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/imageView.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class AppBarProfile extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String email;
  final String pathImage;
  final String textButton;
  final bool visibility;
  final GestureTapCallback? onTapEditorChange;
  final double left;
  final double top;
  final GestureTapCallback? onTapSetting;
  final GestureTapCallback? onTapShared;
  final bool visibilitySetting;
  final bool arrBackVisibility;
  final GestureTapCallback? onTabArrBack;

  const AppBarProfile({
    Key? key,
    required this.name,
    required this.email,
    required this.pathImage,
    this.onTapSetting,
    this.onTapShared,
    required this.textButton,
    required this.visibility,
    this.onTapEditorChange,
    required this.left,
    required this.top,
    required this.visibilitySetting,
    required this.arrBackVisibility,
    this.onTabArrBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: SizedBox(),
      flexibleSpace: Container(
        height: MediaQuery.of(context).size.height * (220 / 100),
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(35),
            bottomLeft: Radius.circular(35),
          ),
          image: DecorationImage(
            image: AssetImage('assets/images/Background (1).png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Directionality(
          textDirection: Directionality.of(context), // يحدد اتجاه النص بناءً على اللغة الحالية
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: visibilitySetting,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 20, top: 43,start: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,

                    children: [
                      GestureDetector(
                          onTap: onTapShared,
                          child: Image.asset("assets/images/Icon Shared.png")),
                      SizedBox(width: 15),
                      GestureDetector(
                          onTap: onTapSetting,
                          child: Image.asset("assets/images/Icon Setting.png")),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: arrBackVisibility,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 20, top: 43,start: 20),
                  child: GestureDetector(
                    onTap: onTabArrBack,
                    child: Icon("347".tr=="E"?CupertinoIcons.arrow_left:CupertinoIcons.arrow_turn_up_right,color: Colors.white,),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 28.0, bottom: 7),
                    child: GestureDetector(
                      onTap: () {
                        if (imageNetwork != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageScreen(
                                imageUrl: api + imageNetwork!,
                              ),
                            ),
                          );
                        } else if (imageCope != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageScreen(
                                imageUrl: imageCope!,
                              ),
                            ),
                          );
                        } else if (imageFiles != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageScreen(
                                imageUrl: imageFiles!.path,
                              ),
                            ),
                          );
                        }
                      },
                      child: ClipOval(
                        child: imageFiles != null
                            ? Image(
                          image: FileImage(imageFiles as File),
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        )
                            : (imageNetwork!.isEmpty
                            ? Image.asset(
                          pathImage,
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        )
                            : Image.network(
                          api + pathImage,
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 29.0,end: 29),
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                        color: Colors.white,
                        fontWeight: AppFontStyles.fontWeightMedium,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 28.0,end: 28.0, ),
                    child: Text(
                      email,
                      style: const TextStyle(
                        fontSize: AppFontStyles.descriptionLoginFontSize,
                        color: Colors.white,
                        fontWeight: AppFontStyles.fontWeightMedium,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: left, top: top, ),
                child: GestureDetector(
                  onTap: onTapEditorChange,
                  child: Container(
                    constraints:
                    const BoxConstraints(
                        maxWidth: 150,
                        minWidth: 100),
                    //width: 150,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            textButton,
                            style: TextStyle(
                              fontSize: AppFontStyles.descriptionLoginFontSize,
                              color: Colors.white,
                              fontWeight: AppFontStyles.fontWeightMedium,
                            ),
                          ),
                          Visibility(
                            visible: visibility,
                            child: Image.asset(
                              "assets/images/Edit1.png",
                              height: 20,
                              width: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(220);
}
