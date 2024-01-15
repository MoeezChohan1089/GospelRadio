
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/constants/colors.dart';
import 'package:gosperadioapp/src/utils/constants/margins_spacnings.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:intl/intl.dart';

import '../../utils/skeleton_loaders/shimmerLoader.dart';

class NewsContentPageScreen extends StatefulWidget {
  final String imgSrc;
  final String date;
  final String heading;
  final String content;
  const NewsContentPageScreen({super.key, required this.content, required this.imgSrc, required this.heading, required this.date});

  @override
  State<NewsContentPageScreen> createState() => _NewsContentPageScreenState();
}

class _NewsContentPageScreenState extends State<NewsContentPageScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(widget.date); // Convert the string to a DateTime object
    String formattedDate = DateFormat('MMM dd yyyy').format(dateTime);


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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300.h,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.imgSrc,


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
                  Positioned.fill(
                    child: Column(
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
                        Container(
                          margin: EdgeInsets.symmetric(vertical: pageMarginVertical, horizontal: pageMarginHorizontal),
                        // width: 250.w,
                        child: Text(
                          widget.heading,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          style: context.text.titleMedium?.copyWith(
                              color: AppColors.customWhiteTextColor,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 18.sp),
                        ),
                  ),
                      ],
                    ),)
                ],
              ),
            ),
            Html(
              data: widget.content,
                style: {
                  // tables will have the below background color
                  "p": Style(
                    color: Colors.white,
                  ),
                }
            ),
          ],
        ),
      ),
    );
  }
}
