import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/module/auth/components/signup.dart';
import 'package:gosperadioapp/src/module/auth/logic.dart';
import 'package:gosperadioapp/src/utils/constants/assets.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../../custom_widgets/customTextField.dart';
import '../../../utils/constants/colors.dart';
import '../../home/view.dart';
import 'forgot.dart';


class NewPassordScreen extends StatelessWidget {
  NewPassordScreen({Key? key}) : super(key: key);

  final logic = Get.put(AuthLogic());
  String? password;
  String? confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: logic.formKeyValue6,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.images.welcomeBackground),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 120,
              left: 0,
              right: 0,
              child: Opacity(
                opacity: 0.6,
                child: Container(
                  alignment: Alignment.topRight,

                  child: SvgPicture.asset(
                    Assets.icons.polygonIcon,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 150.0.h,
              left: 30.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    Assets.icons.musicDummyIcon,
                    height: 40,
                  ),
                  20.heightBox,
                  Text(
                    'Reset',
                    style: context.text.titleMedium?.copyWith(fontSize: 40.sp,
                        color: Colors.white,
                        height: 1.2,
                        fontWeight: FontWeight.w700),
                  ),
                  6.heightBox,
                  Text(
                    'Your Password',
                    textAlign: TextAlign.start,
                    style: context.text.titleMedium?.copyWith(fontSize: 20.sp,
                        color: Colors.white,
                        height: 1.2,
                        fontWeight: FontWeight.w700),
                  ),


                ],
              ),
            ),
            Positioned(
              bottom: 0.0,
              top: 100.0,
              left: 30.0,
              right: 30.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New Password",
                    style: context.text.bodyLarge?.copyWith(
                        color: Colors.white
                      // height: 0.1
                    ),
                  ),
                  6.heightBox,
                  Obx(() {
                    return Container(
                      height: 80,
                      child: CustomTextFieldC(
                        controller: logic.forgotNewPasswordController,
                        hintText: 'Password',
                        obscureText: logic.obscureText2.value,
                        // textAlign: TextAlign.center,
                        validation: (value) {
                          password = value;
                          if (value!.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                        hintFontSize: 16.0,
                        isOutlineInputBorder: true,
                        isOutlineInputBorderColor: AppColors
                            .customWhiteTextColor,
                        textColor: Colors.white,
                        // textFieldFillColor: Colors.transparent,
                        // fontWeight: FontWeight.bold,
                        fieldborderRadius: 6,
                        outlineTopLeftRadius: 6,
                        outlineTopRightRadius: 6,
                        outlineBottomLeftRadius: 6,
                        outlineBottomRightRadius: 6,
                        textFontSize: 16.0,
                        hintTextColor: Colors.white,
                        suffixIcon: IconButton(
                          icon: Icon(logic.obscureText2.value
                              ? Icons.visibility_off
                              : Icons.visibility),
                          // Icons.visibility_off),
                          onPressed: () {
                            logic.obscureText2.value =
                            !logic.obscureText2.value;
                          },
                        ),
                        onTap: () async {
                          null;
                        },
                      ),
                    );
                  }),
                  10.heightBox,
                  Text(
                    "Confirm Password",
                    style: context.text.bodyLarge?.copyWith(
                        color: Colors.white
                      // height: 0.1
                    ),
                  ),
                  6.heightBox,
                  Obx(() {
                    return Container(
                      height: 80,
                      child: CustomTextFieldC(
                        controller: logic.forgotConfirmNewPasswordController,
                        hintText: 'Confirm Password',
                        obscureText: logic.obscureText3.value,
                        // textAlign: TextAlign.center,
                        validation: (value) {
                          confirmPassword = value;
                          if (value!.isEmpty) {
                            return 'Confirm Password is required';
                          }
                          if (password != confirmPassword) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        hintFontSize: 16.0,
                        isOutlineInputBorder: true,
                        isOutlineInputBorderColor: AppColors
                            .customWhiteTextColor,
                        textColor: Colors.white,
                        // textFieldFillColor: Colors.transparent,
                        // fontWeight: FontWeight.bold,
                        fieldborderRadius: 6,
                        outlineTopLeftRadius: 6,
                        outlineTopRightRadius: 6,
                        outlineBottomLeftRadius: 6,
                        outlineBottomRightRadius: 6,
                        textFontSize: 16.0,
                        hintTextColor: Colors.white,
                        suffixIcon: IconButton(
                          icon: Icon(logic.obscureText3.value
                              ? Icons.visibility_off
                              : Icons.visibility),
                          // Icons.visibility_off),
                          onPressed: () {
                            logic.obscureText3.value =
                            !logic.obscureText3.value;
                          },
                        ),
                        onTap: () async {
                          null;
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
            Positioned(
              bottom: 150.0,
              left: 30.0,
              right: 30.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        if (logic.formKeyValue6.currentState!.validate()) {
                         await logic.forgotResetPassword(context: context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.customMusicTextColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        // Set the text color of the button
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        // Set the padding around the button content
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              7), // Set the border radius of the button
                        ),
                      ),
                      child: Icon(Icons.arrow_forward, size: 30,)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
