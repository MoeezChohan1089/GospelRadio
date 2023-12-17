
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/module/music_play/logic.dart';
import 'package:gosperadioapp/src/utils/constants/colors.dart';
import 'package:gosperadioapp/src/utils/constants/margins_spacnings.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:intl/intl.dart';

import '../../content.dart';
import '../../custom_widgets/webview_custom.dart';
import '../../utils/skeleton_loaders/shimmerLoader.dart';
import 'logic.dart';
import 'new_content.dart';

class LatestNewsScreen extends StatefulWidget {
  LatestNewsScreen({super.key});

  @override
  State<LatestNewsScreen> createState() => _LatestNewsScreenState();
}

class _LatestNewsScreenState extends State<LatestNewsScreen> {
  final logic = Get.put(Music_radioLogic());

  List imageSlider = [
    'assets/images/HgcBanner.jpeg',
    'assets/images/hgctt.png'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Calculate the current date index
      logic.navigateButtons4();
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
      ),
        bottomNavigationBar: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Image.asset('assets/images/ban.png', height: 85, width: double.maxFinite,),
            ),
          ],
        ),
      body: logic.isLoadingAlbums.value == true? Center(child: CircularProgressIndicator(color: Colors.white,),):Column(
        children: [
          Obx((){
            return SingleChildScrollView(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselSlider(

                    items: List.generate(logic.featureNews.value.length, (index){
                      String dateString = logic.featureNews.value[index]['created_at']; // Assuming this is your date string
                      DateTime dateTime = DateTime.parse(dateString); // Convert the string to a DateTime object
                      String formattedDate = DateFormat('MMM dd yyyy').format(dateTime);
                      return
                        GestureDetector(
                          onTap: (){
                            Get.to(NewsContentPageScreen(
                              content: '${logic.featureNews.value[index]['body']}',
                            ), transition: Transition.downToUp,
                                duration: Duration(seconds: 1));
                            // launchURL(
                            //     "${logic.newRelease.value[index]['view_url']}");
                            // Get.to(WebViewCustom(
                            //   productUrl: '${logic.newRelease.value[index]['view_url']}',
                            //   title: logic.newRelease.value[index]['title'],
                            // ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Stack(
                              // alignment: Alignment.bottomLeft,
                              children: [
                                Container(
                                  height: 280.h,
                                  width: double.maxFinite,
                                  child: CachedNetworkImage(
                                    imageUrl: logic.featureNews.value[index]['image_url'],


                                    // imageUrl: (productDetail?.images ?? []).isNotEmpty
                                    //     ? productDetail!.images[0].originalSrc
                                    //     : "",
                                    fit: BoxFit.cover,
                                    height: double.infinity,
                                    colorBlendMode: BlendMode.darken,
                                    color: Colors.black.withOpacity(0.4),
                                    width: double.infinity,
                                    placeholder: (context, url) =>
                                        productShimmer(),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                  ),
                                ),
                                Positioned.fill(child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                        width: double.maxFinite,
                                        child: Text(
                                          "${formattedDate}",
                                          textAlign: TextAlign.end,
                                          style: context.text.titleMedium?.copyWith(
                                              color: AppColors.customWhiteTextColor,
                                              fontSize: 16.sp),
                                        ),
                                      ),
                                    ),
                                    // 10.heightBox,
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal/1.5),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              "${logic.featureNews.value[index]['category_name']}",
                                              maxLines: 2,
                                              textAlign: TextAlign.start,
                                              style: context.text.titleMedium?.copyWith(
                                                  overflow: TextOverflow.ellipsis,
                                                  color: AppColors.customWhiteTextColor,
                                                  fontSize: 16.sp),
                                            ),
                                          ),
                                          10.heightBox,
                                          Container(
                                            width: double.maxFinite,
                                            child: Text(
                                              "${logic.featureNews.value[index]['title']}",
                                              maxLines: 2,
                                              textAlign: TextAlign.start,
                                              style: context.text.titleMedium?.copyWith(
                                                  color: AppColors.customWhiteTextColor,
                                                  overflow: TextOverflow.ellipsis,
                                                  fontSize: 18.sp),
                                            ),
                                          ),
                                          15.heightBox,
                                          // Container(
                                          //   width: 120,
                                          //   child: Text(
                                          //     "${logic.latestNews.value[index]['slug']}",
                                          //     maxLines: 2,
                                          //     textAlign: TextAlign.start,
                                          //     style: context.text.titleMedium?.copyWith(
                                          //         overflow: TextOverflow.ellipsis,
                                          //         color: AppColors.customWhiteTextColor,
                                          //         fontSize: 16.sp),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    // 10.heightBox,
                                  ],
                                ),)
                              ],
                            ),
                          ),
                        );
                      // :Container(
                      //     decoration: BoxDecoration(
                      //         border: Border(bottom: BorderSide(color: Colors.white, width: 1))
                      //     ),
                      //     child: GestureDetector(
                      //       onTap: (){
                      //         // launchURL(
                      //         //     "${logic.newRelease.value[index]['view_url']}");
                      //         // Get.to(WebViewCustom(
                      //         //   productUrl: '${logic.newRelease.value[index]['view_url']}',
                      //         //   title: logic.newRelease.value[index]['title'],
                      //         // ));
                      //       },
                      //       child: Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 10,),
                      //         child: Container(
                      //           height: 150.h,
                      //           width: double.maxFinite,
                      //           decoration: BoxDecoration(
                      //             // backgroundBlendMode: BlendMode.darken,
                      //             // color: Colors.black.withOpacity(0.8),
                      //             borderRadius: BorderRadius.circular(0.r),
                      //           ),
                      //           child: Row(
                      //             children: [
                      //               Container(
                      //                 width: 110,
                      //                 height: 110,
                      //                 child: CachedNetworkImage(
                      //                   imageUrl: logic.newRelease.value[index]['image_url'],
                      //
                      //
                      //                   // imageUrl: (productDetail?.images ?? []).isNotEmpty
                      //                   //     ? productDetail!.images[0].originalSrc
                      //                   //     : "",
                      //                   fit: BoxFit.cover,
                      //                   height: double.infinity,
                      //                   width: double.infinity,
                      //                   placeholder: (context, url) =>
                      //                       productShimmer(),
                      //                   errorWidget: (context, url, error) =>
                      //                   const Icon(Icons.error),
                      //                 ),
                      //               ),
                      //               pageMarginHorizontal.widthBox,
                      //               Column(
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 mainAxisAlignment: MainAxisAlignment.center,
                      //                 children: [
                      //                   // 6.heightBox,
                      //                   Container(
                      //                     width: 250.w,
                      //                     child: Text(
                      //                       "${logic.newRelease.value[index]['title']}",
                      //                       maxLines: 2,
                      //                       textAlign: TextAlign.start,
                      //                       style: context.text.titleMedium?.copyWith(
                      //                           color: AppColors.customWhiteTextColor,
                      //                           overflow: TextOverflow.ellipsis,
                      //                           fontSize: 18.sp),
                      //                     ),
                      //                   ),
                      //                   10.heightBox,
                      //                   Text(
                      //                     "${logic.newRelease.value[index]['status']} | ${formattedDate}",
                      //                     maxLines: 2,
                      //                     textAlign: TextAlign.center,
                      //                     style: context.text.titleMedium?.copyWith(
                      //                         color: AppColors.customWhiteTextColor,
                      //                         overflow: TextOverflow.ellipsis,
                      //                         fontSize: 16.sp),
                      //                   ),
                      //
                      //                   // 10.heightBox,
                      //                 ],
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   );

                    }),
                    options: CarouselOptions(
                        autoPlay: logic.featureNews.value.length > 1? true:false,
                        // height: context.deviceHeight / 2,
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        enableInfiniteScroll: true,
                        reverse: false,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, _) {
                          logic.currentImageIndex.value = index;
                        }
                    ),
                  ),
                  Positioned(
                    bottom: pageMarginVertical * 1.2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(logic.featureNews.value.length, (index) =>
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 10.h,
                                width: 10.h,
                                decoration: BoxDecoration(
                                    color: logic.currentImageIndex.value ==
                                        index ? Colors.white : Colors
                                        .transparent,
                                    shape: BoxShape.circle,
                                    border: logic.currentImageIndex.value ==
                                        index ? null : Border.all(
                                        color: Colors.white,
                                        width: 1
                                    )
                                ),
                              ),
                              4.widthBox,
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            );
          }),
          Obx((){
            return SingleChildScrollView(
              child: Column(
                children: List.generate(logic.latestNews.value.length, (index){
                  String dateString = logic.latestNews.value[index]['created_at']; // Assuming this is your date string
                  DateTime dateTime = DateTime.parse(dateString); // Convert the string to a DateTime object
                  String formattedDate = DateFormat('MMM dd yyyy').format(dateTime);
                  return
                    Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.white, width: 1))
                      ),
                      child: GestureDetector(
                        onTap: (){
                          Get.to(NewsContentPageScreen(
                            content: '${logic.latestNews.value[index]['body']}',
                          ), transition: Transition.downToUp,
                              duration: Duration(seconds: 1));
                          // Get.to(WebViewCustom(
                          //   productUrl: '${logic.latestNews.value[index]['view_url']}',
                          //   title: logic.latestNews.value[index]['title'],
                          // ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,),
                          child: Container(
                            height: 150.h,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              // backgroundBlendMode: BlendMode.darken,
                              // color: Colors.black.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(0.r),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 110,
                                  height: 110,
                                  child: CachedNetworkImage(
                                    imageUrl: logic.latestNews.value[index]['image_url'],


                                    // imageUrl: (productDetail?.images ?? []).isNotEmpty
                                    //     ? productDetail!.images[0].originalSrc
                                    //     : "",
                                    fit: BoxFit.cover,
                                    height: double.infinity,
                                    width: double.infinity,
                                    placeholder: (context, url) =>
                                        productShimmer(),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                  ),
                                ),
                                pageMarginHorizontal.widthBox,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // 6.heightBox,
                                    Container(
                                      width: 250.w,
                                      child: Text(
                                        "${logic.latestNews.value[index]['title']}",
                                        maxLines: 2,
                                        textAlign: TextAlign.start,
                                        style: context.text.titleMedium?.copyWith(
                                            color: AppColors.customWhiteTextColor,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 18.sp),
                                      ),
                                    ),
                                    10.heightBox,
                                    Text(
                                      "${logic.latestNews.value[index]['category_name']} | ${formattedDate}",
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: context.text.titleMedium?.copyWith(
                                          color: AppColors.customWhiteTextColor,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 16.sp),
                                    ),

                                    // 10.heightBox,
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );

                }),
              ),
            );
          }),
        ],
      )
    );
  }
}
