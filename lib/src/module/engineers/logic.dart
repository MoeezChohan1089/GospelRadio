import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/globalVariable/global_variable.dart';

import '../../utils/constants/colors.dart';
import 'state.dart';

class EngineersLogic extends GetxController with GetSingleTickerProviderStateMixin{
  static EngineersLogic get to => Get.find();
  final EngineersState state = EngineersState();

  RxBool loadingCatalog = false.obs;
  RxString listImagesCatalog = ''.obs;
  // RxList<dynamic> catalogData = RxList<dynamic>();
  Map<String, dynamic> responseData = Map<String, dynamic>();
  RxList<dynamic> albumsList = [].obs;
  Map<String, dynamic> responseDataMusicListConstant = Map<String, dynamic>();
  Rx<int> currentImageIndex = 0.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  GlobalKey<FormState> formKeyValue = GlobalKey<FormState>();


  getAllEngineers(BuildContext context) async {
    customLoaderGlobal.showLoader(context);
    var dio = Dio();
    var response = await dio.request(
      'https://hgcradio.org/api/hosts',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      listImagesCatalog.value = json.encode(response.data);
      responseData = json.decode(listImagesCatalog.value);
      albumsList.value = responseData['data'];

      // List<dynamic> dataList = json.decode(listImagesCatalog.value);
      // catalogData.value = dataList;
      customLoaderGlobal.hideLoader();
      print("result of list Image in catalog=====>${ albumsList.value}=====<");
    } else {
      customLoaderGlobal.hideLoader();
      print("fffffffff: ${response.statusMessage}");
    }
  }

  RxString searchTermM = ''.obs;
  RxList<dynamic> filteredEngineer = [].obs;

  void searchLogic(String query) {
    filteredEngineer.value = albumsList.value.where((album) {
      final albumTitle = album['name'].toString().toLowerCase();
      final albumEmail = album['email'].toString().toLowerCase();
      print("value of album name: $albumsList");
      return albumTitle.contains(query.toLowerCase()) || albumEmail.contains(query.toLowerCase());
    }).toList();
  }

  sendComment(
      BuildContext context, String name, String email, String city, String state, String country, String hostID, String message) async {
    try {
      customLoaderGlobal.showLoader(context);
      Dio dio = Dio();

      final data = {
        'name': name,
        'email': email,
        'city': city,
        'state': state,
        'country': country,
        'host_id': hostID,
        'comment': message,
      };

      var response = await dio.request(
        'https://hgcradio.org/api/comment',
        options: Options(
          method: 'POST',
        ),
        data: data,
      );

      // Handle the response
      if (response.statusCode == 200) {
        print("result: ${json.encode(response.data)}");
        customLoaderGlobal.hideLoader();
        Get.snackbar('Message', 'Your comment is being proceed.',
            backgroundColor: Colors.black,
            colorText: AppColors.customWhiteTextColor);
      } else {
        // Request failed
        customLoaderGlobal.hideLoader();
        print('Failed to send message. Status code: ${response.statusMessage}');
      }
    } catch (error) {
      // Handle any Dio errors or exceptions
      customLoaderGlobal.hideLoader();
      print('Status code: ${error}');
    }
  }
}
