import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/margins_spacnings.dart';
import '../../utils/skeleton_loaders/shimmerLoader.dart';
import 'components/playListHistory.dart';
import 'components/playingList.dart';
import 'logic.dart';

class PlayHistoryPage extends StatefulWidget {
  PlayHistoryPage({Key? key}) : super(key: key);

  @override
  State<PlayHistoryPage> createState() => _PlayHistoryPageState();
}

class _PlayHistoryPageState extends State<PlayHistoryPage> {
  final logic = Get.put(PlayHistoryLogic());

  final state = Get
      .find<PlayHistoryLogic>()
      .state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      logic.onAirFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        logic.searchHistoryController.clear();
        return true; // true allows the back action, false prevents it
      },
      child: Scaffold(
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
                logic.searchHistoryController.clear();
                // if(bottomNav.isFancyDrawer.isTrue){
                //   bottomNav.advancedDrawerController.showDrawer();
                // } else {
                //   bottomNav.navScaffoldKey.currentState?.openDrawer();
                // }
              },
              icon: Icon(Icons.arrow_back, color: AppColors.customBlackTextColor,)
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
        body: Obx(() {
          return Column(
            children: [

              logic.loadingAir.value? Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(child: CircularProgressIndicator(color: AppColors.customPinkColor,),),
              ):  Padding(
                padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 150,

                        child: Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r),),
                                ),
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 3),
                                child: Text('Now Playing',
                                  textAlign: TextAlign.center,
                                  style: context.text.bodyMedium?.copyWith(
                                      color: Colors.black,
                                      fontSize: 16.sp),)),
                            Stack(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.r), bottomRight: Radius.circular(10.r),),
                                    child:
          // Image.asset('assets/images/hgc.png', height: 110,fit: BoxFit.cover,)
          logic.hostImage != null?  CachedNetworkImage(
                                    imageUrl: logic.hostImage ?? "",

                                    height: 150.h,
                                    width: double.maxFinite,
                                    // imageUrl: (productDetail?.images ?? []).isNotEmpty
                                    //     ? productDetail!.images[0].originalSrc
                                    //     : "",
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        productShimmer(),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                  ):Image.asset('assets/images/hgc.png', height: 110,fit: BoxFit.cover,),
                                ),
                                Positioned.fill(
                                  child: Container(
                                    height: 150.h,
                                    width: 150.w,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        20.heightBox,
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Container(
                                            width: double.maxFinite,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: [
                                                Text('Title:  ${logic.dataPlayNow
                                                    .value['title'] ?? ''}',
                                                  textAlign: TextAlign.start,
                                                  style: context.text.bodyMedium
                                                      ?.copyWith(color: AppColors
                                                      .customWhiteTextColor,
                                                      fontSize: 14.sp),),
                                                Text('Artist: ${logic.dataPlayNow
                                                    .value['artist'] ?? ''}',
                                                  textAlign: TextAlign.start,
                                                  style: context.text.bodyMedium
                                                      ?.copyWith(color: AppColors
                                                      .customWhiteTextColor,
                                                      fontSize: 14.sp),),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    10.widthBox,
                    Expanded(
                      child: Container(
                        height: 150,

                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r),),
                              ),
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 3),
                                child: Text('Next Playing',
                                  textAlign: TextAlign.center,
                                  style: context.text.bodyMedium?.copyWith(
                                      color: Colors.black,
                                      fontSize: 16.sp),)),
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.r), bottomRight: Radius.circular(10.r),),
                                  child:
          // Image.asset('assets/images/hgc.png', height: 110,fit: BoxFit.cover,)
                               logic.hostImage != null?   CachedNetworkImage(
                                    imageUrl: logic.hostImage ?? "",

                                    height: 150.h,
                                    width: double.maxFinite,
                                    // imageUrl: (productDetail?.images ?? []).isNotEmpty
                                    //     ? productDetail!.images[0].originalSrc
                                    //     : "",
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        productShimmer(),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                  ): Image.asset('assets/images/hgc.png', height: 110,fit: BoxFit.cover,),
                                ),
                                Positioned.fill(
                                  child: Container(
                                    height: 150.h,
                                    width: 150.w,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        20.heightBox,
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Container(
                                            width: double.maxFinite,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: [
                                                Text('Title:  ${logic.playNext
                                                    .value['title'] ?? ''}',
                                                  textAlign: TextAlign.start,
                                                  style: context.text.bodyMedium
                                                      ?.copyWith(color: AppColors
                                                      .customWhiteTextColor,
                                                      fontSize: 14.sp),),
                                                Text('Artist: ${logic.playNext
                                                    .value['artist'] ?? ''}',
                                                  textAlign: TextAlign.start,
                                                  style: context.text.bodyMedium
                                                      ?.copyWith(color: AppColors
                                                      .customWhiteTextColor,
                                                      fontSize: 14.sp),),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              10.heightBox,
              // PlayHistoryScreen(),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal, ),
              //   child: Row(
              //     children: [
              //       Text("Next Playing", style: context.text.titleMedium?.copyWith(color: AppColors.customWhiteTextColor, fontSize: 18.sp),),
              //     ],
              //   ),
              // ),
              Expanded(child: PlayingListSection()),
            ],
          );
        }),
      ),
    );
  }
}