import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/margins_spacnings.dart';
import 'components/playListHistory.dart';
import 'components/playingList.dart';
import 'logic.dart';

class PlayHistoryPage extends StatelessWidget {
  PlayHistoryPage({Key? key}) : super(key: key);

  final logic = Get.put(PlayHistoryLogic());
  final state = Get.find<PlayHistoryLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.custombackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.custombackgroundColor,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "Playing/History",
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
        actions: [
          IconButton(
              onPressed: () {
                // Get.to(() => CartPage());
              },
              icon: Icon(Icons.search, color: AppColors.customBlackTextColor,)
          ),
        ],
      ),
      body: Column(
        children: [
          // PlayHistoryScreen(),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal, ),
          //   child: Row(
          //     children: [
          //       Text("Next Playing", style: context.text.titleMedium?.copyWith(color: AppColors.customWhiteTextColor, fontSize: 18.sp),),
          //     ],
          //   ),
          // ),
          PlayingListSection(),
        ],
      ),
    );
  }
}
