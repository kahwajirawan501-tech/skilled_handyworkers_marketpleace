import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/DashboardLocation/AddRegin.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/cubit/state.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';

import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';
class LocationDashboard extends StatelessWidget {


  const LocationDashboard({Key? key
    }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController textController =TextEditingController();
    return BlocConsumer<DashBoardCubit, DashBoardStates>(
      listener: (context, state) {
        if(state is DeletedLocationSucssessfullStateStates){
          showToast(text: "Deleted Successful", state: ToastStates.SUCCESS);
          DashBoardCubit.get(context).getLocation();
        }
        if(state is DeletedLocationErrorStateStates){
          showToast(text: "Deleted not Successful", state: ToastStates.SUCCESS);

        }
      },
      builder: (context, state) {
        var location = state is LocationStatesSearchResultState
            ? state.searchResult
            : DashBoardCubit.get(context).location;

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

                  navigateTo(widget: AddLocation(),context: context);
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
            child: ConditionalBuilder(
              condition: state is !DeletedLocationLoadStateStates,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(AppFontStyles.padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Location",
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
                            DashBoardCubit.get(context).searchLocation(value);
                          },
                          decoration: InputDecoration(

                            hintText: "Search location",
                            hintStyle: TextStyle(
                              fontSize: AppFontStyles.descriptionLoginFontSize,
                              color: AppColor.grayColorFont,

                            ),
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                clearTextField(textController);
                                DashBoardCubit.get(context).searchLocation('');
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
                        const Center(
                          child:
                          Text(
                            'There is no area with this name',
                            style:
                            TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ): ListView.separated(
                          itemBuilder: (context, index) =>
                              GestureDetector(
                                onTap: () {
                                  textController.text = location[index]['name'];
                                  DashBoardCubit.get(context).searchLocation(location[index]['name']);
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      location[index]['name'].toString(),
                                      style: TextStyle(
                                        fontSize: AppFontStyles.descriptionLoginFontSize,
                                        color: AppColor.fontColorDescription,
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                        padding: EdgeInsets.zero,

                                        onPressed: (){
                                          DashBoardCubit.get(context).deleteLocation(location[index]['name'].toString());
                                        }, icon: Icon(Icons.delete,color: AppColor.orangeColor,size: 16,))
                                  ],
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
              fallback: (context) => Center(child: CircularProgressIndicator(color: AppColor.orangeColor,)),

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
