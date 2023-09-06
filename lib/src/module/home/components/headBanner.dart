import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/module/home/logic.dart';
import 'package:gosperadioapp/src/utils/constants/colors.dart';
import 'package:gosperadioapp/src/utils/constants/margins_spacnings.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../../utils/constants/assets.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';

class BannerSection extends StatelessWidget {
  BannerSection({Key? key}) : super(key: key);

  List imagesList = [
    {'image': 'assets/images/radio-main-banner.jpeg',
      'name': 'Gospel Radio',
      'description': 'Hallelujah Gospel Globally Choice Radio'},
    {'image': 'assets/images/Microphone-background-sound-waves-energy-Music.webp',
      'name': 'Gospel Radio',
      'description': 'Hallelujah Gospel Worldwide Search Radio'},
    {'image': 'assets/images/imageDemo.jpeg',
      'name': 'Gospel Radio',
      'description': 'Hallelujah Gospel serves its listeners 7 styles.'},
  ];

  final logic = Get.put(HomeLogic());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(
            vertical: 10),
        child: SizedBox(
          height: 180,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider(

                items: List.generate(
                    imagesList.length,
                        (index) {
                      return Stack(
                        children: [

                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              imagesList[index]['image'], width: double.maxFinite, fit: BoxFit.cover,),
                          ),

                          // Image.network(
                          //   indexData["path"] ?? productInfo.image,
                          //   width: double.maxFinite,
                          //   fit: BoxFit.cover,
                          // ),
                          Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                color: Colors.black.withOpacity(0.4),
                                height: double.maxFinite,
                                width: double.maxFinite,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .center,
                                  mainAxisAlignment: MainAxisAlignment
                                      .center,
                                  children: [
                                    Text(imagesList[index]['name'],
                                      style: context.text.titleMedium?.copyWith(
                                          color: AppColors.customWhiteTextColor,
                                          fontSize: 24.sp),),
                                    10.heightBox,
                                    Text(imagesList[index]['description'],
                                      style: context.text.titleMedium?.copyWith(
                                          color: AppColors.customWhiteTextColor,
                                          fontSize: 18.sp),),
                                  ],
                                ),
                              )),
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
                    height: context.deviceHeight / 2,
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
                  children: List.generate(imagesList
                      .length, (index) =>
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
        ),
      );
    });
    //   Stack(
    //   children: [
    //     Container(
    //       // color: Colors.yellow,
    //       width: double.maxFinite,
    //       child: SvgPicture.asset(
    //         Assets.icons.bannerIcon,
    //         height: 100,
    //       ),
    //     ),
    //     Positioned(
    //       top: 10,
    //         left: 10,
    //         right: 10,
    //         child: Text("Beauty is the purest \nFeeling of the Soul.", style: context.text.titleMedium?.copyWith(color: AppColors.customWhiteTextColor, fontSize: 14.sp),))
    //   ],
    // );
  }
}
