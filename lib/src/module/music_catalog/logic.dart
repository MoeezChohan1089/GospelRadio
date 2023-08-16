import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/globalVariable/global_variable.dart';

import '../../utils/constants/colors.dart';
import 'state.dart';

class Music_catalogLogic extends GetxController {
  final Music_catalogState state = Music_catalogState();
  RxBool loadingCatalog = false.obs;

  RxString listImagesCatalog = ''.obs;
  Map<String, dynamic> responseDataMusicList = Map<String, dynamic>();
  RxList<dynamic> albumsListMusic = [].obs;
  RxBool paymentSuccessful = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  getCatalogMusicAlbum(BuildContext context, int id) async {
    loadingCatalog.value = true;
    var dio = Dio();
    var response = await dio.request(
      'https://hgcradio.org/api/album/$id',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      loadingCatalog.value = false;
      listImagesCatalog.value = json.encode(response.data);
      responseDataMusicList = json.decode(listImagesCatalog.value);
      albumsListMusic.value = responseDataMusicList['data']['music_in_album'];

      print(
          "fssfsfsdfsdfsdfsdfsfsdfs: ${responseDataMusicList['data']['album']['title']}");
    } else {
      loadingCatalog.value = false;
      print(response.statusMessage);
    }
  }

  downloadSong(context, id) async{
    customLoaderGlobal.showLoader(context);
    var dio = Dio();
    var response = await dio.request(
      'https://hgcradio.org/api/purhcased/album/$id',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      customLoaderGlobal.hideLoader();
      Get.snackbar('Message', 'Download Successfully..!!',
          backgroundColor: Colors.black,
          colorText: AppColors.customWhiteTextColor);

      print(
          "fssfsfsdfsdfsdfsdfsfsdfs: ${responseDataMusicList['data']['album']['title']}");
    } else {
      customLoaderGlobal.hideLoader();
      print(response.statusMessage);
    }
  }
}
