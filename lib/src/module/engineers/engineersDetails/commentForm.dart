import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'dart:math' as math;
import '../../../custom_widgets/customTextField.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../contact/logic.dart';
import '../logic.dart';

class CommentFormScreen extends StatefulWidget {
  int? idHost;
  CommentFormScreen({Key? key, this.idHost}) : super(key: key);

  @override
  State<CommentFormScreen> createState() => _CommentFormScreenState();
}

class _CommentFormScreenState extends State<CommentFormScreen> {
  final logic = Get.put(EngineersLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.custombackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.custombackgroundColor,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "Comment",
          style: context.text.bodySmall?.copyWith(
              color: AppColors.customWhiteTextColor, fontSize: 14.sp),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
              // if(bottomNav.isFancyDrawer.isTrue){
              //   bottomNav.advancedDrawerController.showDrawer();
              // } else {
              //   bottomNav.navScaffoldKey.currentState?.openDrawer();
              // }
            },
            icon: Icon(Icons.arrow_back, color: AppColors.customBlackTextColor,)
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Transform.rotate(
              angle: -math.pi / 4,
              child: Opacity(
                opacity: 0.5, // Adjust the opacity as desired
                child: Text(
                  'HG',
                  style: TextStyle(
                    fontSize: 220.0, // Adjust the font size
                    color: Colors.grey, // Adjust the text color
                  ),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Form(
              key: logic.commentFormKeyValue,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal / 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(
                      "Full Name",
                      style: context.text.bodyLarge
                          ?.copyWith(color: AppColors.customWhiteTextColor
                        // height: 0.1
                      ),
                    ),
                    10.heightBox,
                    CustomTextFieldC(
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
                      onTap: () async {
                        null;
                      },
                    ),
                    10.heightBox,
                    Text(
                      "Email",
                      style: context.text.bodyLarge
                          ?.copyWith(color: AppColors.customWhiteTextColor
                        // height: 0.1
                      ),
                    ),
                    10.heightBox,
                    CustomTextFieldC(
                      controller: logic.emailController,
                      hintText: 'Email Address',
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
                      onTap: () async {
                        null;
                      },
                    ),
                    10.heightBox,
                    Text(
                      "City",
                      style: context.text.bodyLarge
                          ?.copyWith(color: AppColors.customWhiteTextColor
                        // height: 0.1
                      ),
                    ),
                    10.heightBox,
                    CustomTextFieldC(
                      controller: logic.cityController,
                      hintText: 'City',
                      // textAlign: TextAlign.center,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'City is required';
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
                      onTap: () async {
                        null;
                      },
                    ),
                    10.heightBox,
                    Text(
                      "State",
                      style: context.text.bodyLarge
                          ?.copyWith(color: AppColors.customWhiteTextColor
                        // height: 0.1
                      ),
                    ),
                    10.heightBox,
                    CustomTextFieldC(
                      controller: logic.stateController,
                      hintText: 'State',
                      // textAlign: TextAlign.center,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'state is required';
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
                      onTap: () async {
                        null;
                      },
                    ),
                    10.heightBox,
                    Text(
                      "Country",
                      style: context.text.bodyLarge
                          ?.copyWith(color: AppColors.customWhiteTextColor
                        // height: 0.1
                      ),
                    ),
                    10.heightBox,
                    CustomTextFieldC(
                      controller: logic.countryController,
                      hintText: 'Country',
                      // textAlign: TextAlign.center,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'country is required';
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
                      onTap: () async {
                        null;
                      },
                    ),

                    10.heightBox,
                    Text(
                      "Message",
                      style: context.text.bodyLarge
                          ?.copyWith(color: AppColors.customWhiteTextColor
                        // height: 0.1
                      ),
                    ),
                    10.heightBox,
                    CustomTextFieldC(
                      controller: logic.messageController,
                      hintText: 'Message',
                      maxLines: 3,
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
                      onTap: () async {
                        null;
                      },
                    ),
                    20.heightBox,
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: pageMarginHorizontal * 2),
                      child: Container(
                        width: double.maxFinite,
                        child: ElevatedButton(
                            onPressed: () async {
                              // Get.to(()=> HomePage());
                              if (logic.commentFormKeyValue.currentState!.validate()) {
                                print('ffffff: ${logic.nameController.text}');
                                print('ffffff: ${logic.emailController.text}');
                                print('ffffff: ${logic.cityController.text}');
                                print('ffffff: ${logic.stateController.text}');
                                print('ffffff: ${logic.countryController.text}');
                                print('ffffff: ${logic.messageController.text}');
                                print('ffffff: ${widget.idHost}');
                                await EngineersLogic.to.sendComment(
                                    context,
                                    logic.nameController.text,
                                    logic.emailController.text,
                                    logic.cityController.text,
                                    logic.stateController.text,
                                    logic.countryController.text,
                                    widget.idHost.toString(),
                                    logic.messageController.text);
                                logic.nameController.clear();
                                logic.emailController.clear();
                                logic.cityController.clear();
                                logic.stateController.clear();
                                logic.countryController.clear();
                                logic.messageController.clear();
                                logic.getCommentFromApiService(widget.idHost!);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.customPinkColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              // Set the text color of the button
                              padding: const EdgeInsets.all(10),
                              // Set the padding around the button content
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    7), // Set the border radius of the button
                              ),
                            ),
                            child: Text(
                              "Done",
                              style: context.text.bodyMedium!.copyWith(
                                  color: Colors.white, fontSize: 18.sp, height: 1.1),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
