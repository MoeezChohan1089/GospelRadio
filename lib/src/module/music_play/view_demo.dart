// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/globalVariable/database_controller.dart';
import 'package:gosperadioapp/src/module/home/logic.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../custom_widgets/custom_dialogue.dart';
import '../../utils/constants/assets.dart';
import '../../utils/constants/colors.dart';
import '../../utils/skeleton_loaders/shimmerLoader.dart';
import 'logic.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_cache/just_audio_cache.dart';


class MusicDemo extends StatefulWidget {
  String? name;
  String? artistName;
  String? albumName;
  String? imageSrc;
  String? musicUrl;
  String? duration;

  MusicDemo(
      {Key? key, this.name, this.artistName, this.imageSrc, this.albumName, this.musicUrl, this.duration})
      : super(key: key);

  @override
  State<MusicDemo> createState() => _MusicDemoState();
}

class _MusicDemoState extends State<MusicDemo> with SingleTickerProviderStateMixin{
  AnimationController? _animationController;

  final logic = Get.put(MusicPlayLogic());
  Duration duration1 = (Duration(seconds: 45));
  final logic1 = Get.put(HomeLogic());
  bool isTimerRunning = false;
  AudioPlayer player = AudioPlayer();
  bool manuallyStopped = false;
  int currentSongIndex = 0;
  bool isAudioPreloaded = false;
  PlayerState? _state;
  bool isPlaying = false;

  Timer? _timer;
  int _start = 45;
  bool _isPlaying = false;

