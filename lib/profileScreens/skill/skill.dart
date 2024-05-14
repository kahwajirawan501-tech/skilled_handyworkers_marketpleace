import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profileScreen.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/skill/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/skill/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class Skill extends StatelessWidget {
  const Skill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = TextEditingController();

    return BlocConsumer<SkillCubit,SkillStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return  Scaffold(
          appBar: AppBar(
            leading:IconButton(
              icon:Icon( Icons.arrow_back,color: AppColor.arrowBackColor,),
              onPressed: () {
                navigateAndFinish(widget:const ProfileScreen() ,context: context);
              },

            ),
            elevation: 0.0,
            backgroundColor: AppColor.backgroundColor,
          ),
          body:Container(
            color:AppColor.backgroundColor ,
            height: double.infinity,
            width: double.infinity,
            child:  Padding(
              padding: const EdgeInsets.all(AppFontStyles.padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Add Skill",style: TextStyle(
                      fontSize:AppFontStyles.aboutMe,
                      fontWeight:   AppFontStyles.fontWeightSemiBold,
                      color: AppColor.bluColor
                  ),),
                  SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle,),

                  Box(
                    borderRadius: BorderRadius.circular(AppFontStyles.borderRadiusTextField),
                    height: 40,
                    widget:Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: _textController,

                        maxLines: 1,
                        keyboardType: TextInputType.text, // هنا تحديد نوع الإدخال ليكون رقمياً

                        decoration: InputDecoration(
                         hintText: "Search skills",
                          hintStyle:TextStyle(
                            fontSize: AppFontStyles.descriptionLoginFontSize,
                            color:AppColor.grayColorFont
                          ),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search), // أيقونة البحث
                          suffixIcon: GestureDetector(
                            onTap: () {
                              clearTextField(_textController);
                            },
                            child: Icon(Icons.clear), // أيقونة حذف النص
                          ),
                        ),
                        cursorColor: AppColor.grayColorFont,
                      ),
                    ),),
                  SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle,),

                  Expanded(

                    child: ListView.separated(
                        itemBuilder: (context, index) =>
                            Text(
                              SkillCubit.get(context).skill[index].toString(),
                              style: TextStyle(
                                fontSize:AppFontStyles.descriptionLoginFontSize ,

                                color:AppColor.fontColorDescription
                              ),
                            ) ,
                        separatorBuilder: (context, index) =>SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle,) ,
                        itemCount: SkillCubit.get(context).skill.length),
                  ),



                ],

              ),
            ),
          ) ,
        );
      },

    );
  }
}
void clearTextField(TextEditingController controller) {
  controller.clear();
}
