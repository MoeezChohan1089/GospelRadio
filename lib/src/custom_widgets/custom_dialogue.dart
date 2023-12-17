import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../module/auth/components/login.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/margins_spacnings.dart';

Future customDialogueBox(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return Dialog(
        backgroundColor: AppColors.customWhiteTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              8.0), // Set your desired border radius here
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.customWhiteTextColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: 6.w,
                        top: 5.h
                    ),
                    child: GestureDetector(onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.of(context).pop();
                    }, child: Icon(Icons.close, size: 20.sp,)),
                  ),
                ],
              ),
              24.heightBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Buy This Album For Play Full Song.",
                      textAlign: TextAlign.center,
                      style: context.text.bodyMedium!.copyWith(
                          color: AppColors.customGreyPriceColor,
                          height: 1.1,
                          fontSize: 14.sp),)),
              ),
              15.heightBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal,
                    vertical: pageMarginVertical),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child:
                      SizedBox(
                        height: 30,
                        child: ElevatedButton(
                            onPressed: () async {
                              // Vibration.vibrate(duration: 100);
                              HapticFeedback.lightImpact();
                              Navigator.of(context).pop(); // Close the dialog
                              Navigator.of(context).pop();
                              // ProductDetailLogic.to.addProductToCart();
                            },

                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.white,

                                elevation: 0,
                                // Set the text color of the button
                                padding: const EdgeInsets.all(8),
                                // Set the padding around the button content
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.r),
                                ),
                                side: BorderSide(
                                  width: 0.5,
                                  color: Colors.black,

                                  // color: AppConfig.to.primaryColor.value,
                                )
                            ),
                            child: Text("Not Now",
                              style: context.text.bodyMedium!.copyWith(
                                  color: Colors.black,

                                  // color: AppConfig.to.primaryColor.value,
                                  // color: AppConfig.to.primaryColor.value,
                                  height: 1.1),)),
                      ),
                    ),
                    const SizedBox(width: 16.0),

                    Expanded(
                      child: SizedBox(
                        height: 30,
                        child: ElevatedButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                             Get.to(()=>LoginScreen());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.customWebsiteListColor,
                              // backgroundColor: AppColors.appPriceRedColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              // Set the text color of the button
                              padding: const EdgeInsets.all(8),
                              // Set the padding around the button content
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.r),
                              ),
                            ),
                            child: Text("Login",
                              style: context.text.bodyMedium!.copyWith(
                                  color: Colors.white, height: 1.1),)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}