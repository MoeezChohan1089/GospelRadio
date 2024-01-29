// ignore_for_file: invalid_use_of_protected_member

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/module/music_catalog/logic.dart';
import 'package:gosperadioapp/src/utils/constants/colors.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../../utils/constants/assets.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../../home/logic.dart';
import 'music_listCatalog.dart';

class GridViewScreen extends StatelessWidget {
  GridViewScreen({Key? key}) : super(key: key);

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

  final logic = Get.find<HomeLogic>();
  final logic1 = Get.find<Music_catalogLogic>();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        // shrinkWrap: true,
        padding: EdgeInsets.only(
          right: pageMarginHorizontal / 4,
          left: pageMarginHorizontal / 4,
          // vertical: pageMarginVertical * 1.5,
        ),
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: logic.albumsList.value.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.70,
          crossAxisSpacing: 0.4.w,
          mainAxisSpacing: 0.8.h,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => MusicListCatalogScreen(
                    ID: logic.albumsList.value[index]['id'],
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
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: SizedBox(
                      height: 150.h,
                      width: 180.w,
                      child: CachedNetworkImage(
                        imageUrl: logic.albumsList.value[index]['image_url'],

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
                  logic.albumsList.value[index]['title'],
                  textAlign: TextAlign.center,
                  style: context.text.bodySmall?.copyWith(
                      color: AppColors.customWhiteTextColor, fontSize: 14.sp),
                ),
                3.heightBox,
                Text(
                  logic.albumsList.value[index]['artist_name'],
                  textAlign: TextAlign.center,
                  style: context.text.titleMedium?.copyWith(
                      color: AppColors.customPinkColor, fontSize: 16.sp),
                ),
                10.heightBox,
              ],
            ),
          );
        });
    // GridView.builder(
    //   itemCount: 8,
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 2,
    //     childAspectRatio: 1,
    //   ),
    //   itemBuilder: (context, index){
    //     return Container(
    //       //width: MediaQuery.of(context).size.width * 0.45,
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(8),
    //       ),
    //       child: Padding(
    //         padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.max,
    //           children: [
    //             Row(
    //               mainAxisSize: MainAxisSize.max,
    //               children: [
    //                 Expanded(
    //                   child: ClipRRect(
    //                     borderRadius: BorderRadius.only(
    //                       bottomLeft: Radius.circular(0),
    //                       bottomRight: Radius.circular(0),
    //                       topLeft: Radius.circular(8),
    //                       topRight: Radius.circular(8),
    //                     ),
    //                     child: Image.asset(Assets.images.musicCatalogImage)
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             Padding(
    //               padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
    //               child: Row(
    //                 mainAxisSize: MainAxisSize.max,
    //                 children: [
    //                   Padding(
    //                     padding: EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
    //                     child: Text(
    //                       'ffffffff',
    //                       style: context.text.titleMedium?.copyWith(color: AppColors.customWhiteTextColor),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Padding(
    //               padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
    //               child: Row(
    //                 mainAxisSize: MainAxisSize.max,
    //                 children: [
    //                   Padding(
    //                     padding: EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
    //                     child: Text(
    //                       'ffffffff',
    //                       style: context.text.titleMedium?.copyWith(color: AppColors.customWhiteTextColor),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   }
    // );
  }
}
