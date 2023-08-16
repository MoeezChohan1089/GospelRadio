import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.dart';

class ScheduleLogic extends GetxController {
  final ScheduleState state = ScheduleState();

  DateTime selectedValue = DateTime.now();
  RxString listSchedule = ''.obs;
  Map<String, dynamic> responseDataSchedule = Map<String, dynamic>();
  RxList<dynamic> albumsSchedule = [].obs;
  RxBool loadingSchedule = false.obs;
  RxString filterweekday = ''.obs;

  RxList showNames = [].obs;
  RxInt jsonShow = 0.obs;
  dynamic jsonDay;


  getScheduleList(BuildContext context) async{
    loadingSchedule.value = true;
    var dio = Dio();
    var response = await dio.request(
      'https://hgcradio.org/api/schedule',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      loadingSchedule.value = false;
      listSchedule.value = json.encode(response.data);
      responseDataSchedule = json.decode(listSchedule.value);
      albumsSchedule.value = responseDataSchedule['data']['schedules'];

      // Get.to(()=> MusicPlayPage());

    }
    else {
      loadingSchedule.value = false;
      print(response.statusMessage);
    }
  }

  getScheduleListEngineers(BuildContext context) async{
    loadingSchedule.value = true;
    var dio = Dio();
    var response = await dio.request(
      'https://hgcradio.org/api/schedule',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      final jsonData = response.data;

      loadingSchedule.value = false;


      for (var daySchedule in jsonData['data']['schedules']) {
        for (var show in daySchedule['shows']) {
          print("fsfsfsfsdsdfdffd: ${show['host_id']}");
          jsonShow.value = show['host_id'];
          jsonDay = json.decode(show['day']);
          print("json days: ${jsonDay}");
         String showName = show['show']['name'];
         showNames.value.add(showName);
         print("dddddddd: ${showNames.value}");
        }
      }

      // Get.to(()=> MusicPlayPage());

    }
    else {
      loadingSchedule.value = false;
      print(response.statusMessage);
    }
  }
}
