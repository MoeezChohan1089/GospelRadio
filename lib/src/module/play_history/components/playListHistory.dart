import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/module/play_history/logic.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';

class UModel2 {
  String? title;
  String? album;
  String? artist;
  String? img;

  UModel2({this.title, this.album, this.artist, this.img});

  factory UModel2.fromJson(Map<String, dynamic> json) {
    return UModel2(
      title: json['title'],
      album: json['album'],
      artist: json['artist'],
      img: json['image'],
    );
  }
}

class PlayHistoryScreen extends StatefulWidget {
  const PlayHistoryScreen({Key? key}) : super(key: key);

  @override
  State<PlayHistoryScreen> createState() => _PlayHistoryScreenState();
}

class _PlayHistoryScreenState extends State<PlayHistoryScreen> {
  final logic = Get.put(PlayHistoryLogic());
  String artistname = '';
  List<UModel2> glist = [];
  Future<List<UModel2>> userApi() async {
    final dio = Dio();
    final response = await dio.get('https://hgcradio.org/api/history');

    if (response.statusCode == 200) {
      List<UModel2> glist = (response.data['data'] as List)
          .map((item) => UModel2.fromJson(item))
          .toList();
      artistname = response.data['data'][0]['artist'];
      print(response.data['data'][0]['artist']);
      return glist;
    } else {
      // Handle the error here, if needed.
      // For now, we'll just return an empty list.
      return [];
    }
  }

  int maxduration = 100;
  String maxDurationToShow = "00:00";
  int currentpos = 0;
  String currentpostlabel = "00:00";
  String audioasset = "assets/audio/unstoppable.mp3";
  bool isplaying = false;
  bool audioplayed = false;
  late Uint8List audiobytes;
  String time = '00:00';
  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      ByteData bytes =
          await rootBundle.load(audioasset); //load audio from assets
      audiobytes =
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      //convert ByteData to Uint8List

      player.onDurationChanged.listen((Duration d) {
        //get the duration of audio
        maxduration = d.inMilliseconds;

        setState(() {
          ///----- New Implementation
          int minutes = d.inMinutes;
          int seconds = d.inSeconds.remainder(
              60); // Get the remainder of seconds after minutes are subtracted.

// Format the minutes and seconds as a string in the format "mm:ss".
          String time =
              "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
          maxDurationToShow = time;

          // // Convert maxduration to minutes and seconds for display.
          // int minutes = (maxduration / 60).truncate();
          // int seconds = maxduration % 60;
          // time = "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
          // print(" fromatted time is $time");  // Prints the time as "mm:ss"
        });
      });

      player.onAudioPositionChanged.listen((Duration p) {
        currentpos =
            p.inMilliseconds; //get the current position of playing audio

        //generating the duration label
        int shours = Duration(milliseconds: currentpos).inHours;
        int sminutes = Duration(milliseconds: currentpos).inMinutes;
        int sseconds = Duration(milliseconds: currentpos).inSeconds;

        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        currentpostlabel =
            "${rminutes.toString().padLeft(2, '0')}:${rseconds.toString().padLeft(2, '0')}";

        setState(() {
          //refresh the UI
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: pageMarginHorizontal, vertical: pageMarginVertical),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: pageMarginVertical + 4),
            child: Row(
              children: [
                Text(
                  "Now Playing",
                  style: context.text.titleMedium?.copyWith(
                      color: AppColors.customWhiteTextColor, fontSize: 18.sp),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(Assets.images.playHistoryImage)),
              Positioned(
                bottom: 16,
                right: 10,
                left: 10,
                child: Row(
                  children: [
                    InkWell(
                        onTap: () async {
                          if (!isplaying && !audioplayed) {
                            int result = await player.playBytes(audiobytes);
                            if (result == 1) {
                              //play success
                              setState(() {
                                isplaying = true;
                                audioplayed = true;
                              });
                            } else {
                              print("Error while playing audio.");
                            }
                          } else if (audioplayed && !isplaying) {
                            int result = await player.resume();
                            if (result == 1) {
                              //resume success
                              setState(() {
                                isplaying = true;
                                audioplayed = true;
                              });
                            } else {
                              print("Error on resume audio.");
                            }
                          } else {
                            int result = await player.pause();
                            if (result == 1) {
                              //pause success
                              setState(() {
                                isplaying = false;
                              });
                            } else {
                              print("Error on pause audio.");
                            }
                          }
                        },
                        child: Icon(
                          isplaying ? Icons.pause : Icons.play_arrow,
                          color: AppColors.customWhiteTextColor,
                          size: 30,
                        )),
                    Slider(
                      activeColor: AppColors.customPinkColor,
                      value: double.parse(currentpos.toString()),
                      min: 0,
                      max: double.parse(maxduration.toString()),
                      divisions: maxduration > 0 ? maxduration : null,
                      label: currentpostlabel,
                      onChanged: (double value) async {
                        int seekval = value.round();
                        int result =
                            await player.seek(Duration(milliseconds: seekval));
                        if (result == 1) {
                          //seek successful
                          currentpos = seekval;
                        } else {
                          print("Seek unsuccessful.");
                        }
                      },
                    ),
                    Text(
                      "$currentpostlabel/$maxDurationToShow",
                      style: context.text.titleMedium?.copyWith(
                          color: AppColors.customWhiteTextColor,
                          fontSize: 14.sp),
                    ),
                  ],
                ),
              )
            ],
          ),
          15.heightBox,
          Container(
              child: FutureBuilder<List<UModel2>>(
            future: userApi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('loading');
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return SizedBox(
                  height: 100.h,
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      // Access the 'data' list inside the historymodel instance
                      var item = snapshot.data![index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.artist ?? '',
                            style: context.text.titleMedium?.copyWith(
                                color: AppColors.customPinkColor,
                                fontSize: 18.sp),
                          ),
                          4.heightBox,
                          Text(
                            item.title ?? '',
                            style: context.text.titleMedium?.copyWith(
                                color: AppColors.customWhiteTextColor,
                                fontSize: 16.sp),
                          ),
                          4.heightBox,
                          Text(
                            item.album ?? '',
                            style: context.text.titleMedium?.copyWith(
                                color: AppColors.customWhiteTextColor,
                                fontSize: 16.sp),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
            },
          )),
        ],
      ),
    );
  }
}
