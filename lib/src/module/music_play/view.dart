// ignore_for_file: must_be_immutable

import 'package:audioplayers/audioplayers.dart';
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
import 'logic.dart';

class MusicPlayPage extends StatefulWidget {
  String? name;
  String? albumName;
  String? musicUrl;
  MusicPlayPage({Key? key, this.name, this.albumName, this.musicUrl})
      : super(key: key);

  @override
  State<MusicPlayPage> createState() => _MusicPlayPageState();
}

class _MusicPlayPageState extends State<MusicPlayPage> {
  final logic = Get.put(MusicPlayLogic());
  final logic1 = Get.put(HomeLogic());

  final state = Get.find<MusicPlayLogic>().state;
  int maxduration = 100;
  String maxDurationToShow = "00:00";
  int currentpos = 0;
  String currentpostlabel = "00:00";
  // String audioasset = "assets/audio/unstoppable.mp3";
  bool isPlaying = false;
  bool audioPlayed = false;
  late Uint8List audiobytes;
  String time = '00:00';
  AudioPlayer player = AudioPlayer();
  bool manuallyStopped = false;
  int currentSongIndex = 0;
  bool isAudioPreloaded = false;

  void _updateSongDetails() {
    if (currentSongIndex >= 0 &&
        currentSongIndex < logic1.albumsListMusicConstant.length) {
      setState(() {
        widget.name = logic1.albumsListMusicConstant[currentSongIndex]['title'];
        widget.albumName =
            logic1.albumsListMusicConstant[currentSongIndex]['artist_name'];
      });
    }
  }

  void _forwardMusic() async {
    if (currentSongIndex < logic1.albumsListMusicConstant.length - 1) {
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
    int result = await player.play(musicUrl);
    if (result == 1) {
      setState(() {
        isPlaying = true;
        audioPlayed = true;
      });
    } else {
      print("Error while playing audio.");
    }
  }

  @override
  void initState() {
    player = AudioPlayer();
    _preloadAudio();

    player.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.STOPPED && !manuallyStopped) {
        setState(() {
          isPlaying = false;
        });
      }
    });


