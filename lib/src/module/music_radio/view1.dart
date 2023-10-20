import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/module/play_history/logic.dart';
import 'package:gosperadioapp/src/utils/constants/margins_spacnings.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:lottie/lottie.dart';

import '../../utils/constants/colors.dart';
import '../drawer.dart';
import 'logic.dart';

class Music_radioPage1 extends StatefulWidget {
  Music_radioPage1({Key? key}) : super(key: key);

  @override
  State<Music_radioPage1> createState() => _Music_radioPage1State();
}

class _Music_radioPage1State extends State<Music_radioPage1> {
  final logic = Get.put(Music_radioLogic());
  bool manuallyStopped = false;
  final state = Get.find<Music_radioLogic>().state;

  final logic1 = Get.put(PlayHistoryLogic());

  List imageSlider = [
    'assets/images/HgcBanner.jpeg',
    'assets/images/hgctt.png'
  ];
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
    if (ModalRoute.of(context)?.isCurrent == true &&
        logic.loadingStreamMusic.value) {
      // Check the flag to determine if the music was manually stopped
      if (!manuallyStopped) {
        player1.resume();
        setState(() {
          logic.loadingStreamMusic.value = false;
        });
      }
    }
  }

  initializedB() async {
    await player1.setUrl('https://my.hgcradio.org:8000/radio.mp3');
  }

  void stopSong() {
    if (logic.loadingStreamMusic.value) {
      player1.pause();
      logic.loadingStreamMusic.value = false;
      manuallyStopped = true; // Set the manuallyStopped flag to true
    }
  }

  @override
  void dispose() {
    player1.dispose();
    super.dispose();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.custombackgroundColor,
        key: _scaffoldKey,
        drawer: AppDrawer(),
        appBar: AppBar(
          backgroundColor: AppColors.custombackgroundColor,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            "",
            style: context.text.bodySmall?.copyWith(
                color: AppColors.customWhiteTextColor, fontSize: 14.sp),
          ),
          leading: IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
                // if(bottomNav.isFancyDrawer.isTrue){
                //   bottomNav.advancedDrawerController.showDrawer();
                // } else {
                //   bottomNav.navScaffoldKey.currentState?.openDrawer();
                // }
                Future.delayed(Duration(seconds: 3),(){
                  stopSong();
                });
              },
              icon: Icon(
                Icons.menu,
                color: AppColors.customBlackTextColor,
              )),
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
                  30.heightBox,
                  Text(
                    "now on air".toUpperCase(),
                    style: context.text.bodyMedium?.copyWith(
                        color: AppColors.customWhiteTextColor, fontSize: 18.sp),
                  ),
                  30.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(1, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                width: 100,
                                child: Text("Breaking Gospel Music News", maxLines: 2, style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.brown,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                width: 100,
                                child: Text("New Release Project", maxLines: 2, style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                width: 100,
                                child: Text("Top Songs Listen And Viewed", maxLines: 2, style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                width: 100,
                                child: Text("Latest News and Updates", maxLines: 2, style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          opacity: 0.6,
                          image: NetworkImage(
                            logic1.hostImage != null
                                ? logic1.hostImage ?? ''
                                : '',
                          ),
                          fit: BoxFit.cover,
                        )),
                    child: GestureDetector(
                      onTap: () {
                        if (logic.loadingStreamMusic.value == true) {
                          player1.pause();
                          logic.loadingStreamMusic.value = false;
                        } else {
                          player1.play(
                              'https://my.hgcradio.org:8000/radio.mp3');
                          logic.loadingStreamMusic.value = true;
                        }
                      },
                      child: Icon(
                        logic.loadingStreamMusic.value
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white.withOpacity(0.7),
                        size: 100,
                      ),
                    ),
                  ),
                  30.heightBox,
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
                    child: Text(
                      logic1.dataPlayNow.value != null
                          ? " ${logic1.dataPlayNow.value['text'] ?? ''}'"
                          : "",
                      textAlign: TextAlign.center,
                      style: context.text.bodyMedium?.copyWith(
                          color: AppColors.customWhiteTextColor,
                          fontSize: 20.sp),
                    ),
                  ),
                  10.heightBox,
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
                    child: Text(
                      logic1.dataPlayNow.value != null
                          ? " ${logic1.dataPlayNow.value['artist'] ?? ''}"
                          : "",
                      textAlign: TextAlign.center,
                      style: context.text.bodyMedium?.copyWith(
                          color: AppColors.customPinkColor, fontSize: 18.sp),
                    ),
                  ),
                  20.heightBox,
                  Lottie.asset('assets/images/wave.json',
                      width: 80.w, height: 80.h),
                  15.heightBox,
                  CarouselSlider(
                    items: List.generate(imageSlider.length, (index) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              imageSlider[index],
                              width: 300,
                              fit: BoxFit.cover,
                            ),
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
                        }),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
