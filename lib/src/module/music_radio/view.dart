import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/module/music_radio/latestNews.dart';
import 'package:gosperadioapp/src/module/music_radio/topAlbums.dart';
import 'package:gosperadioapp/src/module/music_radio/topSongs.dart';
import 'package:gosperadioapp/src/module/play_history/logic.dart';
import 'package:gosperadioapp/src/utils/constants/assets.dart';
import 'package:gosperadioapp/src/utils/constants/margins_spacnings.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;
import '../../content.dart';
import '../../utils/constants/colors.dart';
import '../drawer.dart';
import 'logic.dart';
import 'newRelease.dart';

class Music_radioPage extends StatefulWidget {
  Music_radioPage({Key? key}) : super(key: key);

  @override
  State<Music_radioPage> createState() => _Music_radioPageState();
}

class _Music_radioPageState extends State<Music_radioPage> {
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
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        drawer: AppDrawer(),
        // appBar: AppBar(
        //   backgroundColor: AppColors.custombackgroundColor,
        //   scrolledUnderElevation: 0,
        //   centerTitle: true,
        //   title: Text(
        //     "",
        //     style: context.text.bodySmall?.copyWith(
        //         color: AppColors.customWhiteTextColor, fontSize: 14.sp),
        //   ),
        //   leading: IconButton(
        //       onPressed: () {
        //         _scaffoldKey.currentState!.openDrawer();
        //         // if(bottomNav.isFancyDrawer.isTrue){
        //         //   bottomNav.advancedDrawerController.showDrawer();
        //         // } else {
        //         //   bottomNav.navScaffoldKey.currentState?.openDrawer();
        //         // }
        //         Future.delayed(Duration(seconds: 3),(){
        //           stopSong();
        //         });
        //       },
        //       icon: Icon(
        //         Icons.menu,
        //         color: AppColors.customBlackTextColor,
        //       )),
        //   // actions: [
        //   //   IconButton(
        //   //       onPressed: () {
        //   //         // Get.to(() => CartPage());
        //   //       },
        //   //       icon: Icon(Icons.search, color: AppColors.customBlackTextColor,)
        //   //   ),
        //   // ],
        // ),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(Assets.images.backHomeImage, fit: BoxFit.cover, width: double.maxFinite,),
              Container(
                color: Colors.black.withOpacity(0.8),
                child: Obx(() {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: IconButton(
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
                                  ),
                                  Container(
                                    // width: 80,
                                    // // color: Colors.amber,
                                    // height: 80,
                                    // margin: EdgeInsets.only(top: 35.h),
                                      child: Image.asset(
                                        "assets/images/hgc.png",
                                        fit: BoxFit.cover,
                                        width: 95.w,
                                        // width: 150,
                                      )),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "now on air".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: context.text.bodyMedium?.copyWith(
                                    color: AppColors.customWhiteTextColor, fontSize: 18.sp),
                              ),
                            ),
                            Expanded(child: SizedBox()),
                          ],
                        ),
                        70.heightBox,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap:(){
                  Get.to(TopAlbumsScreen());
                  },
                                    child: Transform.rotate(
                                        angle: -math.pi / 5,
                                        child: Text("Chart-Topping Songs:\n Listened / Viewed Hits", textAlign: TextAlign.center, maxLines: 2, style: TextStyle(color: Colors.yellow, fontSize: 18.sp, fontFamily: 'Metropolis'),)),
                                  ),

                                  GestureDetector(
                                    onTap: (){
                                        Get.to(TopSongsScreen());
                                    },
                                    child: Transform.rotate(
                                        angle: math.pi / 5,
                                        child: Text("Top Global Rankings\n Single / CD Downloads", textAlign: TextAlign.center, maxLines: 2, style: TextStyle(color: Color(0xffff019c), fontSize: 18.sp, fontFamily: 'Cooper'),)),
                                  ),
                                ],
                              ),
                              // 10.heightBox,
                              Container(
                                width: 130.w,
                                height: 140.h,
                                decoration: BoxDecoration(
                                  // color: Colors.white,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      opacity: 0.6,
                                      image: NetworkImage(
                                        logic1.hostImage != null
                                            ? logic1.hostImage ?? ''
                                            : '',
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                ),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(LatestNewsScreen());
                                    },
                                    child: Transform.rotate(
                                        angle: math.pi / 6,
                                        child: Text("Breaking Gospel\n Music News", textAlign: TextAlign.center, maxLines: 2, style: TextStyle(color: Colors.redAccent, fontSize: 18.sp, fontFamily: 'Cooper'),)),
                                  ),

                                  GestureDetector(
                                    onTap: (){
                                      Get.to(NewReleaseScreen());
                                    },
                                    child: Transform.rotate(
                                        angle: math.pi / 7,
                                        child: Text("Epic Unveiling New\n Release Projects", textAlign: TextAlign.center, maxLines: 2, style: TextStyle(color: Colors.orange, fontSize: 18.sp, fontFamily: 'Hp Impact'),)),
                                  ),
                                ],
                              ),
                            ],
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                    onPressed: (){
                                      Get.to(ContentPageScreen(
                                        content: '\nIf you are searching for hope, you have come to the right place.\n\nAt Choice Radio, we see ourselves as a platform with a strong mandate to empower people to worship God like never before.\n\nWe endeavor to make your every encounter with Choice Radio uplifting and encouraging, so please enjoy the station and allow us to be a blessing to you.\n\nWhatever the day brings, we are here to keep you company. It is our prayer that you will come with an expectant heart and let the Lord minister to you. And remember to invite your family and friends, so that they, too, will experience the anointing and feel the jubilance in their spirit.\n\nIt’s all about praising God together! This is also a venue to get your ministries heard throughout the region and across the globe, so be sure to contact us to know more about our program schedule and how we can work together.\n\nIt is no coincidence that you have found us online, and we hope that you also find Choice Radio a place of refuge, faith, love, healing, and deliverance',
                                        index: 0,), transition: Transition.downToUp,
                                      duration: Duration(seconds: 1));
                                    },
                                    icon: Icon(Icons.mail, size: 40, color: AppColors.customWhiteTextColor,)),
                                Text("Welcome",
                                  style: context.text.bodyMedium?.copyWith(
                                      color: AppColors.customWhiteTextColor,
                                      fontSize: 20.sp),)
                              ],
                            ),
                            16.widthBox,
                            Lottie.asset('assets/images/wave.json',
                                width: 80.w, height: 80.h),
                            16.widthBox,
                            Column(
                              children: [
                                IconButton(onPressed: (){
                                  Get.to(ContentPageScreen(
                                    content: '\nGospel Music Focus: Hallelujah Gospel Choice Radio specializes in playing gospel music, which is a genre that carries deep spiritual and uplifting messages. Gospel music has a unique ability to touch people is hearts and inspire them with its soulful melodies and powerful lyrics. By focusing solely on gospel music, the radio station caters to a specific audience that appreciates this genre and creates a sense of community. The radio station selects songs that uplift the spirit and spread messages of joy and resilience.\n\nWith the inclusion of different voices and musical styles ensures that the radio station appeals to a wide audience while maintaining its gospel roots. . This variety allows listeners to discover new artists, experience different styles, and connect with various expressions of gospel music. The radio station may also offer additional programming such as interviews with gospel artists, live performances, and discussions on faith and spirituality.\n\nWe encourage interaction and engagement through social media platforms, call-ins, and online forums where listeners can share their thoughts, prayer requests, and testimonies. By nurturing a community of like-minded individuals, the radio station creates a supportive and uplifting environment for its audience.\n\nOverall, Hallelujah Gospel Choice Radio is dedication to gospel music, positive content, diversity, engaging presenters, community engagement, and impactful programming are some of the key factors that make it a great radio station for gospel music enthusiasts.',
                                    index: 1,), transition: Transition.downToUp,
                                      duration: Duration(seconds: 1));
                                }, icon: Icon(Icons.mail, size: 40, color: AppColors.customWhiteTextColor,)),
                                Text("Hallelujah",
                                  style: context.text.bodyMedium?.copyWith(
                                      color: AppColors.customWhiteTextColor,
                                      fontSize: 20.sp),)
                              ],
                            ),
                          ],
                        ),
                        15.heightBox,
                        Expanded(
                          child: CarouselSlider(
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
                        ),
                      ],
                    ),
                  );
                }),
              )
            ],
          ),
        ));
  }
}
