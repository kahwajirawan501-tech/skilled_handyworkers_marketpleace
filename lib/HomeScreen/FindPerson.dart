import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/InformationCustomerOne/information.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class FindPerson extends StatefulWidget {
  const FindPerson({Key? key}) : super(key: key);

  @override
  State<FindPerson> createState() => _FindpersonState();
}

class _FindpersonState extends State<FindPerson> {
  TextEditingController textEditingController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var users=HomeCubit.get(context).users;
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {
        if(state is GetUserSearchSucssessfullStateStates){
          users=HomeCubit.get(context).users;
        }
      },
      builder: (context, state) {

        return Scaffold(
          appBar: AppBar(
            surfaceTintColor:  AppColor.backgroundColor,
            elevation: 0.0,
            backgroundColor: AppColor.backgroundColor,
            centerTitle: true,
            title: Text("354".tr,style: TextStyle(
                color: Colors.black,fontSize: AppFontStyles.borderRadius,
                fontWeight: AppFontStyles.fontWeightBold
            ),),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(90.0), // تعديل الارتفاع حسب الحاجة
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding),
                child: Box(height: 50,widget:TextFormField(
                  controller: textEditingController,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    HomeCubit.get(context).searchUser(value);
                  },
                  decoration: InputDecoration(
                    hintText: "69".tr,
                    hintStyle: TextStyle(
                      fontSize: AppFontStyles.descriptionLoginFontSize,
                      color: AppColor.grayColorFont,
                    ),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        clearTextField(textEditingController);
                        HomeCubit.get(context).searchUser('');

                      },
                      child: Icon(Icons.clear,size: 15,),
                    ),
                  ),
                  cursorColor: AppColor.orangeColor,
                ),

                  borderRadius: BorderRadius.circular(15),),
              ),
            ),


          ),
          body: Container(
            color: AppColor.backgroundColor,
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left:8,right: 8,top: 34),
              child: ConditionalBuilder(
                condition:state is !GetUserSearchStatesLoadingStateStates,
                builder: (context) => ConditionalBuilder(
                  builder:(context) =>
                      ListView.separated(
                          physics:BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>GestureDetector(
                              onTap: () {
                                if( users[index]['_id'] != id) {
                                  navigateTo(context: context,widget: Information(idCustomer: users[index]['_id']));
                                }
                              },
                              child: ListUser(context,users[index])) ,
                          separatorBuilder: (context, index) =>SizedBox(height:AppFontStyles.aboutMe) ,
                          itemCount: users.length ),
                  condition:users.isNotEmpty,
                  fallback: (context) =>  Center(
                    child:Text(
                      '355'.tr,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),

                  ),

                ),
                fallback:(context) => Center(child: CircularProgressIndicator( color: AppColor.orangeColor,)),

              ),
            ),
          ),
        );
      },

    );
  }
}
Widget ListUser(context,var user)=>Column(
  children: [
    ListTile(
      leading: ClipOval(
        child: (user['profileImage']!=null&&user['profileImage']!.isNotEmpty)?Image.network(api+user['profileImage'],fit: BoxFit.cover,
          height: 70,
          width: 60,):
           Image.asset(
          imageCope!,
          fit: BoxFit.cover,
          height: 70,
          width: 60,
        ),
      ),
      title:  Text(
        user['fullName'].isNotEmpty ?user['fullName']:"",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: AppFontStyles.descriptionSplashScreenFontSize,
          color: AppColor.bluColor,
          fontWeight: AppFontStyles.fontWeightBold,
        ),
      ),
      subtitle:    Text(
        user['skills'] ?? "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(

          fontSize: AppFontStyles.descriptionLoginFontSize,
          color: AppColor.fontColorDescription,
          fontWeight: AppFontStyles.fontWeightMedium,
        ),
      ),



    ),

  ],
);

void clearTextField(TextEditingController controller) {
  controller.clear();
}