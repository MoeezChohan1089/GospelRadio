
import 'package:carousel_slider/carousel_slider.dart';
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
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider(

                items: List.generate(logic.newRelease.value.length, (index){
                  String dateString = logic.newRelease.value[index]['created_at']; // Assuming this is your date string
                  DateTime dateTime = DateTime.parse(dateString); // Convert the string to a DateTime object
                  String formattedDate = DateFormat('MMM dd yyyy').format(dateTime);
                  return
                    index == 0? GestureDetector(
                      onTap: (){
                        Get.to(WebViewCustom(
                          productUrl: '${logic.newRelease.value[index]['view_url']}',
                          title: logic.newRelease.value[index]['title'],
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Stack(
                          // alignment: Alignment.bottomLeft,
                          children: [
                            Container(
                              height: 250.h,
                              width: double.maxFinite,
                              child: CachedNetworkImage(
                                imageUrl: logic.newRelease.value[index]['image_url'],


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
                                Container(
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
                      ),
                    ):Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.white, width: 1))
                      ),
                      child: GestureDetector(
                        onTap: (){
                          Get.to(WebViewCustom(
                            productUrl: '${logic.newRelease.value[index]['view_url']}',
                            title: logic.newRelease.value[index]['title'],
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
                                    Text(
                                      "${logic.newRelease.value[index]['status']} | ${formattedDate}",
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
                options: CarouselOptions(
                    autoPlay: logic.newRelease.value.length > 1? true:false,
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
                  children: List.generate(logic.newRelease.value.length, (index) =>
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
      bottomNavigationBar: CarouselSlider(
        items: List.generate(imageSlider.length, (index) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imageSlider[index],
                  width: 300,
                  fit: BoxFit.cover,
                ),
              ),

              // Image.network(
              //   indexData["path"] ?? productInfo.image,
              //   width: double.maxFinite,
              //   fit: BoxFit.cover,
              // ),
            ],
          );
        }

          //         CachedNetworkImage(
          //   imageUrl: (widget.modelProduct.images ?? [])
          //       .isNotEmpty
          //       ? '${widget.modelProduct.images![index].src!.split('?')[0]}?width=400'
          //       : "",
          //   fit: BoxFit.cover,
          //   height: double.infinity,
          //   width: double.infinity,
          //   progressIndicatorBuilder:
          //       (context, url, downloadProgress) =>
          //       CircularProgressIndicator(
          //           value: downloadProgress.progress),
          //   errorWidget: (context, url, error) =>
          //   const Icon(Icons.error),
          // ),
        ),
        options: CarouselOptions(
            autoPlay: true,
            // height: context.deviceHeight / 2,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            enableInfiniteScroll: true,
            reverse: false,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, _) {
              logic.currentImageIndex.value = index;
            }),
      ),
    );
  }
}
