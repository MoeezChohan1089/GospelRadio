import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'state.dart';

class Music_radioLogic extends GetxController {
  final Music_radioState state = Music_radioState();
  Rx<int> currentImageIndex = 0.obs;
  Rx<int> currentImageIndex1 = 0.obs;
  RxBool loadingStreamMusic = false.obs;
  AudioPlayer player1 = AudioPlayer();
  RxBool isLoadingAlbums = false.obs;
  RxList topAlbums = [].obs;
  RxList topSongs = [].obs;
  RxList newRelease = [].obs;
  RxList latestNews = [].obs;
  RxList featureNews = [].obs;

  @override
  void onInit() {
    super.onInit();
    player1.setUrl('https://my.hgcradio.org:8000/radio.mp3');
  }

  navigateButtons() async{
    try{
      isLoadingAlbums.value = true;
      var dio = Dio();
      var response = await dio.request(
        'https://hgcradio.org/api/get/stats',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        isLoadingAlbums.value = false;
        print(json.encode(response.data));
        topAlbums.value = response.data['data']['top_albums'];
        print("ffffff: ${topAlbums.value}");
      }
      else {
        isLoadingAlbums.value = false;
        print(response.statusMessage);
      }
    }catch(e){
      isLoadingAlbums.value = false;
      print("error: $e");
    }
  }

  navigateButtons1() async{
    try{
      isLoadingAlbums.value = true;
      var dio = Dio();
      var response = await dio.request(
        'https://hgcradio.org/api/get/stats',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        isLoadingAlbums.value = false;
        print(json.encode(response.data));
        topSongs.value = response.data['data']['top_songs'];
        print("ffffff: ${topAlbums.value}");
      }
      else {
        isLoadingAlbums.value = false;
        print(response.statusMessage);
      }
    }catch(e){
      isLoadingAlbums.value = false;
      print("error: $e");
    }
  }

  navigateButtons2() async{
    try{
      isLoadingAlbums.value = true;
      var dio = Dio();
      var response = await dio.request(
        'https://hgcradio.org/api/get/stats',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        isLoadingAlbums.value = false;
        print(json.encode(response.data));
        newRelease.value = response.data['data']['new_releases'];
        print("ffffff: ${topAlbums.value}");
      }
      else {
        isLoadingAlbums.value = false;
        print(response.statusMessage);
      }
    }catch(e){
      isLoadingAlbums.value = false;
      print("error: $e");
    }
  }

  navigateButtons3() async{
    try{
      isLoadingAlbums.value = true;
      var dio = Dio();
      var response = await dio.request(
        'https://hgcradio.org/api/get/stats',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        isLoadingAlbums.value = false;
        print(json.encode(response.data));
        latestNews.value = response.data['data']['latest_news'];
        print("ffffff: ${topAlbums.value}");
      }
      else {
        isLoadingAlbums.value = false;
        print(response.statusMessage);
      }
    }catch(e){
      isLoadingAlbums.value = false;
      print("error: $e");
    }
  }

  navigateButtons4() async{
    try{
      isLoadingAlbums.value = true;
      var dio = Dio();
      var response = await dio.request(
        'https://hgcradio.org/api/get/stats',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        isLoadingAlbums.value = false;
        print(json.encode(response.data));
        featureNews.value = response.data['data']['featured_news'];
        print("ffffff: ${featureNews.value}");
      }
      else {
        isLoadingAlbums.value = false;
        print(response.statusMessage);
      }
    }catch(e){
      isLoadingAlbums.value = false;
      print("error: $e");
    }
  }
}
