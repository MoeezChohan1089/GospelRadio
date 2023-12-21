import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:intl/intl.dart';

import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../logic.dart';

class TodayEventSection extends StatefulWidget {
  const TodayEventSection({Key? key}) : super(key: key);

  @override
  State<TodayEventSection> createState() => _TodayEventSectionState();
}

class _TodayEventSectionState extends State<TodayEventSection> {
  final logic = Get.find<ScheduleLogic>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // logic.getScheduleList(context);
      // logic.getScheduleListEngineers(context);
      logic.fetchTodayEvent();
      String currentDay = DateFormat('EEEE').format(DateTime.now());
    });
    super.initState();
  }

  String getWeekdayName(int weekday) {
    List<String> weekdays = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];
    return weekdays[weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: pageMarginHorizontal, vertical: pageMarginVertical),
            child: Row(
              children: [
                Text("Today Show", style: context.text.titleMedium?.copyWith(
                    color: AppColors.customWhiteTextColor, fontSize: 18.sp),),
              ],
            ),
          ),

          ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: logic.radioTodayShows.length,
            itemBuilder: (context, index) {
              final showName = logic.radioTodayShows[index]
                  .name;
              final showArtist = logic.radioTodayShows[index].artist;
              final showFromTime = logic.radioTodayShows[index]
                  .fromTime;
              final showToTime = logic.radioTodayShows[index]
                  .toTime;
              final status = logic.radioTodayShows[index].status;
              final formated = DateFormat('hh:mm a')
                  .format(DateFormat('hh:mm').parse(
                  showFromTime));
              final formated1 = DateFormat('hh:mm a')
                  .format(
                  DateFormat('hh:mm').parse(showToTime));
              int weekdayNumber = DateTime
                  .now()
                  .weekday;
              String weekdayName = getWeekdayName(weekdayNumber);
              print("Today is ${logic.filterTodayEvent.value} $weekdayName");
              if (logic.filterTodayEvent.value == weekdayName) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: pageMarginHorizontal,
                      vertical: pageMarginVertical / 2),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 4),
                    padding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          20.r),
                      color: AppColors
                          .customWebsiteListColor,
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment
                              .start,
                          mainAxisAlignment: MainAxisAlignment
                              .start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(showName,
                                textAlign: TextAlign.start,
                                style: context.text.bodyMedium
                                    ?.copyWith(
                                    color: AppColors
                                        .customWhiteTextColor,
                                    fontSize: 16.sp),),
                            ),

                            Expanded(
                              child: Text(formated,
                                textAlign: TextAlign.center,
                                style: context.text.bodyMedium
                                    ?.copyWith(
                                    color: AppColors
                                        .customWhiteTextColor),),
                            ),

                            Expanded(
                              child: Text(formated1,
                                textAlign: TextAlign.center,
                                style: context.text.bodyMedium
                                    ?.copyWith(
                                    color: AppColors
                                        .customWhiteTextColor),),
                            ),
                          ],
                        ),
                        10.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween,
                          children: [
                            Text("$showArtist",
                              textAlign: TextAlign.start,
                              style: context.text.bodyMedium
                                  ?.copyWith(
                                  color: AppColors
                                      .customWhiteTextColor),),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              } else {
                // If showName is null or empty, return an empty container
                return index == 0 ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: pageMarginHorizontal,),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(Assets.images.todayEventImage)),
                ) : SizedBox();
              }
            },
          )
        ],
      );
    });
  }
}
