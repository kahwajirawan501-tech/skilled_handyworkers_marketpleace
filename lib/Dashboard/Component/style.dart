

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class PrimaryText extends StatelessWidget {
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final String text;
  final double height;
  final GestureTapCallback? onTap;


  const PrimaryText({super.key,
    this.size = 20,
    this.fontWeight =FontWeight.w400,
    this.color =Colors.red,
    required this.text,
    this.height =1.3, this.onTap});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:onTap ,
      child: Text(text,
        style: TextStyle(
            color: color,
            height: height,
            fontSize: size,
            fontWeight: fontWeight
        ),),
    );
  }
}


