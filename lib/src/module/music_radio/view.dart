import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/module/play_history/logic.dart';
import 'package:gosperadioapp/src/utils/constants/margins_spacnings.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:lottie/lottie.dart';

import '../../utils/constants/colors.dart';
import '../../utils/skeleton_loaders/shimmerLoader.dart';
import 'logic.dart';

class Music_radioPage extends StatefulWidget {
  Music_radioPage({Key? key}) : super(key: key);

  @override
  State<Music_radioPage> createState() => _Music_radioPageState();
}

class _Music_radioPageState extends State<Music_radioPage> {
  final logic = Get.put(Music_radioLogic());
  bool manuallyStopped = false;
  final state = Get
      .find<Music_radioLogic>()
      .state;

  final logic1 = Get.put(PlayHistoryLogic());

  List imageSlider = ['assets/images/HgcBanner.jpeg', 'assets/images/hgctt.png'];
  AudioPlayer player1 = AudioPlayer();
  PlayerState? _state;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player1.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.STOPPED && !manuallyStopped) {
        setState(() {
          logic.loadingStreamMusic.value = false;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Detect when the music screen is re-entered and stop the audio playback.
    if (ModalRoute.of(context)?.isCurrent == true && logic.loadingStreamMusic.value) {
      // Check the flag to determine if the music was manually stopped
      if (!manuallyStopped) {
        player1.resume();
        setState(() {
          logic.loadingStreamMusic.value = false;
        });
      }
    }
  }

  initializedB() async{
    await player1.setUrl('https://my.hgcradio.org:8000/radio.mp3');
  }

  @override
  void dispose() {
    player1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.custombackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.custombackgroundColor,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            "Playing/History",
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
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         // Get.to(() => CartPage());
          //       },
          //       icon: Icon(Icons.search, color: AppColors.customBlackTextColor,)
          //   ),
          // ],
        ),
        body: Obx(() {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "now on air".toUpperCase(),
                    style: context.text.bodyMedium?.copyWith(
                        color: AppColors.customWhiteTextColor, fontSize: 18.sp),
                  ),
                  70.heightBox,
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(100.r),
                      //   child: CachedNetworkImage(
                      //     imageUrl: logic1.hostImage != null ? logic1
                      //         .hostImage ?? '' : '',
                      //     height: 200.h,
                      //     // imageUrl: (productDetail?.images ?? []).isNotEmpty
                      //     //     ? productDetail!.images[0].originalSrc
                      //     //     : "",
                      //     fit: BoxFit.cover,
                      //     color: Colors.black.withOpacity(0.3),
                      //     colorBlendMode: BlendMode.darken,
                      //     placeholder: (context, url) =>
                      //         productShimmer(),
                      //     errorWidget: (context, url, error) =>
                      //     const Icon(Icons.error),
                      //   ),
                      // ),
                      Container(
                        width: 150,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            opacity: 0.6,
                            image: NetworkImage(logic1.hostImage != null ? logic1
                                .hostImage ?? '' : '',
                            ),
                            fit: BoxFit.cover,
                          )
                        ),
                        child: GestureDetector(
                          onTap: (){
                            if(logic.loadingStreamMusic.value == true){
                              player1.pause();
                              logic.loadingStreamMusic.value = false;
                            }else{
                              player1.play('https://my.hgcradio.org:8000/radio.mp3');
                              logic.loadingStreamMusic.value = true;
                            }
                          },
                          child: Icon(
                            logic.loadingStreamMusic.value? Icons.pause: Icons.play_arrow, color: AppColors.customWhiteTextColor, size: 100,),
                        ),
                      )
                    ],
                  ),
                  30.heightBox,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
                    child: Text(
                      logic1.dataPlayNow.value != null? " ${logic1.dataPlayNow
                .value['text'] ?? ''}'": "",
                      textAlign: TextAlign.center,
                      style: context.text.bodyMedium?.copyWith(
                          color: AppColors.customWhiteTextColor, fontSize: 20.sp),
                    ),
                  ),
                  10.heightBox,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
                    child: Text(
                      logic1.dataPlayNow.value != null? " ${logic1.dataPlayNow
                          .value['artist'] ?? ''}": "",
                      textAlign: TextAlign.center,
                      style: context.text.bodyMedium?.copyWith(
                          color: AppColors.customPinkColor, fontSize: 18.sp),
                    ),
                  ),
                  20.heightBox,
                  Lottie.asset('assets/images/wave.json', width: 80.w, height: 80.h),
                  15.heightBox,
                  CarouselSlider(

                    items: List.generate(
                        imageSlider.length,
                            (index) {
                          return Stack(
                            children: [

                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  imageSlider[index], width: 300, fit: BoxFit.cover,),
                              ),

                              // Image.network(
                              //   indexData["path"] ?? productInfo.image,
                              //   width: double.maxFinite,
                              //   fit: BoxFit.cover,
                              // ),
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
                ],
              ),
            ),
          );
        })
    );
  }
}
