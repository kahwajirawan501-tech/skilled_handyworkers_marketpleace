
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/DashbordServices/AddService.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/cubit/state.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';
class ServiceDashboard extends StatelessWidget {

  const ServiceDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textController=TextEditingController();
    return BlocConsumer<DashBoardCubit, DashBoardStates>(
      listener: (context, state) {
        if(state is DeletedServiceSucssessfullStateStates){
          showToast(text: "Deleted Successful", state: ToastStates.SUCCESS);
          DashBoardCubit.get(context).getService();
        }
        if(state is DeletedServiceErrorStateStates){
          showToast(text: "Deleted not Successful", state: ToastStates.SUCCESS);

        }
      },
      builder: (context, state) {
        var services = state is ServiceStatesSearchResultState
            ? state.searchResult
            : DashBoardCubit.get(context).service;

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
                navigateTo(widget: AddService(),context: context);
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
              condition:  state is !DeletedServiceLoadStateStates,
              builder: (context) =>  Padding(
                padding: const EdgeInsets.all(AppFontStyles.padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Service",
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
                            DashBoardCubit.get(context).searchService(value);
                          },
                          decoration: InputDecoration(
                            hintText: "Search service",
                            hintStyle: TextStyle(
                              fontSize: AppFontStyles.descriptionLoginFontSize,
                              color: AppColor.grayColorFont,
                            ),
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                clearTextField(textController);
                                DashBoardCubit.get(context).searchService('');
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
                              DashBoardCubit.get(context).searchService(services[index]['name']);
                            },
                            child: Row(
                              children: [
                                Text(
                                  services[index]['name'].toString(),
                                  style: TextStyle(
                                    fontSize: AppFontStyles.descriptionLoginFontSize,
                                    color: AppColor.fontColorDescription,
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                    padding: EdgeInsets.zero,

                                    onPressed: (){
                                      DashBoardCubit.get(context).deletedService(services[index]['name'].toString());
                                    }, icon: Icon(Icons.delete,color: AppColor.orangeColor,size: 16,))
                              ],
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
