import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:gosperadioapp/src/utils/constants/assets.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../../music_play/view.dart';
import '../logic.dart';
import 'package:http/http.dart' as http;

class UModel {
  String? title;
  String? album;
  String? artist;
  String? img;
  String? play_at;

  UModel({this.title, this.album, this.artist, this.img, this.play_at});

  factory UModel.fromJson(Map<String, dynamic> json) {
    return UModel(
      title: json['title'],
      album: json['album'],
      artist: json['artist'],
      img: json['image'],
      play_at: json['play_at'],
    );
  }
}

class PlayingListSection extends StatefulWidget {
  const PlayingListSection({Key? key}) : super(key: key);

  @override
  State<PlayingListSection> createState() => _PlayingListSectionState();
}

class _PlayingListSectionState extends State<PlayingListSection> {
  // final logic = Get.put(PlayHistoryLogic());
  String artistname = '';
  List<UModel> glist = [];
  Future<List<UModel>> userApi() async {
    final dio = Dio();
    final response = await dio.get('https://hgcradio.org/api/history');

    if (response.statusCode == 200) {
      List<UModel> glist = (response.data['data'] as List)
          .map((item) => UModel.fromJson(item))
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
  // List<historymodel> recipielist = [];
  // Future<List<historymodel>> getrecipe() async {
  //   final respon =
  //       await http.get(Uri.parse('https://hgcradio.org/api/history'));
  //   var data = jsonDecode(respon.body.toString());

  //   if (respon.statusCode == 200) {
  //     if (data is List) {
  //       // If the response is a list of objects
  //       for (var i in data) {
  //         recipielist.add(historymodel.fromJson(i));
  //         print('object');
  //       }
  //     } else if (data is Map<String, dynamic>) {
  //       // If the response is a single object
  //       recipielist.add(historymodel.fromJson(data));
  //       print('no');
  //     }
  //   } else {
  //     // Handle the error here, if needed.
  //     // For now, we'll just return an empty list.
  //     return recipielist;
  //   }

  //   return recipielist;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hitapi();
    // print(logic.historyMusicPlay.length);
  }

  Future hitapi() async {
    // logic.getMusicPlayhistory(context);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            child: FutureBuilder<List<UModel>>(
          future: userApi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ShimerListviewPage();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  // Access the 'data' list inside the historymodel instance
                  var item = snapshot.data![index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: pageMarginHorizontal, vertical: pageMarginVertical/2),
                    child: Container(
                        // padding: EdgeInsets.symmetric(
                        //   horizontal: pageMarginHorizontal / 2,
                        //   vertical: pageMarginVertical / 2,
                        // ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [
                              AppColors.customGradientFirstColor,
                              AppColors.customGradientSecondColor,
                            ],
                          ),
                        ),
                        child: Row(
                         children: [
                            Expanded(
                              flex: 3,
                              child: ListTile(
                                leading: Image.asset(
                                  'assets/images/hgc.png',
                                  width: 77,
                                  height: 60,
                                ),
                                title: Container(
                                  child: Text(
                                    item.title ?? 'Unknown Title',
                                    style: context.text.titleMedium?.copyWith(
                                      color: AppColors.customMusicTextColor,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                                subtitle: Container(
                                  width: 190,
                                  child: Text(
                                    item.album ?? "",
                                    style: context.text.titleMedium?.copyWith(
                                      color:
                                          AppColors.customMusicTextDescriptionColor,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                // width: 190,
                                child: Text(
                                  item.play_at ?? "",
                                  textAlign: TextAlign.end,
                                  style: context.text.titleMedium?.copyWith(
                                    color:
                                    AppColors.customMusicTextDescriptionColor,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                        // Row(
                        //   children: [
                        //     Image.asset(
                        //       'assets/images/hgc.png',
                        //       width: 77,
                        //       height: 60,
                        //     ),
                        //     10.widthBox,
                        //     8.heightBox,
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       children: [
                        //         Container(
                        //           child: Text(
                        //             item.title ?? 'Unknown Title',
                        //             style: context.text.titleMedium?.copyWith(
                        //               color: AppColors.customMusicTextColor,
                        //               fontSize: 14.sp,
                        //             ),
                        //           ),
                        //         ),
                        //         6.heightBox,
                        //         Container(
                        //           width: 190,
                        //           child: Text(
                        //             item.album ?? "",
                        //             style: context.text.titleMedium?.copyWith(
                        //               color: AppColors
                        //                   .customMusicTextDescriptionColor,
                        //               fontSize: 12.sp,
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        ),
                  );
                },
              );
            }
          },
        )));
  }
}
   // Column(
            //   children: List.generate(4, (index) {
            //     return InkWell(
            //       onTap: () {
            //         // Get.to(() => MusicPlayPage());
            //       },
            //       child: Padding(
            //         padding:
            //             EdgeInsets.symmetric(vertical: pageMarginVertical / 2),
            //         child: Container(
            //           padding: EdgeInsets.symmetric(
            //               horizontal: pageMarginHorizontal / 2,
            //               vertical: pageMarginVertical / 2),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(8),
            //             gradient: LinearGradient(
            //               colors: [
            //                 AppColors.customGradientFirstColor,
            //                 AppColors.customGradientSecondColor
            //               ],
            //             ),
            //           ),
            //           child: Row(
            //             children: [
            //               Image.asset(
            //                 Assets.images.playImage,
            //                 width: 77,
            //                 height: 60,
            //               ),
            //               10.widthBox,
            //               Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 children: [
            //                   Text('',
            //                       style: context.text.titleMedium?.copyWith(
            //                           color: AppColors.customMusicTextColor,
            //                           fontSize: 16.sp)),
            //                   6.heightBox,
            //                   Container(
            //                       width: 190,
            //                       child: Text(
            //                           "Enter your information and listen your favorite Music",
            //                           style: context.text.titleMedium?.copyWith(
            //                               color: AppColors
            //                                   .customMusicTextDescriptionColor,
            //                               fontSize: 12.sp)))
            //                 ],
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //   }),
            // ),