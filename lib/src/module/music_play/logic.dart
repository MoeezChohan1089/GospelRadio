import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/module/music_play/view_demo.dart';

import 'state.dart';
import 'view.dart';

class MusicPlayLogic extends GetxController {
  final MusicPlayState state = MusicPlayState();

  RxString listMusicPlay = ''.obs;
  Map<String, dynamic> responseDataMusicPlay = Map<String, dynamic>();
  RxList<dynamic> albumsMusicPlay = [].obs;

  getMusicPlaySong(BuildContext context, int id) async {
    var dio = Dio();
    var response = await dio.request(
      'https://hgcradio.org/api/album/$id',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      listMusicPlay.value = json.encode(response.data);
      responseDataMusicPlay = json.decode(listMusicPlay.value);
      albumsMusicPlay.value = responseDataMusicPlay['data']['music_in_album'];

      Get.to(() => MusicDemo());
      print(
          "abcdefgh: ${responseDataMusicPlay['data']['music_in_album']['id']}");
    } else {
      print(response.statusMessage);
    }
  }
}
