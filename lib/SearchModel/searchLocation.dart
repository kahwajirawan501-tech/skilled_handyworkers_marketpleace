import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/cubitLocation/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/cubitLocation/states.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profileScreen.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';
class Location extends StatelessWidget {
final  TextEditingController textController;
final Widget widget;
final VoidCallback? onPressed;

  const Location({Key? key, required this.textController, required this.widget, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<LocationCubit, LocationStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var location = state is LocationStatesSearchResultState
            ? state.searchResult
            : LocationCubit.get(context).location;

        return Scaffold(
          appBar: AppBar(
            surfaceTintColor:  AppColor.backgroundColor,

            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColor.arrowBackColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              TextButton(onPressed:() {
                Navigator.pop(context, textController.text);

              }, child:Text("332".tr,style:TextStyle(
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
            child: Padding(
              padding: const EdgeInsets.all(AppFontStyles.padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "331".tr,
                    style: TextStyle(
                      fontSize: AppFontStyles.aboutMe,
                      fontWeight: AppFontStyles.fontWeightSemiBold,
                      color: AppColor.bluColor,
                    ),
                  ),
                  const SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle),
                  Box(
                    borderRadius: BorderRadius.circular(AppFontStyles.borderRadiusTextField),
                    height: 50,
                    widget: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: TextFormField(
                        controller: textController,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          LocationCubit.get(context).searchLocation(value);
                        },
                        decoration: InputDecoration(

                          hintText: "329".tr,
                          hintStyle: TextStyle(
                            fontSize: AppFontStyles.descriptionLoginFontSize,
                            color: AppColor.grayColorFont,

                          ),
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              clearTextField(textController);
                              LocationCubit.get(context).searchLocation('');
                            },
                            child: const Icon(Icons.clear,size: 15,),
                          ),
                        ),
                        cursorColor: AppColor.orangeColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle),
                  Expanded(
                    child:ConditionalBuilder(
                      condition:state is !LocationLoadingStatesStateStates ,
                      builder: (context) => location.isEmpty?
                       Center(
                        child:
                        Text(
                          '330'.tr,
                          style:
                          TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ): ListView.separated(
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            textController.text = location[index]['name'];
                            LocationCubit.get(context).searchLocation(location[index]['name']);
                          },
                          child: Text(
                            location[index]['name'].toString(),
                            style: TextStyle(
                              fontSize: AppFontStyles.descriptionLoginFontSize,
                              color: AppColor.fontColorDescription,
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                        const SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle),
                        itemCount: location.length,
                      ),
                      fallback: (context) => Center(child: CircularProgressIndicator(color: AppColor.orangeColor,)),

                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

void clearTextField(TextEditingController controller) {
  controller.clear();
}
