import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../../utils/constants/colors.dart';

class FullTextScreen extends StatelessWidget {
  final String fullText;

  FullTextScreen({required this.fullText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.custombackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.custombackgroundColor,
        scrolledUnderElevation: 0,
        // centerTitle: true,
        // title: Text(
        //   "Tapify".toUpperCase(),
        //   style:
        //   TextStyle(fontFamily: 'Sofia Pro Regular', fontSize: 18.sp),
        // ),
        leading: IconButton(
            onPressed: () {
              Get.back();
              // if(bottomNav.isFancyDrawer.isTrue){
              //   bottomNav.advancedDrawerController.showDrawer();
              // } else {
              //   bottomNav.navScaffoldKey.currentState?.openDrawer();
              // }
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        centerTitle: true,
        title: Text(
          "About",
          textAlign: TextAlign.center,
          style: context.text.bodyMedium?.copyWith(
              color: AppColors.customWhiteTextColor, fontSize: 18.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          fullText,
          style: context.text.bodyMedium?.copyWith(
        height: 1.2,
          color: AppColors.customWhiteTextColor,
          fontSize: 18.sp,
        ),
        ),
      ),
    );
  }
}
