import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/globalVariable/global_variable.dart';

import '../../globalVariable/database_controller.dart';
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
   try{
     customLoaderGlobal.showLoader(context);
     var headers = {
       'Authorization': 'Bearer ${LocalDatabase.to.box.read('token')}'
     };
     var data = {
       'type': 'Album',
       'type_id': '$id'
     };

     var dio = Dio();
     var response = await dio.request(
       'https://hgcradio.org/api/payment-token',
       options: Options(
         method: 'POST',
         headers: headers,
       ),
       data: data,
     );

     if (response.statusCode == 200) {
       print(json.encode(response.data));
       customLoaderGlobal.hideLoader();
       final snackBar = SnackBar(
         content: Text('Download Successfully..!!'),
       );

       ScaffoldMessenger.of(context).showSnackBar(snackBar);
     }
     else {
       customLoaderGlobal.hideLoader();
       print(response.statusMessage);
     }
   }catch(e){
     customLoaderGlobal.hideLoader();
     final snackBar = SnackBar(
       content: Text('Something went wrong'),
     );

     ScaffoldMessenger.of(context).showSnackBar(snackBar);
   }
  }
}
