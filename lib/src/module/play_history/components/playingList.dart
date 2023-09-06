import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:gosperadioapp/src/utils/constants/assets.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../../custom_widgets/customTextField.dart';
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

  final logic = Get.put(PlayHistoryLogic());
  String artistname = '';
  List<UModel> glist = [];


  void searchHistory(String query) {
    logic.filteredHistory.value = glist.where((album) {
      final albumTitle = album.title.toString().toLowerCase();
      print("value of album name: ${logic.filteredHistory.value}");
      print("value of album name: ${albumTitle}");
      return albumTitle.contains(query.toLowerCase());
    }).toList();
  }

  Future<List<UModel>> userApi() async {
    final dio = Dio();
    final response = await dio.get('https://hgcradio.org/api/history');

    if (response.statusCode == 200) {
      glist = (response.data['data'] as List)
          .map((item) => UModel.fromJson(item))
          .toList();
      glist.forEach((history) {
        print('History Title: ${history.title}');
      });
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
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
          child: Container(
            height: 40,
            child: CustomTextFieldC(
              controller: logic.searchHistoryController,
              hintText: 'search',
              // textAlign: TextAlign.center,
              hintFontSize: 16.0,
              isOutlineInputBorder: true,
              isOutlineInputBorderColor: AppColors.customWhiteTextColor,
              textColor: Colors.white,
              // textFieldFillColor: Colors.transparent,
              // fontWeight: FontWeight.bold,
              fieldborderRadius: 100,
              outlineTopLeftRadius: 100,
              outlineTopRightRadius: 100,
              outlineBottomLeftRadius: 100,
              outlineBottomRightRadius: 100,
              textFontSize: 16.0,
              hintTextColor: Colors.white,
              onTap: () async {
                null;
              },
              onChanged: (query) {
                setState(() {
                  logic.filteredHistory.value = glist.where((album) {
                    print("is is true: ${album.title}");
                    final albumTitle = album.title.toString().toLowerCase();
                    print("value of album name: ${glist}");
                    print("value of album name: ${albumTitle}");
                    return albumTitle.contains(query!.toLowerCase());
                  }).toList();
                });
              },
              prefixIcon: Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Icon(
                    Icons.search, color: AppColors.customGreyBorderColor,
                    size: 26,)),
              suffixIcon: Icon(
                Icons.abc,
                color: Colors.white,
              ),
            ),
          ),
        ),
        16.heightBox,
        Expanded(
            child: FutureBuilder<List<UModel>>(
              future: userApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ShimerListviewPage();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return
                    Obx(() {
                      return ListView.builder(
                        itemCount: logic.filteredHistory.value.length,
                        itemBuilder: (context, index) {
                          // Access the 'data' list inside the historymodel instance
                          var item = logic.filteredHistory.value[index];

                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: pageMarginHorizontal,
                                vertical: pageMarginVertical / 2),
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
                                        contentPadding: EdgeInsets.only(
                                            left: 8),
                                        leading: logic.hostImage != null
                                            ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              10.r),
                                          child: CachedNetworkImage(
                                            imageUrl: logic.hostImage ?? "",

                                            height: 90.h,
                                            width: 90.w,
                                            // imageUrl: (productDetail?.images ?? []).isNotEmpty
                                            //     ? productDetail!.images[0].originalSrc
                                            //     : "",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                productShimmer(),
                                            errorWidget: (context, url,
                                                error) =>
                                            const Icon(Icons.error),
                                          ),
                                        )
                                            : Image.asset(
                                          'assets/images/hgc.png',
                                          width: 77,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                        title: Container(
                                          child: Text(
                                            "Title: ${item.title ??
                                                'Unknown Title'}",
                                            maxLines: 1,
                                            style: context.text.titleMedium
                                                ?.copyWith(
                                              color: AppColors
                                                  .customMusicTextColor,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ),
                                        subtitle: Container(
                                          width: 190,
                                          child: Text(
                                            "Artist: ${ item.artist ?? ""}",
                                            style: context.text.titleMedium
                                                ?.copyWith(
                                              color:
                                              AppColors
                                                  .customMusicTextDescriptionColor,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        // width: 190,
                                        child: Text(
                                          item.play_at ?? "",
                                          textAlign: TextAlign.end,
                                          style: context.text.titleMedium
                                              ?.copyWith(
                                            color:
                                            AppColors
                                                .customMusicTextDescriptionColor,
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
                    });
                }
              },
            )),
      ],
    );
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