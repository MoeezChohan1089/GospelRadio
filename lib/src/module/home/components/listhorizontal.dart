import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/constants/colors.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../../music_catalog/components/music_listCatalog.dart';
import '../../music_catalog/logic.dart';
import '../../music_catalog/view.dart';
import '../logic.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ListHorizontalScreen extends StatefulWidget {
  const ListHorizontalScreen({Key? key}) : super(key: key);

  @override
  State<ListHorizontalScreen> createState() => _ListHorizontalScreenState();
}

class _ListHorizontalScreenState extends State<ListHorizontalScreen> {
  List imageList = [
    'assets/images/horiRectangle.png',
    'assets/images/horiRectangle1.png',
    'assets/images/horiRectangle2.png',
    'assets/images/horiRectangle1.png'
  ];

  final logic = Get.find<HomeLogic>();
  final logic1 = Get.put(Music_catalogLogic());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: pageMarginHorizontal, vertical: pageMarginVertical),
          child: Row(
            children: [
              Text(
                "Catalog Album",
                style: context.text.titleMedium?.copyWith(
                    color: AppColors.customWhiteTextColor, fontSize: 18.sp),
              ),
              Spacer(),
              // InkWell(
              //   onTap: () {
              //     Get.to(() => MusicCatalogPage());
              //   },
              //   child: Text(
              //     "See All",
              //     style: context.text.titleMedium?.copyWith(
              //         color: AppColors.customPinkColor, fontSize: 14.sp),
              //   ),
              // )
            ],
          ),
        ),
        Obx(() {
          return logic.filteredAlbums.value.isEmpty
              ? Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            children: List.generate(
              logic.albumsList.value.length > 9? 9: logic.albumsList.value.length, (index) {
              return GestureDetector(
                onTap: () async {
                  print("ffffdddddd: ${logic.albumsList.value[index]['id']}");
                  Get.to(() => MusicListCatalogScreen(
                    ID: logic.albumsList.value[index]['id'],
                  ));
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: SizedBox(
                    height: 110.h,
                    width: 110.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: CachedNetworkImage(
                        imageUrl: logic.albumsList.value[index]['image_url'],
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                        placeholder: (context, url) => productShimmer(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              );
            },
            )..add(
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.to(() => MusicCatalogPage());
                    // Handle "Load More" button click here
                    // You can add more items to the list or implement your logic
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 24, right: 16, top: 20),
                    child: Container(
                      margin: EdgeInsets.only(right: pageMarginHorizontal/1.5),
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(10.r)
                      ),
                      height: 40.h,
                      width: 90.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Load More',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp
                              // Customize the style of the "Load More" text
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )

              : Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            children: List.generate(
              logic.filteredAlbums.value.length > 6? 6: logic.filteredAlbums.value.length, (index) {
              return GestureDetector(
                onTap: () async {
                  print("ffffdddddd: ${logic.filteredAlbums.value[index]['id']}");
                  Get.to(() => MusicListCatalogScreen(
                    ID: logic.filteredAlbums.value[index]['id'],
                  ));
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: SizedBox(
                    height: 110.h,
                    width: 110.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: CachedNetworkImage(
                        imageUrl: logic.filteredAlbums.value[index]['image_url'],
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                        placeholder: (context, url) => productShimmer(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              );
            },
            )..add(
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Get.to(() => MusicCatalogPage());
                  // Handle "Load More" button click here
                  // You can add more items to the list or implement your logic
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Container(
                    // color: Colors.yellow,
                    height: 50.h,
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Load More',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp
                            // Customize the style of the "Load More" text
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
