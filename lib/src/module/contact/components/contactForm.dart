import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../../custom_widgets/customTextField.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../logic.dart';

class ContactFormSection extends StatelessWidget {
  ContactFormSection({Key? key}) : super(key: key);

  final logic = Get.find<ContactLogic>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: logic.formKeyValue,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal / 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                Assets.icons.objectIcon,
              ),
            ),
            30.heightBox,
            Text(
              "Quick Contact",
              style: context.text.bodyLarge
                  ?.copyWith(color: AppColors.customWhiteTextColor
                      // height: 0.1
                      ),
            ),
            30.heightBox,
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
                      if (logic.formKeyValue.currentState!.validate()) {
                        await ContactLogic.to.sendContactMessage(
                            context,
                            logic.nameController.text,
                            logic.emailController.text,
                            logic.messageController.text);
                        logic.nameController.clear();
                        logic.emailController.clear();
                        logic.messageController.clear();
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
    );
  }
}
