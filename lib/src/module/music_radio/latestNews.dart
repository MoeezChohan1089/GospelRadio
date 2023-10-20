
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/module/music_play/logic.dart';
import 'package:gosperadioapp/src/utils/constants/colors.dart';
import 'package:gosperadioapp/src/utils/constants/margins_spacnings.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:intl/intl.dart';

import '../../custom_widgets/webview_custom.dart';
import 'logic.dart';

class LatestNewsScreen extends StatefulWidget {
  LatestNewsScreen({super.key});

  @override
  State<LatestNewsScreen> createState() => _LatestNewsScreenState();
}

class _LatestNewsScreenState extends State<LatestNewsScreen> {
  final logic = Get.put(Music_radioLogic());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Calculate the current date index
      logic.navigateButtons3();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.custombackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.custombackgroundColor,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "Latest News",
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
      ),
      body: Obx((){
        return logic.isLoadingAlbums.value == true? Center(child: CircularProgressIndicator(color: Colors.white,),): SingleChildScrollView(
          child: Column(
            children: List.generate(logic.latestNews.value.length, (index){
              String dateString = logic.latestNews.value[index]['created_at']; // Assuming this is your date string
              DateTime dateTime = DateTime.parse(dateString); // Convert the string to a DateTime object
              String formattedDate = DateFormat('MMM dd yyyy').format(dateTime);
              return
                GestureDetector(
                  onTap: (){
                    // Get.to(WebViewCustom(
                    //   productUrl: '${logic.latestNews.value[index]['view_url']}',
                    //   title: logic.latestNews.value[index]['title'],
                    // ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 150.h,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        // backgroundBlendMode: BlendMode.darken,
                        // color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10.r),
                        image: DecorationImage(
                          image: NetworkImage(logic.latestNews.value[index]['image_url']),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.6),
                            BlendMode.dstATop,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${logic.latestNews.value[index]['title']}",
                            textAlign: TextAlign.center,
                            style: context.text.titleMedium?.copyWith(
                                color: AppColors.customWhiteTextColor,
                                fontSize: 24.sp),
                          ),
                          10.heightBox,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal/1.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 120,
                                  child: Text(
                                    "${logic.latestNews.value[index]['slug']}",
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    style: context.text.titleMedium?.copyWith(
                                        overflow: TextOverflow.ellipsis,
                                        color: AppColors.customWhiteTextColor,
                                        fontSize: 18.sp),
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  child: Text(
                                    "${logic.latestNews.value[index]['status']}",
                                    maxLines: 2,
                                    textAlign: TextAlign.end,
                                    style: context.text.titleMedium?.copyWith(
                                        overflow: TextOverflow.ellipsis,
                                        color: AppColors.customWhiteTextColor,
                                        fontSize: 18.sp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${formattedDate}",
                            textAlign: TextAlign.center,
                            style: context.text.titleMedium?.copyWith(
                                color: AppColors.customWhiteTextColor,
                                fontSize: 18.sp),
                          ),
                          // 10.heightBox,
                        ],
                      ),
                    ),
                  ),
                );
            }),
          ),
        );
      }),
    );
  }
}
