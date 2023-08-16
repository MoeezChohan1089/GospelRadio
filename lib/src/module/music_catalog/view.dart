// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../utils/constants/colors.dart';
import '../drawer.dart';
import 'components/gridView.dart';
import 'logic.dart';

class MusicCatalogPage extends StatelessWidget {
  MusicCatalogPage({Key? key}) : super(key: key);

  final logic = Get.put(Music_catalogLogic());
  final state = Get.find<Music_catalogLogic>().state;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.custombackgroundColor,
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.custombackgroundColor,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "Music Catalog",
          style: context.text.bodySmall?.copyWith(
              color: AppColors.customWhiteTextColor, fontSize: 14.sp),
        ),
        leading: IconButton(
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
        actions: [
          IconButton(
              onPressed: () {
                // Get.to(() => CartPage());
              },
              icon: Icon(
                Icons.search,
                color: AppColors.customBlackTextColor,
              )),
        ],
      ),
      body: GridViewScreen(),
    );
  }
}
