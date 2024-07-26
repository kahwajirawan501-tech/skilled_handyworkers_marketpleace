import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/AddPosting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/AddPosting/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/BottonNavigationBar.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/searchLocation.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

import '../SearchModel/searchService.dart';

class AddOpenQuestion extends StatefulWidget {
  const AddOpenQuestion({Key? key}) : super(key: key);

  @override
  State<AddOpenQuestion> createState() => _AddOpenQuestionState();
}

class _AddOpenQuestionState extends State<AddOpenQuestion> {
  final TextEditingController _textControllerService = TextEditingController();
  final TextEditingController _textControllerLocation = TextEditingController();
  final TextEditingController _textControllerDescription=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPostCubit,AddPostStates>(
      listener: (context, state) {
        if(state is AddOpenQuestionSucssessfullStateStates){
          showToast(text:"The post has been published successfully", state: ToastStates.EROOR);
          Navigator.pop(context);
          CubitYourPost.get(context).getOpenQuestion();
        }
        else if(state is AddOpenQuestionErrorStateStates){
          showToast(text:"The post hasn't been published successfully \n"+state.message, state: ToastStates.EROOR);

        }
      },
      builder: (context, state) {
        return  Scaffold(
          appBar: AppBar(
            surfaceTintColor:  AppColor.backgroundColor,

            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColor.arrowBackColor,
              ),
              onPressed: () {
                navigateAndFinish(widget:BottomNavigationScreen(),context: context);
              },
            ),
            actions: [
              TextButton(onPressed:() {
                if(_textControllerLocation.text.isEmpty
                    ||_textControllerService.text.isEmpty||_textControllerDescription.text.isEmpty
                ){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(

                      backgroundColor: AppColor.backgroundColor,
                      content: Center(child: Text('You must fill in the service field and the location field and the description file '
                        ,style: TextStyle(color: AppColor.grayColorFont),)),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
                else{
                  AddPostCubit.get(context).addOpenQuestion( _textControllerService.text,
                      _textControllerLocation.text, _textControllerDescription.text);
                }


              }, child:Text("post",style:TextStyle(
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(AppFontStyles.padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConditionalBuilder(
                      condition: state is !AddOpenQuestionLoadStateStates,
                      builder: (context) => const SizedBox(),
                      fallback:(context) => LinearProgressIndicator(color: AppColor.orangeColor,minHeight: 1.0,),),
                    SizedBox(height:AppFontStyles.aboutMe,),
                    Text(
                      "Add Post",
                      style: TextStyle(
                        fontSize: AppFontStyles.aboutMe,
                        fontWeight: AppFontStyles.fontWeightSemiBold,
                        color: AppColor.bluColor,
                      ),
                    ),
                    const SizedBox(
                      height: AppFontStyles.sizeBetweenTitleAndSubTitle,
                    ),
                    ListTile(
                      leading: ClipOval(
                        child: imageNetwork!=null?Image.network(api+imageNetwork!,fit: BoxFit.cover,
                          height: 50,
                          width: 50,):Image.asset(
                          imageCope!,
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        ),
                      ),
                      title:  Text(
                        name!=null?name!:"",
                        style: TextStyle(
                          fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                          color: AppColor.bluColor,
                          fontWeight: AppFontStyles.fontWeightBold,
                        ),
                      ),
                      subtitle:    Text(
                        locationConst!=null?locationConst!:"",
                        style: TextStyle(
                          fontSize: AppFontStyles.descriptionLoginFontSize,
                          color: AppColor.fontColorDescription,
                          fontWeight: AppFontStyles.fontWeightMedium,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle),
                    Text(
                      " Service Type",
                      style: TextStyle(
                        fontWeight: AppFontStyles.fontWeightSemiBold,
                        fontSize: AppFontStyles.descriptionLoginFontSize,
                        color: AppColor.bluColor,
                      ),
                    ),
                    const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),
                    Box(
                      widget: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: GestureDetector(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Service(
                                  textController: _textControllerService,
                                  title: "Add Service",
                                  titleSearch: "Search",
                                  widget: const AddOpenQuestion(),
                                ),
                              ),
                            );
                            if (result != null && result is String) {
                              setState(() {
                                _textControllerService.text = result;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding, vertical: 8),
                            child: Text(
                              _textControllerService.text.isEmpty ? "Select service" : _textControllerService.text,
                              style: TextStyle(
                                color: AppColor.grayColorFont,
                                fontSize: AppFontStyles.descriptionLoginFontSize,
                              ),
                            ),
                          ),
                        ),
                      ),
                      height: 40,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),
                    Text(
                      " Location",
                      style: TextStyle(
                        fontWeight: AppFontStyles.fontWeightSemiBold,
                        fontSize: AppFontStyles.descriptionLoginFontSize,
                        color: AppColor.bluColor,
                      ),
                    ),
                    const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),
                    Box(
                      widget: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: GestureDetector(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Location(
                                  textController: _textControllerLocation,
                                  widget: const AddOpenQuestion(),
                                ),
                              ),
                            );
                            if (result != null && result is String) {
                              setState(() {
                                _textControllerLocation.text = result;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding, vertical: 8),
                            child: Text(
                              _textControllerLocation.text.isEmpty ? "Select location" : _textControllerLocation.text,
                              style: TextStyle(
                                color: AppColor.grayColorFont,
                                fontSize: AppFontStyles.descriptionLoginFontSize,
                              ),
                            ),
                          ),
                        ),
                      ),
                      height: 40,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),
                    Text(
                      " Add Question ",
                      style: TextStyle(
                        fontWeight: AppFontStyles.fontWeightSemiBold,
                        fontSize: AppFontStyles.descriptionLoginFontSize,
                        color: AppColor.bluColor,
                      ),
                    ),
                    const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),

                    Box(
                      borderRadius: BorderRadius.circular(AppFontStyles.borderRadius),
                      height: 232,
                      widget:Padding(

                        padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding),
                        child: TextFormField(
                          controller: _textControllerDescription,
                          keyboardType: TextInputType.text,
                          maxLines: 30, // حدد الحد الأقصى لعدد الأسطر
                          decoration:  InputDecoration(

                            hintText:'add your question ...',
                            hintStyle: TextStyle(

                              color: AppColor.grayColorFont,
                              fontSize: AppFontStyles.descriptionLoginFontSize,
                            ),
                            border: InputBorder.none,

                            // هنا يمكنك تحديد نص التلميح
                          ),
                          cursorColor: AppColor.grayColorFont,
                          cursorHeight:24,
                        ),

                      ),),
                  ],
                ),
              ),
            ),
          ),
        );
      },

    );
  }
}
