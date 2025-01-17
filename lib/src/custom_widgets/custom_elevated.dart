import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import '../utils/constants/colors.dart';

class GlobalElevatedButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final bool applyHorizontalPadding, isDisable;
  final VoidCallback onPressed;
  final Color? buttonColor;

  const GlobalElevatedButton({
    super.key,
    required this.text,
    required this.isLoading,
    this.applyHorizontalPadding = false,
    this.isDisable = false,
    required this.onPressed,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.maxFinite,
      height: 40.h,
      padding: EdgeInsets.symmetric(
        horizontal: applyHorizontalPadding ? 16.w : 0,
      ),
      child: ElevatedButton(

        onPressed: isDisable ? null : () {
          HapticFeedback.lightImpact();
          if (!isLoading) onPressed();
        },


        // onPressed: isDisable || isLoading
        //     ? null // If the button is disabled or in loading state, onPressed should be null
        //     : () {
        //   HapticFeedback.lightImpact();
        //   onPressed();
        // },
        style: ElevatedButton.styleFrom(
          // backgroundColor: const Color(0xff3B8C6E),
          elevation: 0,
          backgroundColor:
          isDisable
              ? AppColors.customGreyTextColor
              : AppColors.customPinkColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: isLoading
            ? SpinKitThreeBounce(
          color: Colors.white,
          size: 23.0,
          // controller: AnimationController(
          //     vsync: this, duration: const Duration(milliseconds: 1200)),
        )
            : Text(
          text.capitalize!,
          style: context.text.bodyLarge?.copyWith(
              color: Colors.white),
        ),
      ),
    );
  }
}