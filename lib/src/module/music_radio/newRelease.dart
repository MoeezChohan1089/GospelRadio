
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/module/music_play/logic.dart';
import 'package:gosperadioapp/src/utils/constants/colors.dart';
import 'package:gosperadioapp/src/utils/constants/margins_spacnings.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../custom_widgets/webview_custom.dart';
import '../music_catalog/components/music_listCatalog.dart';
import 'logic.dart';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/module/music_play/logic.dart';
import 'package:gosperadioapp/src/utils/constants/colors.dart';
import 'package:gosperadioapp/src/utils/constants/margins_spacnings.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:intl/intl.dart';

import '../../custom_widgets/webview_custom.dart';
import '../../utils/skeleton_loaders/shimmerLoader.dart';
import 'logic.dart';

class NewReleaseScreen extends StatefulWidget {
  NewReleaseScreen({super.key});

  @override
  State<NewReleaseScreen> createState() => _NewReleaseScreenState();
}

class _NewReleaseScreenState extends State<NewReleaseScreen> {
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
      logic.navigateButtons2();
    });
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
          "New Release",
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
      body: Obx((){
        return logic.isLoadingAlbums.value == true? Center(child: CircularProgressIndicator(color: Colors.white,),): SingleChildScrollView(
          child: Column(
            children: List.generate(logic.newRelease.value.length, (index){
              String dateString = logic.newRelease.value[index]['created_at']; // Assuming this is your date string
              DateTime dateTime = DateTime.parse(dateString); // Convert the string to a DateTime object
              String formattedDate = DateFormat('MMM dd yyyy').format(dateTime);
              return
               index==0? GestureDetector(
                  onTap: (){
                    // launchURL(
                    //     "${logic.newRelease.value[index]['view_url']}");
                    // Get.to(WebViewCustom(
                    //   productUrl: '${logic.newRelease.value[index]['view_url']}',
                    //   title: logic.newRelease.value[index]['title'],
                    // ));
                    logic.loadingStreamMusic.value = false;
                    logic.player1.pause();
                    Get.to(() => MusicListCatalogScreen(
                      ID: logic.newRelease.value[index]['id'],
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Stack(
                      // alignment: Alignment.bottomLeft,
                      children: [
                        Container(
                          height: 300.h,
                          width: double.maxFinite,
                          child: CachedNetworkImage(
                            imageUrl: logic.newRelease.value[index]['image_url'],


                            // imageUrl: (productDetail?.images ?? []).isNotEmpty
                            //     ? productDetail!.images[0].originalSrc
                            //     : "",
                            fit: BoxFit.cover,
                            height: double.infinity,
                            alignment: Alignment.topCenter,
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    // width: double.maxFinite,
                                    child: Text(
                                      "${logic.newRelease.value[index]['artist_country']}",
                                      // maxLines: 2,
                                      textAlign: TextAlign.start,
                                      style: context.text.titleMedium?.copyWith(
                                          color: AppColors.customWhiteTextColor,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 18.sp),
                                    ),
                                  ),
                                  Container(
                                    // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    // width: double.maxFinite,
                                    child: Text(
                                      "${formattedDate}",
                                      // textAlign: TextAlign.end,
                                      style: context.text.titleMedium?.copyWith(
                                          color: AppColors.customWhiteTextColor,
                                          fontSize: 16.sp),
                                    ),
                                  ),
                                ],
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
                                      "${logic.newRelease.value[index]['artist_name']}",
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
                                      "${logic.newRelease.value[index]['title']}",
                                      maxLines: 2,
                                      textAlign: TextAlign.start,
                                      style: context.text.titleMedium?.copyWith(
                                          color: AppColors.customWhiteTextColor,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 18.sp),
                                    ),
                                  ),
                                  10.heightBox,
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
                ):Container(
                 decoration: BoxDecoration(
                     border: Border(bottom: BorderSide(color: Colors.white, width: 1))
                 ),
                 child: GestureDetector(
                   onTap: (){
                     // launchURL(
                     //     "${logic.topAlbums.value[index]['view_url']}");

                     // Get.to(() => MusicListCatalogScreen(
                     //   ID: logic.topAlbums.value[index]['model_id'],
                     // ));

                     // Get.to(WebViewCustom(
                     //   productUrl: '${logic.newRelease.value[index]['view_url']}',
                     //   title: logic.newRelease.value[index]['title'],
                     // ));
                     logic.loadingStreamMusic.value = false;
                     logic.player1.pause();
                     Get.to(() => MusicListCatalogScreen(
                       ID: logic.newRelease.value[index]['id'],
                     ));
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
                               imageUrl: logic.newRelease.value[index]['image_url'],


                               // imageUrl: (productDetail?.images ?? []).isNotEmpty
                               //     ? productDetail!.images[0].originalSrc
                               //     : "",
                               fit: BoxFit.cover,
                               height: double.infinity,
                               width: double.infinity,
                               alignment: Alignment.topCenter,
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
                                   "${logic.newRelease.value[index]['artist_country']}",
                                   maxLines: 2,
                                   textAlign: TextAlign.start,
                                   style: context.text.titleMedium?.copyWith(
                                       color: AppColors.customWhiteTextColor,
                                       overflow: TextOverflow.ellipsis,
                                       fontSize: 22.sp),
                                 ),
                               ),

                               10.heightBox,
                               Container(
                                 width: 250.w,
                                 child: Text(
                                   "${logic.newRelease.value[index]['artist_name']}",
                                   maxLines: 2,
                                   textAlign: TextAlign.start,
                                   style: context.text.titleMedium?.copyWith(
                                       color: AppColors.customWhiteTextColor,
                                       overflow: TextOverflow.ellipsis,
                                       fontSize: 18.sp),
                                 ),
                               ),
                               10.heightBox,
                               Container(
                                 width: 250.w,
                                 child: Text(
                                   "${logic.newRelease.value[index]['title']}",
                                   maxLines: 2,
                                   textAlign: TextAlign.start,
                                   style: context.text.titleMedium?.copyWith(
                                       color: AppColors.customWhiteTextColor,
                                       overflow: TextOverflow.ellipsis,
                                       fontSize: 18.sp),
                                 ),
                               ),
                             ],
                           ),
                         ],
                       ),
                     ),
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
          )
        );
      }),
    );
  }
}
