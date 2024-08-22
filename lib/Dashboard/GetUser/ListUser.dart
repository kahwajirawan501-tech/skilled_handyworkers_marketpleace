import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/cubit/state.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class ListUser extends StatefulWidget {
  const ListUser({Key? key}) : super(key: key);

  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {

  @override
  void initState() {
    super.initState();
    DashBoardCubit.get(context).getUsers();
  }
  TextEditingController textEditingController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashBoardCubit,DashBoardStates>(
      listener: (context, state) {
      if(state is DeletedUsersSucssessfullStateStatesSearch){
        DashBoardCubit.get(context).getUsers();
      }
      if(state is DeletedUsersErrorStateStatesSearch){
        showToast(text: "error", state: ToastStates.SUCCESS);
      }
      },
      builder: (context, state) {
        var users = state is GetUserMessageSearchResultState
            ? state.filteredUsers
            : DashBoardCubit.get(context).users;
        return ConditionalBuilder(
          condition: state is !GetUsersLoadStateStatesSearch,
          builder: (context) => Scaffold(
            appBar: AppBar(
              surfaceTintColor:  AppColor.backgroundColor,
              elevation: 0.0,
              backgroundColor: AppColor.backgroundColor,
              centerTitle: true,
              title: Text("Users",style: TextStyle(
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
                      DashBoardCubit.get(context).searchUsers(value);
                    },
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(
                        fontSize: AppFontStyles.descriptionLoginFontSize,
                        color: AppColor.grayColorFont,
                      ),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          clearTextField(textEditingController);
                          DashBoardCubit.get(context).searchUsers('');

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
                  builder:(context) =>
                      ListView.separated(
                          physics:BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>GestureDetector(
                              onTap: () {

                              },
                              child: ListChat(context,users[index])) ,
                          separatorBuilder: (context, index) =>SizedBox(height:AppFontStyles.aboutMe) ,
                          itemCount: users.length ),
                  condition:users.isNotEmpty,
                  fallback: (context) => const Center(
                    child:Text(
                      'Not Found User.',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),

                  ),

                ),
              ),
            ),
          ),
          fallback: (context) =>Scaffold(
              appBar: AppBar(
                surfaceTintColor:  AppColor.backgroundColor,
                elevation: 0.0,
                backgroundColor: AppColor.backgroundColor,
                centerTitle: true,
                title: Text("Messages",style: TextStyle(
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
                        DashBoardCubit.get(context).searchUsers(value);
                      },
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(
                          fontSize: AppFontStyles.descriptionLoginFontSize,
                          color: AppColor.grayColorFont,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            clearTextField(textEditingController);
                            DashBoardCubit.get(context).searchUsers('');

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
                  child: Center( child: CircularProgressIndicator(color: AppColor.orangeColor,),))),
        );
      },

    );
  }
}

Widget ListChat(context,var user)=>Column(
  children: [
    ListTile(
      leading: ClipOval(
        // child: user['profileImage']!.isNotEmpty?Image.network(api+user['profileImage'],fit: BoxFit.cover,
        //   height: 70,
        //   width: 60,):
   child:   Image.asset(
          imageCope!,
          fit: BoxFit.cover,
          height: 70,
          width: 60,
        ),
      ),
      title:  Text(
        (user['fullName']!=null&&user['fullName'].isNotEmpty) ?user['fullName']:"",
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

      trailing:
      Column(
        children: [
          Visibility(
            visible:user['role']!="admin"&&user['isBlocked']==true,
            child: GestureDetector(
              onTap: () {
            DashBoardCubit.get(context).blockUsers(user['_id'],false);
              },
                child: Icon(Icons.block,color: AppColor.orangeColor,size: 16,)),
          ),
          Visibility(
            visible:user['role']!="admin"&&user['isBlocked']==false,
            child: GestureDetector(
                onTap: () {
                  DashBoardCubit.get(context).blockUsers(user['_id'],true);
                },
                child: Icon(Icons.block,color:Colors.grey,size: 16,)),
          )
        ],
      ),

    ),

  ],
);
void clearTextField(TextEditingController controller) {
  controller.clear();
}