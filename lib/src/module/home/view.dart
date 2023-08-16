// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../custom_widgets/customDialogue.dart';
import '../../custom_widgets/customTextField.dart';
import '../../utils/constants/colors.dart';
import '../drawer.dart';
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
      return Scaffold(
        backgroundColor: AppColors.custombackgroundColor,
        key: _scaffoldKey,
        drawer: AppDrawer(),
        appBar: AppBar(
          leadingWidth: 100,
          toolbarHeight: logic.loadingCatalog1.value? 210.h:135.h,
          backgroundColor: AppColors.custombackgroundColor,
          scrolledUnderElevation: 0,
          // centerTitle: true,
          // title: Text(
          //   "Tapify".toUpperCase(),
          //   style:
          //   TextStyle(fontFamily: 'Sofia Pro Regular', fontSize: 18.sp),
          // ),
          leading: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                width: 120,
                // color: Colors.amber,
                height: 35,
                child: Image.asset(
                  'assets/images/hgc.png',
                  fit: BoxFit.contain,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
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
              ),
            ],
          ),
          actions: [
            IconButton(onPressed: () {
              logic.loadingCatalog1.value = !logic.loadingCatalog1.value;
            }, icon: Icon(Icons.search, color: Colors.white,))
          ],
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hallelujah Gospel Choice Radio",
                textAlign: TextAlign.center,
                style: context.text.bodyMedium?.copyWith(
                    color: AppColors.customWhiteTextColor, fontSize: 16.sp),
              ),
              30.heightBox,
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: logic.loadingCatalog1.value ? Container(
                height: 80,
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
                    logic.searchAlbums(query!);
                  },
                  suffixIcon: Icon(
                    Icons.abc,
                    color: Colors.white,
                  ),
                ),
              ) : SizedBox(),
            ),
          ),
        ),
        body: SizedBox(
          width: double.maxFinite,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              BannerSection(),
              ListHorizontalScreen(),
              ListVerticalScreen(),
            ],
          ),
        ),
      );
    });
  }
}
