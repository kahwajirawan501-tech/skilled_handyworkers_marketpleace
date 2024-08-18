import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:skilled_handyworkers_marketpleace/Chat_Messages/NoMessage.dart';
import 'package:skilled_handyworkers_marketpleace/Chat_Messages/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Chat_Messages/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/Chat_Messages/Message.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {

  @override
  void initState() {
    super.initState();
  }
  TextEditingController textEditingController=TextEditingController();
  var users=[];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit,MessageStates>(
      listener: (context, state) {
        if(state is GetUserMessageSucssessfullStateStates){
          setState(() {
            users=state.users;
            print("userssssssssssssssssssssssss");
            print(users);
          });
        }
        else if(state is GetUserMessageSearchResultState){
          print("searchResult");

          users=state.searchResult;
          print(users);
        }
        else{
          print("else");

          users=ChatCubit.get(context).users;
          print(users);
        }
      },
      builder: (context, state) {



        return ConditionalBuilder(
          condition: state is !GetUserMessageLoadStateStates,
          builder: (context) => Scaffold(
            appBar: AppBar(
              surfaceTintColor:  AppColor.backgroundColor,
              elevation: 0.0,
              backgroundColor: AppColor.backgroundColor,
              centerTitle: true,
              title: Text("68".tr,style: TextStyle(
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
                      ChatCubit.get(context).searchUsers(value);
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
                          ChatCubit.get(context).searchUsers('');

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
                                textEditingController.text = users[index]['fullName'];
                                ChatCubit.get(context).searchUsers(users[index]['fullName']);
                                navigateTo(widget: MessagePerson(receiverId:users[index]['id'],
                                  fullName: users[index]['fullName'],
                                  pathImage: users[index]['profileImage']??"",
                                ),context: context);


                              },
                              child: ListChat(context,users[index])) ,
                          separatorBuilder: (context, index) =>SizedBox(height:AppFontStyles.aboutMe) ,
                          itemCount: users.length ),
                  condition:users.isNotEmpty,
                  fallback: (context) => const Center(
                    child:
                    NoMessage(),
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
                title: Text("68".tr,style: TextStyle(
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
                        ChatCubit.get(context).searchUsers(value);
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
                            ChatCubit.get(context).searchUsers('');

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
        child: (user['profileImage']!=null&&user['profileImage']!.isNotEmpty)?Image.network(api+user['profileImage'],fit: BoxFit.cover,
          height: 70,
          width: 60,):Image.asset(
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
        user['lastMessage'],
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(

          fontSize: AppFontStyles.descriptionLoginFontSize,
          color: AppColor.fontColorDescription,
          fontWeight: AppFontStyles.fontWeightMedium,
        ),
      ),

      trailing: Column(
        children: [
          Text(
            user['lastMessageTime'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: AppFontStyles.soSmallFontSize,
              color: AppColor.grayColorFont,
              fontWeight: AppFontStyles.fontWeightMedium,
            ),
          ),
          SizedBox(height:10 ,),
          Visibility(
            visible: user['unreadCount']!=0,
            child: Container(
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                color:AppColor.orangeColor, // لون الدائرة
                shape: BoxShape.circle, // يجعل الشكل دائرياً
              ),
              alignment: Alignment.center, // يجعل النص في مركز الدائرة
              child: Text(
                user['unreadCount'].toString(),
                style: TextStyle(
                  color: Colors.white, // لون الرقم
                  fontSize: 11.0, // حجم الرقم
                  fontWeight: FontWeight.bold, // نمط الخط
                ),
              ),),
          )
        ],
      ),

    ),

  ],
);
void clearTextField(TextEditingController controller) {
  controller.clear();
}