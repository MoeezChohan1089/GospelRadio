import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../utils/constants/colors.dart';
import 'components/gospelList.dart';
import 'components/videos.dart';
import 'logic.dart';

class GospelWebsitePage extends StatelessWidget {
  GospelWebsitePage({Key? key}) : super(key: key);

  final logic = Get.put(GospelWebsiteLogic());
  final state = Get.find<GospelWebsiteLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.custombackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.custombackgroundColor,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "Gospel Website",
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
      body: GospelWebsiteSection(),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 10, left: 10),
          height: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Website Platforms",
                style: context.text.titleMedium?.copyWith(
                    color: AppColors.customWhiteTextColor,
                    fontSize: 18.sp),
              ),
              Container(
                  height: 100,
                  child: HorizontalVideoList()),
            ],
          )),
    );
  }
}
