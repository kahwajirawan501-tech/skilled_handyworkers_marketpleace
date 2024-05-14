import 'package:flutter/material.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class Box extends StatelessWidget {
  final Widget widget;
  final double height;
  final BorderRadiusGeometry? borderRadius;//
  const Box({Key? key, required this.widget, required this.height, required this.borderRadius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:height ,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: Colors.white,

      ),
      child: widget,
    );
  }
}