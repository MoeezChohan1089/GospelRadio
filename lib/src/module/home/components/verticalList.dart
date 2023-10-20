import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/module/gospel_website/components/videos.dart';
import 'package:gosperadioapp/src/module/home/logic.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../../music_catalog/logic.dart';
import '../../music_play/view.dart';
import '../../music_play/view_demo.dart';

class ListVerticalScreen extends StatefulWidget {
  ListVerticalScreen({Key? key}) : super(key: key);

  @override
  State<ListVerticalScreen> createState() => _ListVerticalScreenState();
}

class _ListVerticalScreenState extends State<ListVerticalScreen> {
  final logic = Get.find<HomeLogic>();
  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    player = AudioPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: pageMarginHorizontal, vertical: pageMarginVertical),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: pageMarginVertical / 2),
                child: Row(
                  children: [
                    Text("Next Playing",
                      style: context.text.titleMedium?.copyWith(
                          color: AppColors.customWhiteTextColor,
                          fontSize: 18.sp),),
                  ],
                ),
              ),
              10.heightBox,
              logic.loadingCatalog.value == true
                  ? ShimerListviewPage()
                  : SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Column(
                    children: List.generate(
                        logic.albumsListMusicConstant.length > 6 ? 6 : logic
                            .albumsListMusicConstant.length, (index) {
                      return
                        InkWell(
                          onTap: () async{
                            // logic2.getMusicPlaySong(context, logic.albumsListMusic[index]['id']);

                            // AudioPlayer player = AudioPlayer();
                            // // Preload the audio sample URL
                            // await player.setUrl(logic.albumsListMusicConstant.value[index]['sample_url']);
                            //
                            // // Navigate to the music play screen
                            // Get.to(() => MusicPlayPage(
                            //   name: logic.albumsListMusicConstant.value[index]['title'],
                            //   albumName: logic.albumsListMusicConstant.value[index]['artist_name'],
                            //   musicUrl: logic.albumsListMusicConstant.value[index]['sample_url'],
                            // ));

                            Get.to(() => MusicDemo(
                              name: logic.albumsListMusicConstant.value[index]['title'],
                              artistName: logic.albumsListMusicConstant.value[index]['artist_name'],
                              albumName: logic.albumsListMusicConstant.value[index]['album_name'],
                              imageSrc: logic
                                  .responseDataMusicListConstant['data']['album']['image_url'],
                              musicUrl: logic.albumsListMusicConstant.value[index]['sample_url'],
                              duration: logic.albumsListMusicConstant.value[index]['duration'],
                            ));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: pageMarginVertical / 2),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: pageMarginHorizontal / 2,
                                  vertical: pageMarginVertical / 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.customGradientFirstColor,
                                    AppColors.customGradientSecondColor
                                  ],
                                ),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 77,
                                    height: 60,
                                    child: CachedNetworkImage(
                                      imageUrl: logic
                                          .responseDataMusicListConstant['data']['album']['image_url'],


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
                                  // Image.network(
                                  //   logic1
                                  //       .responseDataMusicList['data']['album']['image_url'], width: 77,
                                  //   height: 60, fit: BoxFit.cover,),
                                  10.widthBox,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment
                                        .start,
                                    children: [
                                      Text(logic
                                          .albumsListMusicConstant[index]['title'],
                                          style: context.text.titleMedium
                                              ?.copyWith(
                                              color: AppColors
                                                  .customMusicTextColor,
                                              fontSize: 16.sp)),
                                      6.heightBox,
                                      Container(width: 190,
                                          child: Text(
                                              logic
                                                  .albumsListMusicConstant[index]['artist_name'],
                                              style: context.text.titleMedium
                                                  ?.copyWith(color: AppColors
                                                  .customMusicTextDescriptionColor,
                                                  fontSize: 12.sp)))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                    }),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Advertise us",
                        style: context.text.titleMedium?.copyWith(
                            color: AppColors.customWhiteTextColor,
                            fontSize: 18.sp),
                      ),
                      Container(
                          height: 100,
                          child: HorizontalVideoList1()),
                    ],
                  )),
            ],
          ),
        ),
      );
    });
  }
}
