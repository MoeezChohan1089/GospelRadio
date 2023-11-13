import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../custom_widgets/customTextField.dart';
import '../../utils/constants/colors.dart';
import '../music_catalog/components/gridView.dart';
import 'components/gridviewEngineers.dart';
import 'logic.dart';

class EngineersPage extends StatelessWidget {
  EngineersPage({Key? key}) : super(key: key);

  final logic = Get.put(EngineersLogic());
  final state = Get.find<EngineersLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.custombackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.custombackgroundColor,
        scrolledUnderElevation: 0,
        toolbarHeight: 150.h,
        centerTitle: true,
        title: Text(
          "Engineers",
          style: context.text.bodySmall?.copyWith(
              color: AppColors.customWhiteTextColor, fontSize: 14.sp),
        ),
        leadingWidth: 110.w,
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
                  width: 50.w,
                  // width: 150,
                )),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 80,
              child: CustomTextFieldC(
                // controller: logic.controllerSearch,
                hintText: 'search',
                // textAlign: TextAlign.center,
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
                onChanged: (query) {
                  logic.searchLogic(query!);
                },
                suffixIcon: Icon(
                  Icons.abc,
                  color: Colors.white,
                ),
              ),
            ) ,
          ),
        ),
      ),
      body: GridViewScreenEnginners(),
      bottomNavigationBar: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Image.asset('assets/images/ban.png', height: 85, width: double.maxFinite,),
          ),
        ],
      ),
    );
  }
}
