
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/constants/colors.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

class ContentPageScreen extends StatefulWidget {
  final String content;
  final int index;
  const ContentPageScreen({super.key, required this.content, required this.index});

  @override
  State<ContentPageScreen> createState() => _ContentPageScreenState();
}

class _ContentPageScreenState extends State<ContentPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.custombackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.custombackgroundColor,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          widget.index == 0? "Welcome": "Home / Hallelujah",
          style: context.text.bodySmall?.copyWith(
              color: AppColors.customWhiteTextColor, fontSize: 18.sp),
        ),
        leadingWidth: 180.w,
        leading: Row(
          children: [
            IconButton(
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
            Container(
              // width: 80,
              // // color: Colors.amber,
              // height: 80,
              // margin: EdgeInsets.only(top: 35.h),
                child: Image.asset(
                  "assets/images/hgc.png",
                  fit: BoxFit.cover,
                  width: 120.w,
                  // width: 150,
                )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            6.heightBox,
           widget.index == 0? Padding(
             padding: const EdgeInsets.symmetric(horizontal: 10),
             child: Text("We Are So Glad You Are Here!", style: context.text.titleMedium?.copyWith(
                 color: AppColors.customWhiteTextColor,
                 fontSize: 30.sp, fontFamily: 'linear'),),
           ):Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("Gospel Choice Radio", style: context.text.titleMedium?.copyWith(
                  color: AppColors.customWhiteTextColor,
                  fontSize: 30.sp, fontFamily: 'linear'),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("${widget.content}", style: context.text.titleMedium?.copyWith(
                  color: AppColors.customWhiteTextColor,
                  fontSize: 20.sp, ),),
            ),
          ],
        ),
      ),
    );
  }
}
