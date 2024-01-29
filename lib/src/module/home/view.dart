// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../custom_widgets/customDialogue.dart';
import '../../custom_widgets/customTextField.dart';
import '../../utils/constants/colors.dart';
import '../drawer.dart';
import '../gospel_website/components/videos.dart';
import '../music_radio/view.dart';
import 'components/headBanner.dart';
import 'components/listhorizontal.dart';
import 'components/verticalList.dart';
import 'logic.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.put(HomeLogic());
  final state = Get
      .find<HomeLogic>()
      .state;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print("value ${logic.loadingCatalog1.value}");
      return Scaffold(
        backgroundColor: AppColors.custombackgroundColor,
        key: _scaffoldKey,
        drawer: AppDrawer(),
        appBar: AppBar(
          leadingWidth: 100,
          toolbarHeight: 160.h,
          backgroundColor: AppColors.custombackgroundColor,
          scrolledUnderElevation: 0,
          // centerTitle: true,
          // title: Text(
          //   "Tapify".toUpperCase(),
          //   style:
          //   TextStyle(fontFamily: 'Sofia Pro Regular', fontSize: 18.sp),
          // ),
          leading:
          // Column(
          //   // mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     SizedBox(
          //       height: 10,
          //     ),
          //     Container(
          //       width: 120,
          //       // color: Colors.amber,
          //       height: 35,
          //       child: Image.asset(
          //         'assets/images/hgc.png',
          //         fit: BoxFit.contain,
          //       ),
          //     ),
          //     Expanded(
          //       child: Align(
          //         alignment: Alignment.topLeft,
          //         child: IconButton(
          //             onPressed: () {
          //               _scaffoldKey.currentState!.openDrawer();
          //               // if(bottomNav.isFancyDrawer.isTrue){
          //               //   bottomNav.advancedDrawerController.showDrawer();
          //               // } else {
          //               //   bottomNav.navScaffoldKey.currentState?.openDrawer();
          //               // }
          //             },
          //             icon: Icon(
          //               Icons.menu,
          //               color: AppColors.customBlackTextColor,
          //             )),
          //       ),
          //     ),
          //   ],
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // color: Colors.amber,
                width: 170,
                height: 35,
                child: Image.asset(
                  'assets/images/hgc.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          // actions: [
          //   Container(
          //     alignment: Alignment.topCenter,
          //     child: IconButton(onPressed: () {
          //       logic.loadingCatalog1.value = !logic.loadingCatalog1.value;
          //     }, icon: Icon(Icons.search, color: Colors.white,)),
          //   )
          // ],
          centerTitle: true,
          title: Text(
            "Catalog Album",
            textAlign: TextAlign.center,
            style: context.text.bodyMedium?.copyWith(
                color: AppColors.customWhiteTextColor, fontSize: 18.sp),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0.0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  10.widthBox,
                  IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState!.openDrawer();
                        // if(bottomNav.isFancyDrawer.isTrue){
                        //   bottomNav.advancedDrawerController.showDrawer();
                        // } else {
                        //   bottomNav.navScaffoldKey.currentState?.openDrawer();
                        // }
                      },
                      icon: Icon(
                        Icons.menu,
                        color: AppColors.customBlackTextColor,
                      )),
                  10.widthBox,
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Container(
                        height: 40,
                        child: CustomTextFieldC(
                          controller: logic.controllerSearch,
                          hintText: 'search',
                          // textAlign: TextAlign.center,
                          hintFontSize: 16.0,
                          isOutlineInputBorder: true,
                          isOutlineInputBorderColor: AppColors.customWhiteTextColor,
                          textColor: Colors.white,
                          // textFieldFillColor: Colors.transparent,
                          // fontWeight: FontWeight.bold,
                          fieldborderRadius: 100,
                          outlineTopLeftRadius: 100,
                          outlineTopRightRadius: 100,
                          outlineBottomLeftRadius: 100,
                          outlineBottomRightRadius: 100,
                          textFontSize: 16.0,
                          hintTextColor: Colors.white,
                          onTap: () async {
                            null;
                          },
                          onChanged: (query) {
                            logic.searchAlbums(query!);
                          },
                          prefixIcon: Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Icon(Icons.search, color: AppColors.customGreyBorderColor, size: 26,)),
                          suffixIcon: Icon(
                            Icons.abc,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SizedBox(
          width: double.maxFinite,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              ListHorizontalScreen(),
              // ListVerticalScreen(),
            ],
          ),
        ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Container(
                  margin: EdgeInsets.only(bottom: 10, top: 10),
                  height: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Advertise us",
                        style: context.text.titleMedium?.copyWith(
                            color: AppColors.customWhiteTextColor,
                            fontSize: 18.sp),
                      ),
                      Container(
                          height: 100,
                          child: HorizontalVideoList1()),
                    ],
                  )),
            ),
          ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.customPinkColor,
          foregroundColor: Colors.white,
          onPressed: () {
            Get.to(()=> Music_radioPage());

          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.music_note),
              Text("Live", style: TextStyle(color: Colors.white, fontSize: 14),)
            ],
          ),
        )
      );
    });
  }
}
