import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/constants/colors.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../../utils/constants/assets.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../engineersDetails/details.dart';
import '../logic.dart';

class GridViewScreenEnginners extends StatefulWidget {
  GridViewScreenEnginners({Key? key}) : super(key: key);

  @override
  State<GridViewScreenEnginners> createState() =>
      _GridViewScreenEnginnersState();
}

class _GridViewScreenEnginnersState extends State<GridViewScreenEnginners> {
  final logic = Get.put(EngineersLogic());

  final List<String> imageUrls = [
    Assets.images.musicCatalogImage,
    Assets.images.musicCatalogImage1,
    Assets.images.musicCatalogImage2,
    Assets.images.musicCatalogImage,
    Assets.images.musicCatalogImage1,
    Assets.images.musicCatalogImage2,
    Assets.images.musicCatalogImage,
    Assets.images.musicCatalogImage1,
    // Add more image URLs here
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      logic.getAllEngineers(context);
    });
    super.initState();
  }

  // final logic1 = Get.find<Music_catalogLogic>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return logic.filteredEngineer.value.isEmpty
          ? GridView.builder(
              // shrinkWrap: true,
              padding: EdgeInsets.only(
                right: pageMarginHorizontal / 2,
                left: pageMarginHorizontal / 2,
                // vertical: pageMarginVertical * 1.5,
              ),
              // physics: const NeverScrollableScrollPhysics(),
              itemCount: logic.albumsList.value.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.70,
                // crossAxisSpacing: 0.4.w,
                // mainAxisSpacing: 0.8.h,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => EngineerDetails(
                          ID: logic.albumsList.value[index]['id'],
                          avatar: logic.albumsList.value[index]['avatar_url'],
                          name: logic.albumsList.value[index]['name'],
                          email: logic.albumsList.value[index]['email'],
                          slug: logic.albumsList.value[index]['slug'],
                          about: logic.albumsList.value[index]['about'],
                        ));
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             ProductDetailPage(
                    //               productId: valueLoader
                    //                   .productsFetch[index].id.split(
                    //                   "Product/")[1],
                    //             )));
                  },
                  child: Column(
                    children: [
                      Expanded(
                        // height: double.infinity,
                        // width: double.infinity,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          child: SizedBox(
                            height: 100.h,
                            width: 170.w,
                            child: CachedNetworkImage(
                              imageUrl: logic.albumsList.value[index]
                                  ['avatar_url'],

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
                      6.heightBox,
                      Text(
                        logic.albumsList.value[index]['name'],
                        style: context.text.bodySmall?.copyWith(
                            color: AppColors.customWhiteTextColor,
                            fontSize: 14.sp),
                      ),
                      3.heightBox,
                      // Text(
                      //   logic.albumsList.value[index]['email'],
                      //   style: context.text.titleMedium?.copyWith(
                      //       color: AppColors.customPinkColor, fontSize: 16.sp),
                      // ),
                      3.heightBox,
                      // Container(
                      //   width: 100,
                      //   child: Text(
                      //     logic.albumsList.value[index]['about'] ?? '',
                      //     maxLines: 1,
                      //     style: context.text.titleMedium?.copyWith(
                      //       overflow: TextOverflow.ellipsis,
                      //         color: AppColors.customWhiteTextColor, fontSize: 14.sp),
                      //   ),
                      // ),
                      // 8.heightBox,
                      GestureDetector(
                        onTap: () {
                          Get.to(() => EngineerDetails(
                                ID: logic.albumsList.value[index]['id'],
                                avatar: logic.albumsList.value[index]
                                    ['avatar_url'],
                                name: logic.albumsList.value[index]['name'],
                                email: logic.albumsList.value[index]['email'],
                                slug: logic.albumsList.value[index]['slug'],
                                about: logic.albumsList.value[index]['about'],
                              ));
                        },
                        child: Container(
                            child: Text(
                          "View Details",
                          style: context.text.bodyMedium
                              ?.copyWith(color: Colors.lightBlue.shade300),
                        )
                            // TextButton(
                            //     onPressed: () {},
                            //     child: Text(
                            //       "View Details",
                            //       style: context.text.bodyMedium
                            //           ?.copyWith(color: Colors.lightBlue.shade300),
                            //     )),
                            ),
                      ),
                      14.heightBox,
                    ],
                  ),
                );
              })
          : GridView.builder(
              // shrinkWrap: true,
              padding: EdgeInsets.only(
                right: pageMarginHorizontal / 2,
                left: pageMarginHorizontal / 2,
                // vertical: pageMarginVertical * 1.5,
              ),
              // physics: const NeverScrollableScrollPhysics(),
              itemCount: logic.filteredEngineer.value.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                // crossAxisSpacing: 0.4.w,
                // mainAxisSpacing: 0.8.h,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => EngineerDetails(
                          ID: logic.filteredEngineer.value[index]['id'],
                          avatar: logic.albumsList.value[index]['avatar_url'],
                          name: logic.albumsList.value[index]['name'],
                          email: logic.albumsList.value[index]['email'],
                          slug: logic.albumsList.value[index]['slug'],
                      about: logic.albumsList.value[index]['about'],
                        ));
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             ProductDetailPage(
                    //               productId: valueLoader
                    //                   .productsFetch[index].id.split(
                    //                   "Product/")[1],
                    //             )));
                  },
                  child: Column(
                    children: [
                      Expanded(
                        // height: double.infinity,
                        // width: double.infinity,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: CachedNetworkImage(
                              imageUrl: logic.filteredEngineer.value[index]
                                  ['avatar_url'],

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
                      6.heightBox,
                      Text(
                        logic.filteredEngineer.value[index]['name'],
                        style: context.text.bodySmall?.copyWith(
                            color: AppColors.customWhiteTextColor,
                            fontSize: 14.sp),
                      ),
                      3.heightBox,
                      Text(
                        logic.filteredEngineer.value[index]['email'],
                        style: context.text.titleMedium?.copyWith(
                            color: AppColors.customPinkColor, fontSize: 16.sp),
                      ),
                      3.heightBox,
                    ],
                  ),
                );
              });
    });
    GridView.builder(
        itemCount: 8,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return Container(
            //width: MediaQuery.of(context).size.width * 0.45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            child:
                                Image.asset(Assets.images.musicCatalogImage)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                          child: Text(
                            'ffffffff',
                            style: context.text.titleMedium?.copyWith(
                                color: AppColors.customWhiteTextColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                          child: Text(
                            'ffffffff',
                            style: context.text.titleMedium?.copyWith(
                                color: AppColors.customWhiteTextColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
