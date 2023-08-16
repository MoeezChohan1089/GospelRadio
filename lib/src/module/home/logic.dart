import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();
  RxBool loadingCatalog = false.obs;
  RxBool loadingCatalog1 = false.obs;

  RxString listImagesCatalog = ''.obs;
  // RxList<dynamic> catalogData = RxList<dynamic>();
  Map<String, dynamic> responseData = Map<String, dynamic>();
  RxList<dynamic> albumsList = [].obs;
  Map<String, dynamic> responseDataMusicListConstant = Map<String, dynamic>();
  Rx<int> currentImageIndex = 0.obs;
  RxList<dynamic> albumsListMusicConstant = [].obs;
  RxList<dynamic> filteredAlbumsList = [].obs;
  TextEditingController controllerSearch = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getCatalogAlbum();
    getCatalogMusicAlbumconstant();
  }

  RxList<dynamic> filteredAlbums = [].obs;

  void searchAlbums(String query) {
    filteredAlbums.value = albumsList.value.where((album) {
      final albumTitle = album['title'].toString().toLowerCase();
      print("value of album name: $albumsList");
      return albumTitle.contains(query.toLowerCase());
    }).toList();
  }

  getCatalogAlbum() async {
    loadingCatalog.value = true;
    var dio = Dio();
    var response = await dio.request(
      'https://hgcradio.org/api/albums',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      listImagesCatalog.value = json.encode(response.data);
      responseData = json.decode(listImagesCatalog.value);
      albumsList.value = responseData['data']['albums'];

      // You can now use the "albumsList" as per your requirements (e.g., store it in a state variable or display its contents).
      // Example: If you want to print the title of each album in the console:
      albumsList.forEach((album) {
        print('Album Title: ${album['title']}');
      });
      // List<dynamic> dataList = json.decode(listImagesCatalog.value);
      // catalogData.value = dataList;
      loadingCatalog.value = false;
      print("result of list Image in catalog=====>${responseData}=====<");
    } else {
      loadingCatalog.value = false;
      print("fffffffff: ${response.statusMessage}");
    }
  }

  // void searchAlbums(String keyword) {
  //   if (keyword.isEmpty) {
  //     // If the keyword is empty, show all albums.
  //     filteredAlbumsList.value = albumsList;
  //   } else {
  //     // Filter albums based on the keyword.
  //     filteredAlbumsList.value = albumsList.where((album) {
  //       return album['title'].toString().toLowerCase().contains(keyword.toLowerCase());
  //     }).toList();
  //   }
  // }
  //
  // void onSearchTextChanged(String newText) {
  //   searchAlbums(newText);
  // }

  getCatalogMusicAlbumconstant() async {
    loadingCatalog.value = true;
    var dio = Dio();
    var response = await dio.request(
      'https://hgcradio.org/api/album/19',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      loadingCatalog.value = false;
      listImagesCatalog.value = json.encode(response.data);
      responseDataMusicListConstant = json.decode(listImagesCatalog.value);
      albumsListMusicConstant.value =
          responseDataMusicListConstant['data']['music_in_album'];

      print(
          "fssfsfsdfsdfsdfsdfsfsdfs constant: ${responseDataMusicListConstant['data']['album']['title']}");
    } else {
      loadingCatalog.value = false;
      print(response.statusMessage);
    }
  }
}
