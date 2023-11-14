import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../utils/constants/colors.dart';
import '../buy_album/view.dart';
import 'components/chooseAmount.dart';
import 'components/loveGiftInformation.dart';
import 'logic.dart';

class PurchasePage extends StatefulWidget {
  int? ID;
  PurchasePage({Key? key, this.ID}) : super(key: key);

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  final logic = Get.put(PurchaseLogic());

  final state = Get.find<PurchaseLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.custombackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.custombackgroundColor,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "Love Gift",
          style: context.text.bodySmall?.copyWith(
              color: AppColors.customWhiteTextColor, fontSize: 14.sp),
        ),
        leadingWidth: 170.w,
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
                  width: 110.w,
                  // width: 150,
                )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LoveGiftInformationScreen(ID: widget.ID,),
            30.heightBox,
            ChooseAmountSection(),

          ],
        ),
      ),
    );
  }
}
