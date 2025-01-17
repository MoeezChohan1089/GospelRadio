
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/module/music_play/logic.dart';
import 'package:gosperadioapp/src/utils/constants/colors.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../custom_widgets/webview_custom.dart';
import '../music_catalog/components/music_listCatalog.dart';
import 'logic.dart';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/module/music_play/logic.dart';
import 'package:gosperadioapp/src/utils/constants/colors.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../custom_widgets/webview_custom.dart';
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

class TopSongsScreen extends StatefulWidget {
  TopSongsScreen({super.key});

  @override
  State<TopSongsScreen> createState() => _TopSongsScreenState();
}

class _TopSongsScreenState extends State<TopSongsScreen> {
  final logic = Get.put(Music_radioLogic());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Calculate the current date index
      logic.navigateButtons1();
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
          "Top Songs",
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
            children: List.generate(logic.topSongs.value.length, (index){
              // String dateString = logic.topAlbums.value[index]['created_at']; // Assuming this is your date string
              // DateTime dateTime = DateTime.parse(dateString); // Convert the string to a DateTime object
              // String formattedDate = DateFormat('MMM dd yyyy').format(dateTime);
              return
                index == 0? GestureDetector(
                  onTap: (){
                    // launchURL(
                    //     "${logic.topSongs.value[index]['view_url']}");
                    logic.loadingStreamMusic.value = false;
                    logic.player1.pause();
                    Get.to(() => MusicListCatalogScreen(
                      ID: logic.topSongs.value[index]['album_id'],
                      modelID: logic.topSongs.value[index]['model_id'],
                    ));

                    // Get.to(WebViewCustom(
                    //   productUrl: '${logic.topSongs.value[index]['view_url']}',
                    //   title: logic.topSongs.value[index]['album_title'],
                    // ));
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
                            imageUrl: logic.topSongs.value[index]['album_image'],


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
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              width: double.maxFinite,
                              child: Text(
                                "",
                                textAlign: TextAlign.end,
                                style: context.text.titleMedium?.copyWith(
                                    color: AppColors.customWhiteTextColor,
                                    fontSize: 16.sp),
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
                                      "${logic.topSongs.value[index]['music_title']}",
                                      maxLines: 2,
                                      textAlign: TextAlign.start,
                                      style: context.text.titleMedium?.copyWith(
                                          overflow: TextOverflow.ellipsis,
                                          color: AppColors.customWhiteTextColor,
                                          fontSize: 20.sp),
                                    ),
                                  ),
                                  // 10.heightBox,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 300.sp,
                                        child: Text(
                                          "${logic.topSongs.value[index]['album_title']}",
                                          maxLines: 2,
                                          textAlign: TextAlign.start,
                                          style: context.text.titleMedium?.copyWith(
                                              color: AppColors.customWhiteTextColor,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 18.sp),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                                        // width: double.maxFinite,
                                        child: Text(
                                          "Downloads: ${logic.topSongs.value[index]['count']}",
                                          // textAlign: TextAlign.end,
                                          style: context.text.titleMedium?.copyWith(
                                              color: AppColors.customWhiteTextColor,
                                              fontSize: 16.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                  10.heightBox
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


                    // Container(
                    //   height: 250.h,
                    //   width: double.maxFinite,
                    //   decoration: BoxDecoration(
                    //     // backgroundBlendMode: BlendMode.darken,
                    //     // color: Colors.black.withOpacity(0.8),
                    //     borderRadius: BorderRadius.circular(0.r),
                    //     image: DecorationImage(
                    //       image: NetworkImage(logic.topSongs.value[index]['album_image']),
                    //       fit: BoxFit.cover,
                    //       colorFilter: ColorFilter.mode(
                    //         Colors.white.withOpacity(0.6),
                    //         BlendMode.dstATop,
                    //       ),
                    //     ),
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Container(
                    //         margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    //         width: double.maxFinite,
                    //         child: Text(
                    //           "",
                    //           textAlign: TextAlign.end,
                    //           style: context.text.titleMedium?.copyWith(
                    //               color: AppColors.customWhiteTextColor,
                    //               fontSize: 16.sp),
                    //         ),
                    //       ),
                    //       // 10.heightBox,
                    //       Padding(
                    //         padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal/1.5),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Container(
                    //               child: Text(
                    //                 "${logic.topSongs.value[index]['music_title']}",
                    //                 maxLines: 2,
                    //                 textAlign: TextAlign.start,
                    //                 style: context.text.titleMedium?.copyWith(
                    //                     overflow: TextOverflow.ellipsis,
                    //                     color: AppColors.customWhiteTextColor,
                    //                     fontSize: 16.sp),
                    //               ),
                    //             ),
                    //             // 10.heightBox,
                    //             Container(
                    //               width: double.maxFinite,
                    //               child: Text(
                    //                 "${logic.topSongs.value[index]['album_title']}",
                    //                 maxLines: 2,
                    //                 textAlign: TextAlign.start,
                    //                 style: context.text.titleMedium?.copyWith(
                    //                     color: AppColors.customWhiteTextColor,
                    //                     overflow: TextOverflow.ellipsis,
                    //                     fontSize: 22.sp),
                    //               ),
                    //             ),
                    //             10.heightBox
                    //             // Container(
                    //             //   width: 120,
                    //             //   child: Text(
                    //             //     "${logic.latestNews.value[index]['slug']}",
                    //             //     maxLines: 2,
                    //             //     textAlign: TextAlign.start,
                    //             //     style: context.text.titleMedium?.copyWith(
                    //             //         overflow: TextOverflow.ellipsis,
                    //             //         color: AppColors.customWhiteTextColor,
                    //             //         fontSize: 16.sp),
                    //             //   ),
                    //             // ),
                    //           ],
                    //         ),
                    //       ),
                    //       // 10.heightBox,
                    //     ],
                    //   ),
                    // ),
                  ),
                ):Container(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.white, width: 1))
                  ),
                  child: GestureDetector(
                    onTap: (){
                      // launchURL(
                      //     "${logic.topSongs.value[index]['view_url']}");
                      logic.loadingStreamMusic.value = false;
                      logic.player1.pause();
                      Get.to(() => MusicListCatalogScreen(
                        ID: logic.topSongs.value[index]['album_id'],
                        modelID: logic.topSongs.value[index]['model_id'],
                      ));

                      // Get.to(WebViewCustom(
                      //   productUrl: '${logic.topSongs.value[index]['view_url']}',
                      //   title: logic.topSongs.value[index]['album_title'],
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
                                imageUrl: logic.topSongs.value[index]['album_image'],


                                // imageUrl: (productDetail?.images ?? []).isNotEmpty
                                //     ? productDetail!.images[0].originalSrc
                                //     : "",
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
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
                                    "${logic.topSongs.value[index]['album_title']}",
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
                                    "${logic.topSongs.value[index]['music_title']}",
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
                                  child: Text(
                                    "Downloads: ${logic.topSongs.value[index]['count']}",
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    style: context.text.titleMedium?.copyWith(
                                        overflow: TextOverflow.ellipsis,
                                        color: AppColors.customWhiteTextColor,
                                        fontSize: 16.sp),
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

            }),
          ),
        );
      }),
    );
  }
}



