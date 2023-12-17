import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../utils/constants/colors.dart';
import 'components/editInformation.dart';
import 'components/profileForm.dart';
import 'logic.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final logic = Get.put(ProfileLogic());
  final state = Get.find<ProfileLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.custombackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.custombackgroundColor,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "Edit Profile",
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
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         // Get.to(() => CartPage());
        //       },
        //       icon: Icon(Icons.search, color: AppColors.customBlackTextColor,)
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            20.heightBox,
            EditProfileImageSection(),
            EditProfileFormScreen(),
          ],
        ),
      ),
    );
  }
}
