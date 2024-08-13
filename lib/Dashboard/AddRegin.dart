import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/cubit/state.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Setting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Setting/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class AddLocation extends StatelessWidget {
  AddLocation({Key? key}) : super(key: key);
  var reginController=TextEditingController();


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<DashBoardCubit,DashBoardStates>(
      listener:  (context, state) {
        if(state is ADDLocationSucssessfullStateStates){
          Navigator.pop(context);
          DashBoardCubit.get(context).getLocation();
        }
        if(state is ChangeErrorPassWord){
          showToast(text:"error", state: ToastStates.EROOR);
        }
      },
      builder: (context, state) {
        return  Scaffold(
          appBar: AppBar(
            surfaceTintColor:  AppColor.backgroundColor,

            leading:IconButton(
              icon:Icon( Icons.arrow_back,color: AppColor.arrowBackColor,),
              onPressed: () {
                Navigator.pop(context);
                },

            ),
            elevation: 0.0,
            backgroundColor: AppColor.backgroundColor,
          ),
          body:Stack(

            children: [
              Container(
                color:AppColor.backgroundColor ,
                height: double.infinity,
                width: double.infinity,
                child:  ConditionalBuilder(
                  condition: state is !ADDLocationLoadStateStates,
                  builder: (context) => SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(AppFontStyles.padding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Add Region",style: TextStyle(
                              fontSize:AppFontStyles.aboutMe,
                              fontWeight:   AppFontStyles.fontWeightSemiBold,
                              color: AppColor.bluColor
                          ),),
                          const SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle,),
                          Text("region",style: TextStyle(
                              fontWeight:AppFontStyles.fontWeightBold ,
                              fontSize: AppFontStyles.descriptionLoginFontSize,
                              color: AppColor.navyBlueColor
                          ),),
                          SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle,),
                          Box(
                            borderRadius: BorderRadius.circular(AppFontStyles.borderRadiusTextField),
                            height: 40,
                            widget:Padding(
                                padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding),
                                child: defaultTextField(
                                  controller: reginController,
                                  type:TextInputType.name,
                                  suffix:SettingCubit.get(context).oldSuffix,
                                  validate:(value){
                                    if (value!.isEmpty) {
                                      return "Your password must not be empty";
                                    }
                                    return null;
                                  },
                                  height: 50,
                                  borderRadius:BorderRadius.circular(AppFontStyles.borderRadiusTextField) ,
                                )

                            ),),
                          SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle,),


                        ],

                      ),
                    ),
                  ),
                  fallback: (context) => Center(child: CircularProgressIndicator(color: AppColor.orangeColor,),),

                ),

              ),

              Positioned(
                top: 600,
                left: MediaQuery.of(context).size.width / 2 - 106.5, // محور الأفقي (العرض) لتوسيط العنصر
                child: button(
                    colorBackground: AppColor.navyBlueColor,
                    onPressed:(){
                   if(reginController.text.isNotEmpty){
                     DashBoardCubit.get(context).addLocation(reginController.text);
                   }
                   else{
                     showToast(text: "Pleas enter the region", state: ToastStates.SUCCESS);
                   }
                    },
                    text:"Add",
                    height: 50,
                    width: 213,
                    fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                    fontWeight: AppFontStyles.fontWeightBold,
                    color:Colors.white),
              ),
            ],
          ) ,
        );
      },
    );
  }
}
