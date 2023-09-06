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
              InkWell(
                onTap: () {
                  Get.to(() => MusicCatalogPage());
                },
                child: Text(
                  "See All",
                  style: context.text.titleMedium?.copyWith(
                      color: AppColors.customPinkColor, fontSize: 14.sp),
                ),
              )
            ],
          ),
        ),
        Obx(() {
          return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: logic.filteredAlbums.value.isEmpty
                ? Row(
              children: List.generate(
                  logic.albumsList.value.length > 4
                      ? 4
                      : logic.albumsList.value.length, (index) {
                return GestureDetector(
                  onTap: () async {
                    print("ffffdddddd: ${logic.albumsList.value[index]['id']}");
                    Get.to(() => MusicListCatalogScreen(
                      ID: logic.albumsList.value[index]['id'],
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: CachedNetworkImage(
                          imageUrl: logic.albumsList.value[index]
                          ['image_url'],

                          // imageUrl: (productDetail?.images ?? []).isNotEmpty
                          //     ? productDetail!.images[0].originalSrc
                          //     : "",
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                          placeholder: (context, url) => productShimmer(),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            )
                : Row(
                    children: List.generate(
                        logic.filteredAlbums.value.length > 4 ? 4 : logic.filteredAlbums.value.length, (index) {
                      return GestureDetector(
                        onTap: () async {
                          Get.to(() => MusicListCatalogScreen(
                                ID: logic.filteredAlbums[index]['id'],
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                          ),
                          child: SizedBox(
                            height: 120,
                            width: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: CachedNetworkImage(
                                imageUrl:logic.filteredAlbums.value[index]
                                    ['image_url'],

                                // imageUrl: (productDetail?.images ?? []).isNotEmpty
                                //     ? productDetail!.images[0].originalSrc
                                //     : "",
                                fit: BoxFit.cover,
                                height: double.infinity,
                                width: double.infinity,
                                placeholder: (context, url) => productShimmer(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
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
    );
  }
}
