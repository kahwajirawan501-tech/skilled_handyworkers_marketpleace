import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:skilled_handyworkers_marketpleace/Chat_Messages/Message.dart';
import 'package:skilled_handyworkers_marketpleace/Chat_Messages/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/InformationCustomerOne/seeMore.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/ListOfPostForUser.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/ListOpenQuestionForUser.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/informationCustomer.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/imageView.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/profilrTile.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class Information extends StatefulWidget
{
  final String idCustomer;
  const Information({Key? key, required this.idCustomer}) : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {

  bool clickPosting=true;
  bool clickOpenQuestion=false;
  List<Map<String, dynamic>> post = [];
  List<Map<String, dynamic>> openQuestion = [];




  @override
  void initState() {
    super.initState();
    CubitYourPost.get(context).getProfileInformationCustomer(widget.idCustomer);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor:  AppColor.backgroundColor,
        actions: [
          TextButton(onPressed:() {
            navigateTo(context: context,widget: SeeMore(
                nameCustomer: CubitYourPost.get(context).information['fullName']??"",
                aboutMyCustomer: CubitYourPost.get(context).information['aboutMe']??"",
                phoneCustomer: CubitYourPost.get(context).information['phoneNumber']??"",
                genderCustomer: CubitYourPost.get(context).information['gender']??"",
                locationCustomer: CubitYourPost.get(context).information['location']??"",
                skillCustomer: CubitYourPost.get(context).information['skills']??"",
                jobTittleCustomer: CubitYourPost.get(context).information['jobTitle']??"",
                jobDescriptionCustomer: CubitYourPost.get(context).information['jobDescription']??"",
                educationCustomer: CubitYourPost.get(context).information['institutionName']??"",
                educationDescriptionCustomer: CubitYourPost.get(context).information['institutionDescription']??""));

          }, child:Text("102".tr,style:TextStyle(
              fontSize: AppFontStyles.descriptionLoginFontSize,
              fontWeight: AppFontStyles.fontWeightBold,
              color: AppColor.bottomNavigationBar
          ) ,))

        ],
        elevation: 0.0,
        backgroundColor: AppColor.backgroundColor,
      ),
      body: BlocConsumer<CubitYourPost,YourPostStates>(
        listener: (context, state) {
          if(state is CustomerPostPostSucssessfullStateStates){
            setState(() {
              post = CubitYourPost.get(context).postCustomer;

            });
          }
          if(state is CustomerOpenQuestionPostSucssessfullStateStates){
            setState(() {
              openQuestion = CubitYourPost.get(context).openQuestionCustomer;
            });

          }
if(state is GetInformationSucssessfullStateStates){
  CubitYourPost.get(context).getPostCustomer(widget.idCustomer);

}

        },
        builder: (context, state) {
          return Container(
            color: AppColor.backgroundColor,
            width: double.infinity,
            height:double.infinity ,
            child: ConditionalBuilder(
              condition:state is !GetInformationStatesLoadingStateStates ,
              builder: (context) => (state is GetInformationErrorStateStates)? Center(
                child:  GestureDetector(
                    onTap: () {
                      CubitYourPost.get(context).getProfileInformationCustomer(widget.idCustomer);
                    },
                    child: Icon(Icons.refresh_outlined,color:AppColor.orangeColor,size: 20,)),
              ) :Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        children: [
                          Container(width: double.infinity,height: 50,color: AppColor.backgroundColor,),
                          Container(
                            padding: EdgeInsets.zero,
                            width: double.infinity,
                            child: Image.asset(
                              'assets/images/Group 48.png',
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top:0, // Adjust this value to move the circle image vertically
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (CubitYourPost.get(context).information['profileImage'].isNotEmpty) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ImageScreen(
                                        imageUrl: api + CubitYourPost.get(context).information['profileImage'],
                                      ),
                                    ),
                                  );
                                } else if (imageCope! .isNotEmpty) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ImageScreen(
                                        imageUrl: imageCope!,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: ClipOval(
                                child:(CubitYourPost.get(context).information['profileImage']!=null&&CubitYourPost.get(context).information['profileImage'].isNotEmpty)?Image.network(api+CubitYourPost.get(context).information['profileImage'], fit: BoxFit.cover,
                                  height: 90,
                                  width: 90,): Image.asset(
                                  imageCope!,
                                  fit: BoxFit.cover,
                                  height: 90,
                                  width: 90,
                                ),
                              ),
                            ),
                            SizedBox(height: AppFontStyles.aboutMe,),
                            Text(
                              CubitYourPost.get(context).information['fullName'].isEmpty?"":CubitYourPost.get(context).information['fullName'],
                              style: TextStyle(
                                fontSize: AppFontStyles.aboutMe,
                                color: AppColor.fontColor,
                                fontWeight: AppFontStyles.fontWeightBold,
                              ),
                            ),
                            SizedBox(height: AppFontStyles.aboutMe,),

                          ],
                        ),
                      ),
                      Positioned(
                        bottom:0,

                        right: 0,// Adjust this value to move the circle image vertically
                        child:Padding(
                          padding: const EdgeInsets.all(AppFontStyles.padding),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            IconButton(
                                onPressed: (){

                                  navigateTo(context: context,widget:
                                  MessagePerson(receiverId:CubitYourPost.get(context).information['_id'],
                                    fullName:  CubitYourPost.get(context).information['fullName'],
                                     pathImage: CubitYourPost.get(context).information['profileImage']??"",

                                  ));
                                }, icon: Icon(CupertinoIcons.bubble_left))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),


                  Padding(
                    padding: const EdgeInsets.only(top: 16,bottom: 8),
                    child: Row(
                      children: [
                        SizedBox(width: AppFontStyles.aboutMe,),
                        Expanded(

                          child: Box(widget:GestureDetector(
                            onTap: () {
                              setState(() {
                                clickPosting=!clickPosting;
                                if(clickPosting){
                                  clickOpenQuestion=false;
                                  post.clear();
                                }
                                CubitYourPost.get(context).getPostCustomer(widget.idCustomer);


                              });

                            },
                            child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                  color: clickPosting?AppColor.orangeColor:Colors.white,
                                ),
                                alignment: Alignment.center,
                                child: Text("103".tr,style: TextStyle(color:clickPosting?Colors.white:AppColor.bluColor ),)
                            ),
                          ), height: 40, borderRadius: BorderRadius.circular(10)),
                        ),
                        SizedBox(width: AppFontStyles.aboutMe,),
                        Expanded(
                          child: Box(widget:GestureDetector(
                            onTap: () {


                              setState(() {
                                clickOpenQuestion=!clickOpenQuestion;
                                if(clickOpenQuestion){
                                  clickPosting=false;
                                  openQuestion.clear();

                                }
                                CubitYourPost.get(context).getOpenQuestionCustomer(widget.idCustomer);


                              });


                            },
                            child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                  color:clickOpenQuestion?AppColor.orangeColor:Colors.white,
                                ),
                                child: Text("104".tr,style: TextStyle(color:clickOpenQuestion?Colors.white:AppColor.bluColor ))
                            ),
                          ), height: 40, borderRadius: BorderRadius.circular(10)),
                        ),

                      ],
                    ),
                  ),


                  if (clickPosting)
                    Expanded(
                      child: ConditionalBuilder(
                        condition: state is! CustomerPostPostLoadStateStates ,
                        builder: (context) =>
                        (state is CustomerPostPostErrorStateStates)?
                        Center(
                          child:  GestureDetector(
                              onTap: () {
                                CubitYourPost.get(context).getPost();
                              },
                              child: Icon(Icons.refresh_outlined,color:AppColor.orangeColor,size: 20,)),
                        ):ListOfPostingUser(
                          post: post,

                        ),
                        fallback: (context) =>

                        Center(
                          child: CircularProgressIndicator(
                            color: AppColor.orangeColor,
                          ),
                        ),
                      ),
                    ),
                  if (clickOpenQuestion)
                    Expanded(
                      child: ConditionalBuilder(
                        condition:state is !CustomerOpenQuestionPostLoadStateStates ,
                        builder: (context) =>(state is CustomerOpenQuestionPostErrorStateStates)? Center(
                          child:  GestureDetector(
                              onTap: () {
                                CubitYourPost.get(context).getPost();
                              },
                              child: Icon(Icons.refresh_outlined,color:AppColor.orangeColor,size: 20,)),
                        ):ListOfOpenQuestionUser(
                          openQuestionPost: openQuestion,

                        ),
                        fallback: (context) =>

                        Center(
                          child: CircularProgressIndicator(
                            color: AppColor.orangeColor,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              fallback:(context) =>

              Center(
                child: CircularProgressIndicator(
                  color: AppColor.orangeColor,
                ),
              ),


            ),
          );
        },
      ),
    );
  }
}
