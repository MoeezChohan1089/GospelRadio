
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/module/purchase/logic.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../../music_catalog/logic.dart';

class LoveGiftInformationScreen extends StatefulWidget {
  int? ID;
  LoveGiftInformationScreen({Key? key, this.ID}) : super(key: key);

  @override
  State<LoveGiftInformationScreen> createState() => _LoveGiftInformationScreenState();
}

class _LoveGiftInformationScreenState extends State<LoveGiftInformationScreen> {
  final logic1 = Get.put(Music_catalogLogic());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      logic1.getCatalogMusicAlbum(context, widget.ID!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        10.heightBox,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: CachedNetworkImage(
                imageUrl: logic1.responseDataMusicList['data']
                ['album']['image_url'],

                // imageUrl: (productDetail?.images ?? []).isNotEmpty
                //     ? productDetail!.images[0].originalSrc
                //     : "",
                fit: BoxFit.cover,
                height: 174,
                width: double.infinity,
                placeholder: (context, url) => productShimmer(),
                errorWidget: (context, url, error) =>
                const Icon(Icons.error),
              ),),
        ),
        14.heightBox,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal+10),
          child: Text(
              logic1.responseDataMusicList['data']['album']
              ['title'],
            style: context.text.bodySmall?.copyWith(
                color: AppColors.customPinkColor, fontSize: 18.sp),
          ),
        ),
        6.heightBox,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal+10),
          child: Text(
            logic1.responseDataMusicList['data']['album']
            ['artist_name'],
            style: context.text.bodySmall?.copyWith(
                color: AppColors.customWhiteTextColor, fontSize: 16.sp),
          ),
        ),
        6.heightBox,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal+10),
          child: Text(
            'This is the first Born to Worship CD that is for a',
            style: context.text.bodySmall?.copyWith(
                color: AppColors.customWhiteTextColor, fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
