
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/cubitService/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/cubitService/states.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profileScreen.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';
class Service extends StatelessWidget {
  final TextEditingController textController;
  final String title;
  final String titleSearch;
  final Widget widget;
  //final VoidCallback? onPressed;

  const Service({Key? key, required this.textController, required this.title, required this.titleSearch, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ServiceCubit, ServiceStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var services = state is ServiceStatesSearchResultState
            ? state.searchResult
            : ServiceCubit.get(context).service;

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

        }, child:Text("Done",style:TextStyle(
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
                    title,
                    style: TextStyle(
                      fontSize: AppFontStyles.aboutMe,
                      fontWeight: AppFontStyles.fontWeightSemiBold,
                      color: AppColor.bluColor,
                    ),
                  ),
                  SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle),
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
                          ServiceCubit.get(context).searchService(value);
                        },
                        decoration: InputDecoration(
                          hintText: titleSearch,
                          hintStyle: TextStyle(
                            fontSize: AppFontStyles.descriptionLoginFontSize,
                            color: AppColor.grayColorFont,
                          ),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              clearTextField(textController);
                              ServiceCubit.get(context).searchService('');
                            },
                            child: Icon(Icons.clear,size: 15,),
                          ),
                        ),
                        cursorColor: AppColor.orangeColor,
                      ),
                    ),
                  ),
                  SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle),
                  Expanded(
                    child:ConditionalBuilder(
                      condition:state is !ServiceLoadingStateStates ,
                      builder: (context) =>  services.isEmpty?  const Center(
                        child:
                        Text(
                          'There is no service with this name',
                          style:
                          TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ): ListView.separated(
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            textController.text = services[index]['name'];
                            ServiceCubit.get(context).searchService(services[index]['name']);
                          },
                          child: Text(
                            services[index]['name'].toString(),
                            style: TextStyle(
                              fontSize: AppFontStyles.descriptionLoginFontSize,
                              color: AppColor.fontColorDescription,
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle),
                        itemCount: services.length,
                      ),
                      fallback: (context) => Center( child: CircularProgressIndicator(color: AppColor.orangeColor,),),
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
