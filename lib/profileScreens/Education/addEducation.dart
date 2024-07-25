import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/WorkExperience/work.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';

class AddEducation extends StatelessWidget {
  const AddEducation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController educationTitle=TextEditingController();
    TextEditingController descriptionEducation=TextEditingController();
    educationTitle.text=educationTittle!.isNotEmpty?educationTittle!:"";
    descriptionEducation.text=educationDescription!.isNotEmpty?educationDescription!:"";

    return BlocConsumer<ProfileCubit,ProfileStates>(
      listener: (context, state) {
        if(state is EducationSucssessfullStateStates){
          showToast(text:"Adding successfully", state: ToastStates.EROOR);

          Navigator.pop(context);

        }
        else if(state is EducationErrorStateStates){
          showToast(text:"Adding not successfully \n", state: ToastStates.EROOR);

        }
        if(state is EditEducationSucssessfullStateStates){
          showToast(text:"Editing successfully", state: ToastStates.EROOR);

          Navigator.pop(context);


        }
        else if(state is EditEducationErrorStateStates){
          showToast(text:"Editing not successfully \n", state: ToastStates.EROOR);

        }
      },
      builder: (context, state) {
        return  Work(
          conditionBuilder: ConditionalBuilder(
            condition: state is !EducationStatesLoadingStateStates && state is !EditEducationStatesLoadingStateStates,
            builder: (context) => const SizedBox(),
            fallback:(context) => LinearProgressIndicator(color: AppColor.orangeColor,minHeight: 1.0,),),
          jobTitle: educationTitle,
          descriptionJob: descriptionEducation,
          buttonTF: true,
          title: "Add Education",
          field1: "Institution name",
          field2: "Description",
          description: "Write additional information here",
          titleButton1:"Save",
          titleButton2: "",
          onPressed1: () {
            // if(educationTitle.text.isEmpty&&descriptionEducation.text.isEmpty){
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(
            //       backgroundColor: AppColor.backgroundColor,
            //       content: Center(
            //           child: Text(
            //               'Please enter tittle or description first',
            //               style: TextStyle(
            //                   color: AppColor.grayColorFont))),
            //       duration: Duration(seconds: 2),
            //     ),
            //   );
            // }
       // else{
              showCustomModal(
                context,
                title: "Undo Changes ?",
                description: "Are you sure you want to change what you entered?",
                titleButton1: "Continue Filling",
                titleButton2: "Undo Changes",
                onPressed1:() {
                  (educationTittle!.isNotEmpty||educationDescription!.isNotEmpty)?
                  ProfileCubit.get(context).editEducation(educationTitle.text, descriptionEducation.text):
                  ProfileCubit.get(context).addEducation(educationTitle.text, descriptionEducation.text);
                  Navigator.pop(context); // إغلاق القائمة السفلية


                },
                onPressed2: () {
                  Navigator.pop(context); // إغلاق القائمة السفلية

                },

              );
            },
          // },
          onPressed2: () {

          },
        );
      },

    );
  }
}