  void startTimer1() {
    if (!isTimerRunning) {
      // LocalDatabase.to.box.read('seconds');
      // if (LocalDatabase.to.box.read('seconds') != null) {
      //   duration1 = Duration(seconds: int.parse(LocalDatabase.to.box.read('seconds').toString()));
      // }
      setState(() {
        _timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime1());
        isTimerRunning = true;
        _animationController!.repeat();
      });
    }
  }

  void addTime1() {
    const addSeconds = 1;

    final seconds = duration1.inSeconds - addSeconds;
    duration1 = Duration(seconds: seconds);
    if (seconds <= 0) {
      _timer?.cancel();
      if (LocalDatabase.to.box.read('token') == null) {
        isPlaying = false;
        player.pause();
        _playButton;
        customDialogueBox(context);
      }
      setState(() {

      });
    } else {
      duration1 = Duration(seconds: seconds);
      _pauseButton;
      setState(() {

      });
    }
    // storeSeconds(duration1);
  }

  void pauseTimer() {
    if (isTimerRunning) {
      _timer?.cancel();
      setState(() {
        isTimerRunning = false;
        _animationController!.stop();
      });
    }
  }

  void updateTimer() {
    const addSeconds = -1; // Subtracting 1 second
    final seconds = duration1.inSeconds + addSeconds;

    if (seconds <= 0) {
      _timer?.cancel();
      isTimerRunning = false;
      // Handle the completion of the timer
    } else {
      duration1 = Duration(seconds: seconds);
      setState(() {
        // Update the state to reflect the new duration
      });
    }
  }

  // void startOrResumeTimer() {
  //   if (!isTimerRunning) {
  //     setState(() {
  //       _timer = Timer.periodic(const Duration(seconds: 1), (_) => updateTimer());
  //       isTimerRunning = true;
  //     });
  //   }
  // }

  // void startTimer() {
  //   const oneSec = Duration(seconds: 1);
  //   _timer = Timer.periodic(
  //     oneSec,
  //         (Timer timer) {
  //       if (_start == 0) {
  //         setState(() {
  //           timer.cancel();
  //           if (LocalDatabase.to.box.read('token') == null) {
  //             isPlaying = false;
  //             player.pause();
  //             _playButton;
  //             customDialogueBox(context);
  //           }
  //         });
  //       } else {
  //         setState(() {
  //           _start--;
  //         });
  //       }
  //     },
  //   );
  // }

  // void toggleTimer() {
  //   if (_isPlaying) {
  //     _timer?.cancel();
  //   } else {
  //     startTimer();
  //   }
  //   setState(() {
  //     _isPlaying = !_isPlaying;
  //   });
  // }


  Widget _audioStateWidget() {
    if (_state == null) {
      isPlaying = true;
      return _playButton;
    }
    if (_state!.playing) {
      isPlaying = false;
      return _pauseButton;
    } else {
      isPlaying = true;
      return _playButton;
    }
  }

  Widget get _pauseButton =>
      GestureDetector(
        onTap: () {
          isPlaying = false;
          player.pause();
          pauseTimer();
        },
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: AppColors.customPinkColor,
              shape: BoxShape.circle),
          child: Icon(
            Icons.pause,
            size: 35,
            color: Colors.white,
          ),
        ),
      );

  Widget get _playButton =>
      GestureDetector(
        onTap: () {
          isPlaying = true;
          _playAudio();
          startTimer1();
        },
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: AppColors.customPinkColor,
              shape: BoxShape.circle),
          child: Icon(
            Icons.play_arrow,
            size: 35,
            color: Colors.white,
          ),
        ),
      );

  void _updateSongDetails() {
    if (currentSongIndex >= 0 &&
        currentSongIndex < logic1.albumsListMusicConstant.length) {
      setState(() {
        widget.name = logic1.albumsListMusicConstant[currentSongIndex]['title'];
        widget.albumName =
        logic1.albumsListMusicConstant[currentSongIndex]['artist_name'];
        widget.musicUrl =
        logic1.albumsListMusicConstant[currentSongIndex]['sample_url'];
      });
    }
  }

  void _forwardMusic() async {
    if (currentSongIndex < logic1.albumsListMusicConstant.length - 1) {
      player.pause();
      currentSongIndex++;
    } else {
      // Optional: Handle if you want to loop to the first song again or stop at the last song
      // currentSongIndex = 0;
    }
    await _playCurrentSong();
    _updateSongDetails();
  }

  void _backwardMusic() async {
    if (currentSongIndex > 0) {
      player.pause();
      currentSongIndex--;
    } else {
      // Optional: Handle if you want to loop to the last song again or stop at the first song
      // currentSongIndex = logic.albumsListMusicConstant.length - 1;
    }
    await _playCurrentSong();
    _updateSongDetails();
  }

  Future<void> _playCurrentSong() async {
    String musicUrl =
    logic1.albumsListMusicConstant[currentSongIndex]['sample_url'];
    player = AudioPlayer();
    player.dynamicSet(url: musicUrl);
    //_player.dynamicSetAll(sources);
    player.playerStateStream.listen((state) {
      setState(() {
        _state = state;
      });
      print(state);
    });
  }

  void _playAudio() async {
    player.play();
  }

  Future<void> _preloadAudio() async {
    player.dynamicSet(url: widget.musicUrl!);
    isPlaying = true;
    //_player.dynamicSetAll(sources);

    Future.delayed(Duration(seconds: 1), () {
      _playAudio();
      startTimer1();
    });
  }

  @override
  void initState() {
    player = AudioPlayer();
    _preloadAudio();
    player.dynamicSet(url: widget.musicUrl!);
    //_player.dynamicSetAll(sources);
    player.playerStateStream.listen((state) {
      setState(() {
        _state = state;
      });
      print(state);
    });
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // Duration can be adjusted
    );

    _animationController!.addListener(() {
      setState(() {
        // Update your animation based on the music's amplitude
        // You can use flutter_fft to get real-time music amplitude
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    _timer?.cancel();
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "name of artist: ${widget.name}------${widget.albumName}------${widget
            .musicUrl}");
    return WillPopScope(
      onWillPop: () async {
        // Prevent the music from stopping when clicking on the back button
        if (isPlaying) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    Assets.images.welcomeBackground,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: Opacity(
                opacity: 0.9,
                child: AnimatedBuilder(
                  animation: _animationController!,
                  builder: (context, child) {
                    // Customize your animation here
                    return Transform.scale(
                      scale: 1 + _animationController!.value * 0.5,
                      // Example scaling effect
                      child: Image.asset(
                        Assets.images.frameIcon,
                        width: 458,
                        height: 448,
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 60.0,
              left: 20.0,
              right: 20.0,
              child: Container(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              // Prevent the music from stopping when clicking on the back button
                              if (isPlaying) {
                                setState(() {
                                  isPlaying = false;
                                  player.pause();
                                  Get.back();
                                });
                              } else {
                                setState(() {
                                  isPlaying = true;
                                  player.pause();
                                  Get.back();
                                });
                              }
                            },
                            icon: Icon(Icons.arrow_back,
                                size: 30, color: Colors.white)),
                        Container(
                          // width: 80,
                          // // color: Colors.amber,
                          // height: 80,
                          // margin: EdgeInsets.only(top: 35.h),
                            child: Image.asset(
                              "assets/images/hgc.png",
                              fit: BoxFit.cover,
                              width: 110.w,
                              // width: 150,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: SizedBox()),
                        Expanded(
                          flex: 8,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              '${widget.albumName}',
                              textAlign: TextAlign.center,
                              style: context.text.titleMedium?.copyWith(
                                  fontSize: 20.sp,
                                  color: Colors.white,
                                  height: 1.2,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        Expanded(
                            child: SizedBox())
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "${widget.name}",
                        style: context.text.titleMedium?.copyWith(
                            fontSize: 18.sp,
                            color: Colors.white,
                            height: 1.2,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    16.heightBox,
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "${widget.artistName}",
                        style: context.text.titleMedium?.copyWith(
                            fontSize: 16.sp,
                            color: AppColors.customMusicTextColor,
                            height: 1.2,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    20.heightBox,
                    Container(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child: CachedNetworkImage(
                          imageUrl: widget.imageSrc!,


                          // imageUrl: (productDetail?.images ?? []).isNotEmpty
                          //     ? productDetail!.images[0].originalSrc
                          //     : "",
                          fit: BoxFit.cover,
                          height: 100.h,
                          width: 100.w,
                          placeholder: (context, url) =>
                              productShimmer(),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 50.0,
                left: 50.0,
                right: 50.0,
                child: Column(
                  children: [
                    100.heightBox,
                    Container(
                      width: double.maxFinite,
                      alignment: Alignment.center,
                      child: Text( LocalDatabase.to.box.read('token') == null ? "${duration1.inSeconds}s": "${widget.duration}",
                        style: context.text.bodyMedium?.copyWith(
                            color: AppColors.customWhiteTextColor),),
                    ),
                    20.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              _backwardMusic();
                              setState(() {});
                              print('object');
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Color(0xff153252),
                                  shape: BoxShape.circle),
                              child: Transform.rotate(
                                  angle: 3.14,
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ),
                        Expanded(child: _audioStateWidget()),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              _forwardMusic();
                              setState(() {});
                              print('object');
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Color(0xff153252),
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Detect when the music screen is re-entered and stop the audio playback.
    if (ModalRoute
        .of(context)
        ?.isCurrent == true && isPlaying) {
      // Check the flag to determine if the music was manually stopped
      if (!manuallyStopped) {
        player.pause();
        setState(() {
          isPlaying = false;
        });
      }
    }
  }

  // Call this method when the user clicks the stop button
  // Call this method when the user clicks the stop button
  void stopMusicManually() {
    player.stop();
    setState(() {
      isPlaying = false;
      manuallyStopped = true;
    });
  }
}
