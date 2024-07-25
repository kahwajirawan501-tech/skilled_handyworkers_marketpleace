import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/WorkExperience/work.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';


class AddWorkExperience extends StatelessWidget {


  const AddWorkExperience({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController jobTitle=TextEditingController();
    TextEditingController descriptionJob=TextEditingController();
    jobTitle.text=workTittle!.isNotEmpty?workTittle!:"";
    descriptionJob.text=workDescription!.isNotEmpty?workDescription!:"";
    return BlocConsumer<ProfileCubit,ProfileStates>(
      listener: (context, state) {
        if(state is WorkExperienceSucssessfullStateStates){
          showToast(text:"Adding successfully", state: ToastStates.EROOR);

          Navigator.pop(context);

        }
        else if(state is WorkExperienceErrorStateStates){
          showToast(text:"Adding not successfully \n", state: ToastStates.EROOR);

        }
        if(state is EditWorkExperienceSucssessfullStateStates){
          showToast(text:"Editing successfully", state: ToastStates.EROOR);

          Navigator.pop(context);


        }
        else if(state is EditWorkExperienceErrorStateStates){
          showToast(text:"Editing not successfully \n", state: ToastStates.EROOR);

        }
      },
      builder: (context, state) {
        return Work(
          conditionBuilder: ConditionalBuilder(
            condition: state is !WorkExperienceStatesLoadingStateStates && state is !EditWorkExperienceStatesLoadingStateStates,
            builder: (context) => const SizedBox(),
            fallback:(context) => LinearProgressIndicator(color: AppColor.orangeColor,minHeight: 1.0,),),
          descriptionJob: descriptionJob,
          jobTitle: jobTitle,
          buttonTF: true,
          title: "Add work experience",
          field1: "Job title",
          field2: "Description",
          description: "Write additional information here",
          titleButton1:"Save",
          titleButton2: "",
          onPressed1: () {
            // if(jobTitle.text.isEmpty&&descriptionJob.text.isEmpty){
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
            // else if(jobTitle.text.isNotEmpty&&descriptionJob.text.isEmpty){
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(
            //       backgroundColor: AppColor.backgroundColor,
            //       content: Center(
            //           child: Text(
            //               'Please enter  description first',
            //               style: TextStyle(
            //                   color: AppColor.grayColorFont))),
            //       duration: Duration(seconds: 2),
            //     ),
            //   );
            // }
            // else if(jobTitle.text.isEmpty&&descriptionJob.text.isNotEmpty){
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(
            //       backgroundColor: AppColor.backgroundColor,
            //       content: Center(
            //           child: Text(
            //               'Please enter  tittle first',
            //               style: TextStyle(
            //                   color: AppColor.grayColorFont))),
            //       duration: Duration(seconds: 2),
            //     ),
            //   );
            // }

         // else{
         //   print(jobTitle.text);
         //   print(descriptionJob.text);
              showCustomModal(
                context,
                title: "Undo Changes ?",
                description: "Are you sure you want to change what you entered?",
                titleButton1: "Continue Filling",
                titleButton2: "Undo Changes",
                onPressed1:() {
                  (workTittle!.isNotEmpty||workDescription!.isNotEmpty)?
                  ProfileCubit.get(context).editWorkExperience(jobTitle.text, descriptionJob.text):
                  ProfileCubit.get(context).addWorkExperience(jobTitle.text, descriptionJob.text);
                  Navigator.pop(context); // إغلاق القائمة السفلية



                },
                onPressed2: () {
                  Navigator.pop(context);

                },

              );

            // }
          },
          onPressed2: () {

          },
        );
      },

    );
  }
}
