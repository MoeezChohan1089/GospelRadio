import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/constants/colors.dart';
import 'package:gosperadioapp/src/utils/constants/margins_spacnings.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../utils/skeleton_loaders/shimmerLoader.dart';
import 'logic.dart';
import 'view_2.dart';

class DownloadsAlbumPage extends StatefulWidget {
  DownloadsAlbumPage({Key? key}) : super(key: key);

  @override
  State<DownloadsAlbumPage> createState() => _DownloadsAlbumPageState();
}

class _DownloadsAlbumPageState extends State<DownloadsAlbumPage> {
  final logic = Get.put(DownloadsAlbumLogic());

  final state = Get
      .find<DownloadsAlbumLogic>()
      .state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      logic.downloadShowSong(context);
    });
  }


  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: AppColors.custombackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.custombackgroundColor,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            "Downloads Album",
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
              icon: Icon(
                Icons.arrow_back, color: AppColors.customBlackTextColor,)
          ),
        ),
        body: Obx(() {
          return Column(
            children: List.generate(
                logic.downloadAlbumsShow.value.length, (index) {
              return logic.downloadAlbumsShow.value.isNotEmpty ? GestureDetector(
                onTap: (){
                  Get.to(() => DownloadSongs(
                    id: logic.downloadAlbumsShow.value[index]['item']['id'],
                  ));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal,
                      vertical: pageMarginVertical / 2),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.customWebsiteListColor,
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: SizedBox(
                            width: 77,
                            height: 77,
                            child: CachedNetworkImage(
                              imageUrl: logic.downloadAlbumsShow.value[index]['item']['image_url'],


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
                        ),
                        20.widthBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                 width: 150.w,
                                child: Text("${logic.downloadAlbumsShow.value[index]['item']['title']}",
                                  style: context.text.bodyMedium?.copyWith(
                                      overflow: TextOverflow.ellipsis,
                                      color: AppColors.customWhiteTextColor,
                                      fontSize: 18.sp),)),
                            10.heightBox,
                            Container(
                                width: 200.w,
                                child: Text("${logic.downloadAlbumsShow.value[index]['item']['artist_name']}",
                                  style: context.text.bodyMedium?.copyWith(
                                      overflow: TextOverflow.ellipsis,
                                      color: AppColors.customWhiteTextColor,
                                      fontSize: 15.sp),))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ) : Center(child: Text("Data Not Available",
                style: context.text.bodyMedium?.copyWith(
                    color: AppColors.customWhiteTextColor, fontSize: 16.sp),),);
            }),
          );
        }),
      );
  }
}
