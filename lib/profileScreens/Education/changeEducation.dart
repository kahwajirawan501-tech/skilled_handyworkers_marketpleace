import 'package:flutter/material.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/WorkExperience/work.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';

class ChangeEducation extends StatelessWidget {
  const ChangeEducation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Work(
      buttonTF: false,
      title: "Change Education",
      field1: "Institution name",
      field2: "Description",
      description: "Write additional information here",
      titleButton1:"Save",
      titleButton2: "Remove",
      onPressed1: () {
        showCustomModal(
          context,
          title: "Remove Work Experience ?",
          description: "Are you sure you want to delete this work experience?",
          titleButton1: "Continue Filling",
          titleButton2: "Undo Changes",
          onPressed1:() {
            Navigator.pop(context); // إغلاق القائمة السفلية

          },
          onPressed2: () {
            Navigator.pop(context); // إغلاق القائمة السفلية

          },

        );
      },
      onPressed2: () {
        showCustomModal(
          context,
          title: "Undo Changes ?",
          description: "Are you sure you want to change what you entered?",
          titleButton1: "Continue Filling",
          titleButton2: "Undo Changes",
          onPressed1:() {
            Navigator.pop(context); // إغلاق القائمة السفلية

          },
          onPressed2: () {
            Navigator.pop(context); // إغلاق القائمة السفلية

          },

        );
      },
    );
  }
}
