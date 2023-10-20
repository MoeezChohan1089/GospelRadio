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
  Rx<dynamic> dataPlayNow = Rx<dynamic>(null);
  Rx<dynamic> playNext = Rx<dynamic>(null);
  dynamic hostImage;
  RxBool loadingAir = false.obs;
  TextEditingController searchHistoryController = TextEditingController();
  RxList<dynamic> filteredHistory = [].obs;

  @override
  void onInit() {
    super.onInit();
    onAirFunction();
  }


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

      historyMusicPlay.value.forEach((album) {
        print('History Title: ${album}');
      });

      // Get.to(() => MusicPlayPage());
      print('Succes');
    } else {
      print(response.statusMessage);
    }
  }

  onAirFunction() async{
   try{
     loadingAir.value = true;
     var dio = Dio();
     var response = await dio.request(
       'https://hgcradio.org/api/on-air',
       options: Options(
         method: 'GET',
       ),
     );

     if (response.statusCode == 200 && response.data['status'] == 'Success') {
       print(json.encode(response.data));
       loadingAir.value = false;
       hostImage = response.data['data']['show']['host_image'];
       dataPlayNow.value = response.data['data']['now_playing'];
       playNext.value = response.data['data']['next'];

       print("ffffff: ${dataPlayNow}");
       print("fffgggffffffff: ${playNext}");
     }
     else {
       loadingAir.value = false;
       print(response.statusMessage);
     }
   }catch(e){
     loadingAir.value = false;
     print('error: $e');
   }
  }
}
