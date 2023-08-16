import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.dart';

class PlayHistoryLogic extends GetxController {
  final PlayHistoryState state = PlayHistoryState();

  RxString listMusicPlayhistory = ''.obs;
  Map<String, dynamic> responseDataMusicPlayhistory = Map<String, dynamic>();
  RxList<dynamic> historyMusicPlay = [].obs;

  getMusicPlayhistory(BuildContext context) async {
    var dio = Dio();
    var response = await dio.request(
      'https://hgcradio.org/api/history',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      listMusicPlayhistory.value = json.encode(response.data);
      responseDataMusicPlayhistory = json.decode(listMusicPlayhistory.value);
      historyMusicPlay.value = responseDataMusicPlayhistory['data']['title'];

      // Get.to(() => MusicPlayPage());
      print('Succes');
    } else {
      print(response.statusMessage);
    }
  }
}
