import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/constants/assets.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../custom_widgets/customTextField.dart';
import '../../../utils/constants/colors.dart';
import '../logic.dart';
import 'login.dart';
import 'otp.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final logic = Get.put(AuthLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child:
        Container(
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: logic.formKeyValue,
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
                  left: 35.0.w,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                Assets.icons.musicDummyIcon,
                                height: 40.h,
                              ),
                            ],
                          ),
                          20.heightBox,
                          Text(
                            'Sign Up',
                            style: context.text.titleMedium?.copyWith(
                                fontSize: 40.sp,
                                color: Colors.white,
                                height: 1.2,
                                fontWeight: FontWeight.w700),
                          ),
                          6.heightBox,
                          Text(
                            'to start play',
                            textAlign: TextAlign.start,
                            style: context.text.titleMedium?.copyWith(
                                fontSize: 20.sp,
                                color: Colors.white,
                                height: 1.2,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                Positioned(
                  bottom: 350.0,
                  left: 30.0,
                  right: 30.0,
                  // bottom: 300.0.h,
                  // left: 35.0.w,
                  // right: 30.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Full Name",
                        style: context.text.bodyLarge?.copyWith(color: Colors.white
                            // height: 0.1
                            ),
                      ),
                      6.heightBox,
                      Container(
                        height: 80,
                        child: CustomTextFieldC(
                          controller: logic.nameController,
                          hintText: 'Name',
                          // textAlign: TextAlign.center,
                          validation: (value) {
                            if (value!.isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                          hintFontSize: 16.0,
                          isOutlineInputBorder: true,
                          isOutlineInputBorderColor: AppColors.customWhiteTextColor,
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
                          suffixIcon: Icon(
                            Icons.abc,
                            color: Colors.white,
                          ),
                          onTap: () async {
                            null;
                          },
                        ),
                      ),
                      // 10.heightBox,

                      // 10.heightBox,
                    ],
                  ),
                ),
                Positioned(
                    bottom: 250.0,
                    left: 30.0,
                    right: 30.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style:
                              context.text.bodyLarge?.copyWith(color: Colors.white
                                  // height: 0.1
                                  ),
                        ),
                        6.heightBox,
                        Container(
                          height: 80,
                          child: CustomTextFieldC(
                            controller: logic.emailController,
                            hintText: 'Email',
                            // textAlign: TextAlign.center,
                            validation: (value) {
                              if (value!.isEmpty) {
                                return 'Email is required';
                              }
                              return null;
                            },
                            hintFontSize: 16.0,
                            isOutlineInputBorder: true,
                            isOutlineInputBorderColor:
                                AppColors.customWhiteTextColor,
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
                            onTap: () async {
                              null;
                            },
                            suffixIcon: Icon(
                              Icons.abc,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )),
                Positioned(
                    bottom: 150.0,
                    left: 30.0,
                    right: 30.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Password",
                          style:
                              context.text.bodyLarge?.copyWith(color: Colors.white
                                  // height: 0.1
                                  ),
                        ),
                        6.heightBox,
                        Obx(() {
                          return Container(
                            height: 80,
                            child: CustomTextFieldC(
                              controller: logic.passwordController,
                              hintText: 'Password',
                              // textAlign: TextAlign.center,
                              validation: (value) {
                                if (value!.isEmpty) {
                                  return 'Password is required';
                                }
                                return null;
                              },
                              hintFontSize: 16.0,
                              isOutlineInputBorder: true,
                              isOutlineInputBorderColor:
                                  AppColors.customWhiteTextColor,
                              textColor: Colors.white,
                              // textFieldFillColor: Colors.transparent,
                              // fontWeight: FontWeight.bold,
                              obscureText: logic.obscureText.value,
                              fieldborderRadius: 6,
                              outlineTopLeftRadius: 6,
                              outlineTopRightRadius: 6,
                              outlineBottomLeftRadius: 6,
                              outlineBottomRightRadius: 6,
                              textFontSize: 16.0,
                              hintTextColor: Colors.white,
                              suffixIcon: IconButton(
                                icon: Icon(logic.obscureText.value
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  logic.obscureText.value =
                                      !logic.obscureText.value;
                                },
                              ),
                              onTap: () async {
                                null;
                              },
                            ),
                          );
                        }),
                      ],
                    )),
                Positioned(
                  bottom: 55.0,
                  left: 30.0,
                  right: 30.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            if (logic.formKeyValue.currentState!.validate()) {
                              await AuthLogic.to.createNewUser(context: context);
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
                          child: Icon(
                            Icons.arrow_forward,
                            size: 30,
                          )),
                      Row(
                        children: [
                          Text("Or",
                              style: context.text.titleMedium
                                  ?.copyWith(color: Colors.white, fontSize: 16.sp)),
                          TextButton(
                            onPressed: () {
                              Get.to(() => LoginScreen());
                            },
                            child: Text("Sign In",
                                style: context.text.titleMedium?.copyWith(
                                    color: Colors.white, fontSize: 16.sp)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                    top: 30,
                    left: 20,
                    right: 20,
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                          
                          Expanded(
                            child: Container(
                                width: 100,
                                // color: Colors.amber,
                                height: 80,
                              // margin: EdgeInsets.only(top: 35.h),
                                child: Image.asset("assets/images/hgc.png", fit: BoxFit.contain,)),
                          ),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
