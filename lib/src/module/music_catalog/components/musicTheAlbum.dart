// ignore_for_file: invalid_use_of_protected_member

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/module/music_play/view_demo.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../../music_play/view.dart';
import '../logic.dart';

class MusicTheAlbumSection extends StatefulWidget {
  final int? modelID;
  MusicTheAlbumSection({Key? key, this.modelID}) : super(key: key);

  @override
  State<MusicTheAlbumSection> createState() => _MusicTheAlbumSectionState();
}

class _MusicTheAlbumSectionState extends State<MusicTheAlbumSection> {
  final logic1 = Get.find<Music_catalogLogic>();
  AudioPlayer  player = AudioPlayer();

  @override
  void initState() {

    super.initState();
  }

  // final logic2 = Get.find<MusicPlayLogic>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Music_catalogLogic>(builder: (logic) {
      return Container(
        height: 600.h,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: pageMarginHorizontal, vertical: pageMarginVertical),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Container(
              child: Column(
                children: List.generate(logic.albumsListMusic.length, (index) {
                  player.setUrl(logic.albumsListMusic.value[index]
                  ['sample_url']);

                  Future.delayed(Duration(seconds: 1),(){
                    if (widget.modelID != null &&
                        widget.modelID == logic.albumsListMusic.value[index]['id']) {
                      // Model ID matches, navigate to the music play screen
                      Get.to(() => MusicDemo(
                        name: logic.albumsListMusic.value[index]['title'],
                        artistName: logic.albumsListMusic.value[index]['artist_name'],
                        albumName: logic.albumsListMusic.value[index]['album_name'],
                        imageSrc: logic1.responseDataMusicList['data']['album']['image_url'],
                        musicUrl: logic.albumsListMusic.value[index]['sample_url'],
                        duration: logic.albumsListMusic.value[index]['duration'],
                      ));
                    }
                  });
                  return InkWell(
                    onTap: () {
                      // logic2.getMusicPlaySong(context, logic.albumsListMusic[index]['id']);

                      // Get.to(() => MusicPlayPage(
                      //       name: logic.albumsListMusic.value[index]['title'],
                      //       albumName: logic.albumsListMusic.value[index]
                      //           ['artist_name'],
                      //       musicUrl: logic.albumsListMusic.value[index]
                      //           ['sample_url'],
                      //     ));

                      Get.to(() => MusicDemo(
                        name: logic.albumsListMusic.value[index]['title'],
                        artistName: logic.albumsListMusic.value[index]['artist_name'],
                        albumName: logic.albumsListMusic.value[index]['album_name'],
                        imageSrc: logic1.responseDataMusicList['data']
                        ['album']['image_url'],
                        musicUrl: logic.albumsListMusic.value[index]['sample_url'],
                        duration: logic.albumsListMusic.value[index]['duration'],
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
                                imageUrl: logic1.responseDataMusicList['data']
                                    ['album']['image_url'],

                                // imageUrl: (productDetail?.images ?? []).isNotEmpty
                                //     ? productDetail!.images[0].originalSrc
                                //     : "",
                                fit: BoxFit.cover,
                                height: double.infinity,
                                alignment: Alignment.topCenter,
                                width: double.infinity,
                                placeholder: (context, url) => productShimmer(),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 190.w,
                                  child: Text(logic.albumsListMusic[index]['title'],
                                      style: context.text.titleMedium?.copyWith(
                                          overflow: TextOverflow.ellipsis,
                                          color: AppColors.customMusicTextColor,
                                          fontSize: 16.sp)),
                                ),
                                6.heightBox,
                                Container(
                                    width: 190.w,
                                    child: Text(
                                        logic.albumsListMusic[index]
                                            ['artist_name'],
                                        style: context.text.titleMedium?.copyWith(
                                          overflow: TextOverflow.ellipsis,
                                            color: AppColors
                                                .customMusicTextDescriptionColor,
                                            fontSize: 12.sp)))
                              ],
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: AppColors.customPinkColor,
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.play_arrow,
                                size: 20,
                                color: Colors.white,
                              ),
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
        ),
      );
    });
  }
}
