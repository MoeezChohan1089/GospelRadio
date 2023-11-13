
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/constants/colors.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

class NewsContentPageScreen extends StatefulWidget {
  final String content;
  const NewsContentPageScreen({super.key, required this.content});

  @override
  State<NewsContentPageScreen> createState() => _NewsContentPageScreenState();
}

class _NewsContentPageScreenState extends State<NewsContentPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.custombackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.custombackgroundColor,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
         "News Detail",
          style: context.text.bodySmall?.copyWith(
              color: AppColors.customWhiteTextColor, fontSize: 18.sp),
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
            icon: Icon(Icons.close, color: AppColors.customBlackTextColor,)
        ),
      ),
      body: SingleChildScrollView(
        child: Html(
          data: widget.content,
            style: {
              // tables will have the below background color
              "p": Style(
                color: Colors.white,
              ),
            }
        ),
      ),
    );
  }
}
