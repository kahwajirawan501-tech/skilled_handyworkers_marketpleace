import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/styles/colors.dart';
import '../shared/styles/styles.dart';

import 'cubitLogin/cubit.dart';
import 'cubitLogin/states.dart';

class RegisterTitle extends StatelessWidget {
  @required
  final String title1;

  @required
  final String title2;

  final String? pathImage;

  RegisterTitle({required this.title1, required this.title2, this.pathImage});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext content) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Center(
            child: Column(
              children: [
                Text(
                  title1,
                  style: TextStyle(
                      fontWeight: AppFontStyles.fontWeightSemiBold7,
                      fontSize: AppFontStyles.addressLoginLargeFontSize,
                      color: AppColor.fontColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    title2,
                    style: TextStyle(
                        fontWeight: AppFontStyles.fontWeightMedium,
                        fontSize: AppFontStyles.descriptionLoginFontSize,
                        color: AppColor.fontColorDescription),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Center(child: Image.asset(pathImage!)),
                SizedBox(
                  height: 70,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
