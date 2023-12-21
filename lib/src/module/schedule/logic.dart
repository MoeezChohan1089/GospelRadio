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
  RxList<dynamic> albumsSchedule1 = [].obs;
  RxBool loadingSchedule = false.obs;
  RxBool showComment = false.obs;
  RxString filterweekday = 'Monday'.obs;
  RxString filterTodayEvent = 'Monday'.obs;
  final radioShows = <RadioShow>[].obs;
  final radioTodayShows = <RadioShow>[].obs;
  RxInt indexSelect = 0.obs;


  RxList showNames = [].obs;
  RxInt jsonShow = 0.obs;
  dynamic jsonDay;
  dynamic jsonDay1;
  dynamic jsonDay2;


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
        jsonDay1 = daySchedule;
        for (var show in daySchedule['shows']) {
          print("fsfsfsfsdsdfdffd: ${show['host_id']}");

          jsonShow.value = show['host_id'];
          jsonDay = json.decode(show['day']);
          jsonDay1 = show['from_time'];
          jsonDay2 = show['to_time'];
          print("json days: ${jsonDay} ${jsonDay1} ${jsonDay2}");
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

  Future<void> fetchRadioShows() async {
    final dio = Dio();
    try {
      final response = await dio.get('https://hgcradio.org/api/schedule');

      if (response.statusCode == 200) {
        final responseData = response.data;
        final schedules = responseData['data']['schedules'];

        final selectedDayShows = schedules.firstWhere(
              (schedule) => schedule['day_name'] == filterweekday.value,
          orElse: () => null,
        );

        print("abcdef====$selectedDayShows");

        if (selectedDayShows != null) {
          final shows = selectedDayShows['shows'];

          if (selectedDayShows != null) {
            final shows = selectedDayShows['shows'];

            if (shows != null && shows.isNotEmpty) {
              radioShows.assignAll(
                shows.map<RadioShow>(
                      (show) => RadioShow(show['show']['name'], show['host']['name'], show['from_time'], show['to_time'], show['show']['status']),
                ),
              );
            } else {
              radioShows.clear(); // Clear the list when no shows are available
            }
          } else {
            radioShows.clear(); // Clear the list when selected day has no shows
          }
        }
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> fetchTodayEvent() async {
    final dio = Dio();
    try {
      final response = await dio.get('https://hgcradio.org/api/schedule');

      if (response.statusCode == 200) {
        final responseData = response.data;
        final schedules = responseData['data']['schedules'];

        final selectedDayShows = schedules.firstWhere(
              (schedule) => schedule['day_name'] == filterTodayEvent.value,
          orElse: () => null,
        );

        print("abcdef====$selectedDayShows");

        if (selectedDayShows != null) {
          final shows = selectedDayShows['shows'];

          if (selectedDayShows != null) {
            final shows = selectedDayShows['shows'];

            if (shows != null && shows.isNotEmpty) {
              radioTodayShows.assignAll(
                shows.map<RadioShow>(
                      (show) => RadioShow(show['show']['name'], show['host']['name'], show['from_time'], show['to_time'], show['show']['status']),
                ),
              );
            } else {
              radioTodayShows.clear(); // Clear the list when no shows are available
            }
          } else {
            radioTodayShows.clear(); // Clear the list when selected day has no shows
          }
        }
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  String getDayName(int dayOfWeek) {
    switch (dayOfWeek) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Unknown';
    }
  }


  // Future<void> fetchAndFilterShows(String selectedDay) async {
  //   Dio dio = Dio();
  //   final response = await dio.get('https://hgcradio.org/api/schedule');
  //
  //   if (response.statusCode == 200) {
  //     final data = response.data;
  //     List<dynamic> schedules = data["data"]["schedules"];
  //
  //     List<String> matchingShowNames = [];
  //
  //     for (var schedule in schedules) {
  //       String dayName = schedule["day_name"];
  //       List<dynamic> shows = schedule["shows"];
  //
  //       for (var show in shows) {
  //         jsonShow.value = show['host_id'];
  //         jsonDay = json.decode(show['day']);
  //         jsonDay1 = show['from_time'];
  //         jsonDay2 = show['to_time'];
  //         print("abcdef: $jsonDay");
  //         if (jsonDay.contains(selectedDay)) {
  //           String showName = show["show"]["name"];
  //           showNames.value.add(showName);
  //           print('fffffffffffff-----: ${showNames.value}');
  //         }
  //       }
  //     }
  //
  //     print("Matching show names for $selectedDay: $matchingShowNames");
  //   } else {
  //     print("Error: ${response.statusMessage}");
  //   }
  // }
}

class RadioShow {
  final String name;
  final String artist;
  final String fromTime;
  final String toTime;
  final String status;
  RadioShow(this.name, this.artist, this.fromTime, this.toTime, this.status);
}