//     Future.delayed(Duration.zero, () async {
//
//       ByteData bytes = await rootBundle.load(widget.musicUrl!); //load audio from assets
//       audiobytes = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
//       //convert ByteData to Uint8List
//
//       player.onDurationChanged.listen((Duration d) { //get the duration of audio
//         maxduration = d.inMilliseconds;
//
//         setState(() {
//
//           ///----- New Implementation
//           int minutes = d.inMinutes;
//           int seconds = d.inSeconds.remainder(60); // Get the remainder of seconds after minutes are subtracted.
//
// // Format the minutes and seconds as a string in the format "mm:ss".
//           String time = "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
//           maxDurationToShow = time;
//           print("now total time is $time");
//
//
//
//           // // Convert maxduration to minutes and seconds for display.
//           // int minutes = (maxduration / 60).truncate();
//           // int seconds = maxduration % 60;
//           // time = "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
//           // print(" fromatted time is $time");  // Prints the time as "mm:ss"
//         });
//       });
//
//       player.onAudioPositionChanged.listen((Duration  p){
//         currentpos = p.inMilliseconds; //get the current position of playing audio
//
//         //generating the duration label
//         int shours = Duration(milliseconds:currentpos).inHours;
//         int sminutes = Duration(milliseconds:currentpos).inMinutes;
//         int sseconds = Duration(milliseconds:currentpos).inSeconds;
//
//         int rhours = shours;
//         int rminutes = sminutes - (shours * 60);
//         int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);
//
//         currentpostlabel = "${rminutes.toString().padLeft(2, '0')}:${rseconds.toString().padLeft(2, '0')}";
//
//         setState(() {
//           //refresh the UI
//         });
//       });
//
//     });
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future<void> _preloadAudio() async {

    await player.setUrl(widget.musicUrl!);
    setState(() {
      isAudioPreloaded = true;
    });
    Future.delayed(Duration(seconds: 7),(){
      setState(() {
        isAudioPreloaded = false;
      });
    });
    int result =
    await player.play(widget.musicUrl!);
    if (result == 1) {
      setState(() {
        isPlaying = true;
        audioPlayed = true;
      });
     if(LocalDatabase.to.box.read('token') == null){
       Future.delayed(Duration(seconds: 15),(){
         setState(() {
           isPlaying = false;
         });
         player.pause();
         customDialogueBox(context);

       });
     }
    } else {
      print("Error while playing audio.");
    }
  }

  @override
  Widget build(BuildContext context) {
    print(
        "name of artist: ${widget.name}------${widget.albumName}------${widget.musicUrl}");
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
                child: Image.asset(
                  Assets.images.frameIcon,
                  width: 458,
                  height: 448,
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
                    IconButton(
                        onPressed: () {
                          // Prevent the music from stopping when clicking on the back button
                          if (isPlaying) {
                            setState(() {
                              isPlaying = false;
                              Get.back();
                            });
                          } else {
                            setState(() {
                              isPlaying = true;
                              Get.back();
                            });
                          }
                        },
                        icon: Icon(Icons.arrow_back,
                            size: 30, color: Colors.white)),
                    Row(
                      children: [
                        Expanded(child: SizedBox()),
                        Expanded(
                          flex: 8,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Playing now',
                              textAlign: TextAlign.center,
                              style: context.text.titleMedium?.copyWith(
                                  fontSize: 20.sp,
                                  color: Colors.white,
                                  height: 1.2,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),

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
                        "${widget.albumName}",
                        style: context.text.titleMedium?.copyWith(
                            fontSize: 16.sp,
                            color: AppColors.customMusicTextColor,
                            height: 1.2,
                            fontWeight: FontWeight.w700),
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
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Top 20",
                        textAlign: TextAlign.start,
                        style: context.text.titleMedium?.copyWith(
                            fontSize: 20.sp,
                            color: Colors.white,
                            height: 1.2,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Best Music",
                        textAlign: TextAlign.end,
                        style: context.text.titleMedium?.copyWith(
                            fontSize: 18.sp,
                            color: AppColors.customMusicTextDescriptionColor,
                            height: 1.2,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    100.heightBox,
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
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              // _playCurrentSong();
                              // setState(() {});
                              if (!isPlaying && !audioPlayed) {
                                int result =
                                    await player.play(widget.musicUrl!);
                                if (result == 1) {
                                  setState(() {
                                    isPlaying = true;
                                    audioPlayed = true;
                                  });
                                  if(LocalDatabase.to.box.read('token') == null){
                                    Future.delayed(Duration(seconds: 15),(){
                                      setState(() {
                                        isPlaying = false;
                                      });
                                      player.pause();
                                      customDialogueBox(context);

                                    });
                                  }
                                } else {
                                  print("Error while playing audio.");
                                }
                              } else if (audioPlayed && !isPlaying) {
                                int result = await player.resume();
                                if (result == 1) {
                                  setState(() {
                                    isPlaying = true;
                                    audioPlayed = true;
                                  });
                                } else {
                                  print("Error on resume audio.");
                                }
                              } else {
                                int result = await player.pause();
                                if (result == 1) {
                                  setState(() {
                                    isPlaying = false;
                                  });
                                } else {
                                  print("Error on pause audio.");
                                }
                              }
                              // int result = await player.play(widget.musicUrl!);
                              // if (result == 1) {
                              //   setState(() {
                              //     isPlaying = true;
                              //     audioPlayed = true;
                              //   });
                              // }
                            },
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: AppColors.customPinkColor,
                                  shape: BoxShape.circle),
                              child:  Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
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
    if (ModalRoute.of(context)?.isCurrent == true && isPlaying) {
      // Check the flag to determine if the music was manually stopped
      if (!manuallyStopped) {
        player.resume();
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
