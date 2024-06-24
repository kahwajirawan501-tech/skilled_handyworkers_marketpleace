import 'package:flutter/material.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/BottonNavigationBar.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/searchLocation.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

import '../SearchModel/searchService.dart';

class AddOpenQuestion extends StatefulWidget {
  const AddOpenQuestion({Key? key}) : super(key: key);

  @override
  State<AddOpenQuestion> createState() => _AddOpenQuestionState();
}

class _AddOpenQuestionState extends State<AddOpenQuestion> {
  final TextEditingController _textControllerService = TextEditingController();
  final TextEditingController _textControllerLocation = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor:  AppColor.backgroundColor,

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.arrowBackColor,
          ),
          onPressed: () {
            navigateAndFinish(widget:BottomNavigationScreen(),context: context);
          },
        ),
        actions: [
          TextButton(onPressed:() {

          }, child:Text("post",style:TextStyle(
              fontSize: AppFontStyles.descriptionLoginFontSize,
              fontWeight: AppFontStyles.fontWeightBold,
              color: AppColor.bottomNavigationBar
          ) ,))
        ],
        elevation: 0.0,
        backgroundColor: AppColor.backgroundColor,
      ),
      body: Container(
        color: AppColor.backgroundColor,
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(AppFontStyles.padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Post",
                  style: TextStyle(
                    fontSize: AppFontStyles.aboutMe,
                    fontWeight: AppFontStyles.fontWeightSemiBold,
                    color: AppColor.bluColor,
                  ),
                ),
                const SizedBox(
                  height: AppFontStyles.sizeBetweenTitleAndSubTitle,
                ),
                ListTile(
                  leading: ClipOval(
                    child: Image.asset(
                      "assets/images/Mask group.png",
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  title:  Text(
                    "Orlando Diggs",
                    style: TextStyle(
                      fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                      color: AppColor.bluColor,
                      fontWeight: AppFontStyles.fontWeightBold,
                    ),
                  ),
                  subtitle:    Text(
                    " 21 minutes ago",
                    style: TextStyle(
                      fontSize: AppFontStyles.descriptionLoginFontSize,
                      color: AppColor.fontColorDescription,
                      fontWeight: AppFontStyles.fontWeightMedium,
                    ),
                  ),
                ),
                const SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle),
                Text(
                  " Service Type",
                  style: TextStyle(
                    fontWeight: AppFontStyles.fontWeightSemiBold,
                    fontSize: AppFontStyles.descriptionLoginFontSize,
                    color: AppColor.bluColor,
                  ),
                ),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),
                Box(
                  widget: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Service(
                              textController: _textControllerService,
                              title: "Add Service",
                              titleSearch: "Search",
                              widget: const AddOpenQuestion(),
                            ),
                          ),
                        );
                        if (result != null && result is String) {
                          setState(() {
                            _textControllerService.text = result;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding, vertical: 8),
                        child: Text(
                          _textControllerService.text.isEmpty ? "Select service" : _textControllerService.text,
                          style: TextStyle(
                            color: AppColor.grayColorFont,
                            fontSize: AppFontStyles.descriptionLoginFontSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                  height: 40,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),
                Text(
                  " Location",
                  style: TextStyle(
                    fontWeight: AppFontStyles.fontWeightSemiBold,
                    fontSize: AppFontStyles.descriptionLoginFontSize,
                    color: AppColor.bluColor,
                  ),
                ),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),
                Box(
                  widget: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Location(
                              textController: _textControllerLocation,
                              widget: const AddOpenQuestion(),
                            ),
                          ),
                        );
                        if (result != null && result is String) {
                          setState(() {
                            _textControllerLocation.text = result;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding, vertical: 8),
                        child: Text(
                          _textControllerLocation.text.isEmpty ? "Select location" : _textControllerLocation.text,
                          style: TextStyle(
                            color: AppColor.grayColorFont,
                            fontSize: AppFontStyles.descriptionLoginFontSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                  height: 40,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),
                Text(
                  " Add Question ",
                  style: TextStyle(
                    fontWeight: AppFontStyles.fontWeightSemiBold,
                    fontSize: AppFontStyles.descriptionLoginFontSize,
                    color: AppColor.bluColor,
                  ),
                ),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),

                Box(
                  borderRadius: BorderRadius.circular(AppFontStyles.borderRadius),
                  height: 232,
                  widget:Padding(

                    padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding),
                    child: TextFormField(

                      maxLines: 30, // حدد الحد الأقصى لعدد الأسطر
                      decoration:  InputDecoration(

                        hintText:'add your question ...',
                        hintStyle: TextStyle(

                            color: AppColor.grayColorFont,
                            fontSize: AppFontStyles.descriptionLoginFontSize,
                        ),
                        border: InputBorder.none,

                        // هنا يمكنك تحديد نص التلميح
                      ),
                      cursorColor: AppColor.grayColorFont,
                      cursorHeight:24,
                    ),

                  ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
