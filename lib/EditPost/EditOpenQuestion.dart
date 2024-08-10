import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/AddPosting/addOpenQuestion.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/BottonNavigationBar.dart';
import 'package:skilled_handyworkers_marketpleace/EditPost/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/EditPost/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/searchLocation.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/searchService.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class EditOpenQuestion extends StatefulWidget {
  final String id;
  const EditOpenQuestion({Key? key, required this.id}) : super(key: key);

  @override
  State<EditOpenQuestion> createState() => _EditOpenQuestionState();
}

class _EditOpenQuestionState extends State<EditOpenQuestion> {
  final TextEditingController _textControllerDescription = TextEditingController();
  Map<String, dynamic> infomationPost = {};

  @override
  void initState() {
    super.initState();
    EditPostCubit.get(context).getInformationForPost(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditPostCubit, EditPostStates>(
      listener: (context, state) {
        if (state is GetInformationPostSucssessfullStateStates) {
          infomationPost = EditPostCubit.get(context).postInformation;
          _textControllerDescription.text = infomationPost['text'];

        }
        else if(state is GetInformationPostErrorStateStates){
          showToast(text:"Error!", state: ToastStates.EROOR);
      Navigator.pop(context);
        }
        if(state is EditOpenQuestionPostSucssessfullStateStates){
          showToast(text:"The post has been update successfully", state: ToastStates.SUCCESS);
          Navigator.pop(context);
          CubitYourPost.get(context).getOpenQuestion();
        }
        else if(state is EditOpenQuestionPostErrorStateStates){
          showToast(text:"The post hasn't been update successfully", state: ToastStates.EROOR);

        }

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: AppColor.backgroundColor,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColor.arrowBackColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
               EditPostCubit.get(context).editOpenQuestion(widget.id,_textControllerDescription.text);
                },
                child: Text(
                  "update",
                  style: TextStyle(
                    fontSize: AppFontStyles.descriptionLoginFontSize,
                    fontWeight: AppFontStyles.fontWeightBold,
                    color: AppColor.bottomNavigationBar,
                  ),
                ),
              ),
            ],
            elevation: 0.0,
            backgroundColor: AppColor.backgroundColor,
          ),
          body: Container(
            color: AppColor.backgroundColor,
            height: double.infinity,
            width: double.infinity,
            child: ConditionalBuilder(
              condition: state is! GetInformationPostLoadStateStates,
              builder: (context) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(AppFontStyles.padding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConditionalBuilder(
                        condition: state is !EditOpenQuestionPostLoadStateStates,
                        builder: (context) => const SizedBox(),
                        fallback:(context) => LinearProgressIndicator(color: AppColor.orangeColor,minHeight: 1.0,),),
                      SizedBox(height:AppFontStyles.aboutMe,),
                      Text(
                        "Edit Post",
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
                        child: imageNetwork!.isNotEmpty?Image.network(api+imageNetwork!,fit: BoxFit.cover,
                          height: 50,
                          width: 50,):Image.asset(
                          imageCope!,
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        ),
                      ),
                      title:  Text(
                        name!.isNotEmpty?name!:"",
                        style: TextStyle(
                          fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                          color: AppColor.bluColor,
                          fontWeight: AppFontStyles.fontWeightBold,
                        ),
                      ),
                      subtitle:    Text(
                        locationConst!.isNotEmpty?locationConst!:"",
                        style: TextStyle(
                          fontSize: AppFontStyles.descriptionLoginFontSize,
                          color: AppColor.fontColorDescription,
                          fontWeight: AppFontStyles.fontWeightMedium,
                        ),
                      ),
                    ),
                      const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),
                      Text(
                        " Edit Question ",
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
                        widget: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding),
                          child: TextFormField(
                            controller: _textControllerDescription,
                            keyboardType: TextInputType.text,
                            maxLines: 30,
                            decoration: InputDecoration(
                              hintText: 'Edit your question ...',
                              hintStyle: TextStyle(
                                color: AppColor.grayColorFont,
                                fontSize: AppFontStyles.descriptionLoginFontSize,
                              ),
                              border: InputBorder.none,
                            ),
                            cursorColor: AppColor.grayColorFont,
                            cursorHeight: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              fallback: (context) => Center(
                child: CircularProgressIndicator(
                  color: AppColor.orangeColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
