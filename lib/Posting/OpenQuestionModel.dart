import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class OpenQuestionModel extends StatefulWidget {
  final GestureTapCallback? onTapImage;
  final String imagePath;//"assets/images/Mask group.png"
  final String name;//Orlando Diggs
  final String time;//21 minutes ago
  final VoidCallback? onPressedForCommit;
  final VoidCallback? onPressedForFavorit;
  final String numberOfCommit;
  final String openQuestion;
  final VoidCallback? onPressed;
  final bool deleteAndEdit;
  /////////////////////////////////////
  const OpenQuestionModel({Key? key, this.onTapImage, required this.imagePath, required this.name, required this.time, this.onPressedForCommit, this.onPressedForFavorit, required this.numberOfCommit, required this.openQuestion, this.onPressed, required this.deleteAndEdit}) : super(key: key);

  @override
  State<OpenQuestionModel> createState() => _OpenQuestionModelState();
}

class _OpenQuestionModelState extends State<OpenQuestionModel> {


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(AppFontStyles.aboutMe),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: GestureDetector(
                    onTap: widget.onTapImage,
                    child:ClipOval(
                      child: widget.imagePath != "assets/images/aboutmy.png"
                          ? Image.network(
                        "http://192.168.43.142:3000${widget.imagePath}",
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                      )
                          : Image.asset(
                        widget.imagePath,
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                  title: Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                      color: AppColor.bluColor,
                      fontWeight: AppFontStyles.fontWeightBold,
                    ),
                  ),
                  subtitle: Text(
                    widget.time,
                    style: TextStyle(
                      fontSize: AppFontStyles.descriptionLoginFontSize,
                      color: AppColor.fontColorDescription,
                      fontWeight: AppFontStyles.fontWeightMedium,
                    ),
                  ),
                  trailing:widget.deleteAndEdit?
                  IconButton(onPressed:widget.onPressed, icon: Icon(Icons.more_vert)):SizedBox(),

                ),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),

                Text(widget.openQuestion,
                  style: TextStyle(fontWeight:AppFontStyles.fontWeightSemiBold ),
                ),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: AppColor.comment,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
            child: Row(
              children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      icon:  Icon(Icons.favorite, color:Colors.red),
                      onPressed:widget.onPressedForFavorit,
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(CupertinoIcons.bubble_left),
                      onPressed:widget.onPressedForCommit,
                    ),
                    Text(
                      widget.numberOfCommit,
                      style: TextStyle(
                          fontSize: AppFontStyles.aboutMe,
                          color: AppColor.commentFont),
                    ),
                  ],
                ),
                const Spacer(),

              ],
            ),
          ),
        ],
      ),
    );
  }

}
