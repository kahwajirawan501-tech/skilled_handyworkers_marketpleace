
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class ShowImageInDialog{

  void showImageInDialog(XFile image,context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Image Preview",
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation1, animation2) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: Image.file(
              File(image.path),
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        );
      },
    );
  }

}