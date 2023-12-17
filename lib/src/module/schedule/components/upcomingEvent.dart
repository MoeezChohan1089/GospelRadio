import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gosperadioapp/src/module/schedule/logic.dart';
import 'package:gosperadioapp/src/utils/constants/colors.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:intl/intl.dart';

import '../../../custom_widgets/datePickerWidget.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';

class UpcomingEventSection extends StatefulWidget {
  UpcomingEventSection({Key? key}) : super(key: key);

  @override
  State<UpcomingEventSection> createState() => _UpcomingEventSectionState();
}

class _UpcomingEventSectionState extends State<UpcomingEventSection> {
  final logic = Get.find<ScheduleLogic>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // logic.getScheduleList(context);
      // logic.getScheduleListEngineers(context);
      logic.fetchRadioShows();
      String currentDay = DateFormat('EEEE').format(DateTime.now());
      logic.filterweekday.value = currentDay;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Expanded(
        child: SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: pageMarginHorizontal,
                    vertical: pageMarginVertical),
                child: Row(
                  children: [
                    Text(
                      "Upcoming Show",
                      style: context.text.titleMedium?.copyWith(
                          color: AppColors.customWhiteTextColor,
                          fontSize: 18.sp),
                    ),
                  ],
                ),
              ),
              // Container(
              //   padding: const EdgeInsets.symmetric(vertical: 14),
              //   decoration: BoxDecoration(
              //     color: const Color(0xff27274A),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: DatePicker(
              //     context: context,
              //     DateTime(2021),
              //     initialSelectedDate: DateTime.now(),
              //     selectionColor: AppColors.customPinkColor,
              //     dayTextStyle: const TextStyle(fontSize: 16),
              //     dateTextStyle: const TextStyle(fontSize: 20),
              //     selectedTextColor: Colors.white,
              //     onDateChange: (date) {
              //       String dayOfWeek = DateFormat('EEEE').format(date);
              //       logic.filterweekday.value = dayOfWeek;
              //
              //       setState(() {});
              //       // New date selected
              //       logic.selectedValue = date;
              //       // logic.fetchAndFilterShows(logic.filterweekday.value);
              //     },
              //   ),
              // ),

              SizedBox(
                height: 56.h,
                child: ListView(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Obx(() {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                        child: GestureDetector(
                          onTap: () {
                            String dayOfWeek = 'Monday';
                            logic.filterweekday.value = dayOfWeek;
                            setState(() {

                            });
                            logic.indexSelect.value = 1;
                          },
                          child: Container(
                            width: 90.w,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: logic.indexSelect.value == 1? AppColors.customPinkColor: AppColors.customWebsiteListColor,
                                borderRadius: BorderRadius.circular(12.r)
                            ),
                            child: Text("Mon", textAlign: TextAlign.center,
                              style: context.text.bodyMedium?.copyWith(
                                  color: logic.indexSelect.value == 1? Colors.white: AppColors.customWhiteTextColor,
                                  fontSize: 16.sp),),
                          ),
                        ),
                      );
                    }),
                    Obx(() {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8, top: 6, bottom: 6),
                        child: GestureDetector(
                          onTap: () {
                            String dayOfWeek = 'Tuesday';
                            logic.filterweekday.value = dayOfWeek;
                            setState(() {

                            });
                            logic.indexSelect.value = 2;
                          },
                          child: Container(
                            width: 90.w,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: logic.indexSelect.value == 2? AppColors.customPinkColor: AppColors.customWebsiteListColor,
                                borderRadius: BorderRadius.circular(12.r)
                            ),
                            child: Text("Tue", textAlign: TextAlign.center,
                              style: context.text.bodyMedium?.copyWith(
                                  color: logic.indexSelect.value == 2? Colors.white: AppColors.customWhiteTextColor,
                                  fontSize: 16.sp),),
                          ),
                        ),
                      );
                    }),
                    Obx(() {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8, top: 6, bottom: 6),
                        child: GestureDetector(
                          onTap: () {
                            String dayOfWeek = 'Wednesday';
                            logic.filterweekday.value = dayOfWeek;
                            setState(() {

                            });
                            logic.indexSelect.value = 3;
                          },
                          child: Container(
                            width: 90.w,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: logic.indexSelect.value == 3? AppColors.customPinkColor: AppColors.customWebsiteListColor,
                                borderRadius: BorderRadius.circular(12.r)
                            ),
                            child: Text("Wed", textAlign: TextAlign.center,
                              style: context.text.bodyMedium?.copyWith(
                                  color: logic.indexSelect.value == 3? Colors.white: AppColors.customWhiteTextColor,
                                  fontSize: 16.sp),),
                          ),
                        ),
                      );
                    }),
                    Obx(() {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8, top: 6, bottom: 6),
                        child: GestureDetector(
                          onTap: () {
                            String dayOfWeek = 'Thursday';
                            logic.filterweekday.value = dayOfWeek;
                            setState(() {

                            });
                            logic.indexSelect.value = 4;
                          },
                          child: Container(
                            width: 90.w,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: logic.indexSelect.value == 4? AppColors.customPinkColor: AppColors.customWebsiteListColor,
                                borderRadius: BorderRadius.circular(12.r)
                            ),
                            child: Text("Thu", textAlign: TextAlign.center,
                              style: context.text.bodyMedium?.copyWith(
                                  color: logic.indexSelect.value == 4? Colors.white: AppColors.customWhiteTextColor,
                                  fontSize: 16.sp),),
                          ),
                        ),
                      );
                    }),
                    Obx(() {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8, top: 6, bottom: 6),
                        child: GestureDetector(
                          onTap: () {
                            String dayOfWeek = 'Friday';
                            logic.filterweekday.value = dayOfWeek;
                            setState(() {

                            });
                            logic.indexSelect.value = 5;
                          },
                          child: Container(
                            width: 90.w,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: logic.indexSelect.value == 5? AppColors.customPinkColor: AppColors.customWebsiteListColor,
                                borderRadius: BorderRadius.circular(12.r)
                            ),
                            child: Text("Fri", textAlign: TextAlign.center,
                              style: context.text.bodyMedium?.copyWith(
                                  color: logic.indexSelect.value == 5? Colors.white: AppColors.customWhiteTextColor,
                                  fontSize: 16.sp),),
                          ),
                        ),
                      );
                    }),
                    Obx(() {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8, top: 6, bottom: 6),
                        child: GestureDetector(
                          onTap: () {
                            String dayOfWeek = 'Saturday';
                            logic.filterweekday.value = dayOfWeek;
                            setState(() {

                            });
                            logic.indexSelect.value = 6;
                          },
                          child: Container(
                            width: 90.w,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: logic.indexSelect.value == 6? AppColors.customPinkColor: AppColors.customWebsiteListColor,
                                borderRadius: BorderRadius.circular(12.r)
                            ),
                            child: Text("Sat", textAlign: TextAlign.center,
                              style: context.text.bodyMedium?.copyWith(
                                  color: logic.indexSelect.value == 6? Colors.white: AppColors.customWhiteTextColor,
                                  fontSize: 16.sp),),
                          ),
                        ),
                      );
                    }),
                    Obx(() {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8, top: 6, bottom: 6),
                        child: GestureDetector(
                          onTap: () {
                            String dayOfWeek = 'Sunday';
                            logic.filterweekday.value = dayOfWeek;
                            setState(() {

                            });
                            logic.indexSelect.value = 7;
                          },
                          child: Container(
                            width: 90.w,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: logic.indexSelect.value == 7? AppColors.customPinkColor: AppColors.customWebsiteListColor,
                                borderRadius: BorderRadius.circular(12.r)
                            ),
                            child: Text("Sun", textAlign: TextAlign.center,
                              style: context.text.bodyMedium?.copyWith(
                                  color: logic.indexSelect.value == 7? Colors.white: AppColors.customWhiteTextColor,
                                  fontSize: 16.sp),),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),

              10.heightBox,
              Expanded(
                child: SizedBox(
                  height: 160.h,
                  child: logic.loadingSchedule.value == true
                      ? ShimerListviewPage() // Placeholder for loading state
                      : FutureBuilder<void>(
                        future: logic.fetchRadioShows(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if(logic.indexSelect.value == 0){
                            return Center(
                              child: Text('Select Your Day..',
                                style: TextStyle(color: Colors.white),),
                            );
                          }
                          else {
                            if (logic.radioShows.isEmpty) {
                              return Center(
                                child: Text('No Schedule Available',
                                  style: TextStyle(color: Colors.white),),
                              );
                            } else {
                              return ListView.builder(
                                physics: AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: logic.radioShows.length,
                                itemBuilder: (context, index) {
                                  final showName = logic.radioShows[index]
                                      .name;
                                  final showArtist = logic.radioShows[index].artist;
                                  final showFromTime = logic.radioShows[index]
                                      .fromTime;
                                  final showToTime = logic.radioShows[index]
                                      .toTime;
                                  final status = logic.radioShows[index].status;
                                  final formated = DateFormat('hh:mm a')
                                      .format(DateFormat('hh:mm').parse(
                                      showFromTime));
                                  final formated1 = DateFormat('hh:mm a')
                                      .format(
                                      DateFormat('hh:mm').parse(showToTime));
                                  if (showName != null &&
                                      showName.isNotEmpty) {
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
                                                            .customWhiteTextColor, fontSize: 16.sp),),
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
                                    return Container();
                                  }
                                },
                              );
                            }
                          }
                        },
                      ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