//
// class TopSongsScreen extends StatefulWidget {
//   TopSongsScreen({super.key});
//
//   @override
//   State<TopSongsScreen> createState() => _TopSongsScreenState();
// }
//
// class _TopSongsScreenState extends State<TopSongsScreen> {
//   final logic = Get.put(Music_radioLogic());
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // Calculate the current date index
//       logic.navigateButtons1();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.custombackgroundColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.custombackgroundColor,
//         scrolledUnderElevation: 0,
//         centerTitle: true,
//         title: Text(
//           "Top Songs",
//           style: context.text.bodySmall?.copyWith(
//               color: AppColors.customWhiteTextColor, fontSize: 14.sp),
//         ),
//         leading: IconButton(
//             onPressed: () {
//               Get.back();
//               // if(bottomNav.isFancyDrawer.isTrue){
//               //   bottomNav.advancedDrawerController.showDrawer();
//               // } else {
//               //   bottomNav.navScaffoldKey.currentState?.openDrawer();
//               // }
//             },
//             icon: Icon(Icons.arrow_back, color: AppColors.customBlackTextColor,)
//         ),
//       ),
//       body: Obx((){
//         return logic.isLoadingAlbums.value == true? Center(child: CircularProgressIndicator(color: Colors.white,),): SingleChildScrollView(
//           child: Column(
//             children: List.generate(logic.topSongs.value.length, (index){
//               return
//                 GestureDetector(
//                   onTap: (){
//                     Get.to(WebViewCustom(
//                       productUrl: '${logic.topSongs.value[index]['view_url']}',
//                       title: logic.topSongs.value[index]['album_title'],
//                     ));
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Container(
//                       height: 100.h,
//                       width: double.maxFinite,
//                       decoration: BoxDecoration(
//                         // backgroundBlendMode: BlendMode.darken,
//                         // color: Colors.black.withOpacity(0.8),
//                         borderRadius: BorderRadius.circular(10.r),
//                         image: DecorationImage(
//                           image: NetworkImage(logic.topSongs.value[index]['album_image']),
//                           fit: BoxFit.cover,
//                           colorFilter: ColorFilter.mode(
//                             Colors.white.withOpacity(0.6),
//                             BlendMode.dstATop,
//                           ),
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "${logic.topSongs.value[index]['album_title']}",
//                             textAlign: TextAlign.center,
//                             style: context.text.titleMedium?.copyWith(
//                                 color: AppColors.customWhiteTextColor,
//                                 fontSize: 24.sp),
//                           ),
//                           Text(
//                             "${logic.topSongs.value[index]['music_title']}",
//                             textAlign: TextAlign.center,
//                             style: context.text.titleMedium?.copyWith(
//                                 color: AppColors.customWhiteTextColor,
//                                 fontSize: 18.sp),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//             }),
//           ),
//         );
//       }),
//     );
//   }
// }
