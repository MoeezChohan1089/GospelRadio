import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
      logic.getScheduleList(context);
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
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: pageMarginHorizontal,
                    vertical: pageMarginVertical),
                child: Row(
                  children: [
                    Text(
                      "Upcoming Event",
                      style: context.text.titleMedium?.copyWith(
                          color: AppColors.customWhiteTextColor,
                          fontSize: 18.sp),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: pageMarginHorizontal,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xff27274A),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DatePicker(
                    context: context,
                    DateTime(2021),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: AppColors.customPinkColor,
                    dayTextStyle: const TextStyle(fontSize: 16),
                    dateTextStyle: const TextStyle(fontSize: 20),
                    selectedTextColor: Colors.white,
                    onDateChange: (date) {
                      String dayOfWeek = DateFormat('EEEE').format(date);
                      logic.filterweekday.value = dayOfWeek;

                      setState(() {});
                      // New date selected
                      logic.selectedValue = date;
                    },
                  ),
                ),
              ),
              10.heightBox,
              Expanded(
                child: logic.loadingSchedule.value == true
                    ? ShimerListviewPage() // Placeholder for loading state
                    : ListView.builder(
                        itemCount: logic.albumsSchedule.length,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (logic.filterweekday.value.isNotEmpty &&
                              logic.albumsSchedule[index]['day_name'] !=
                                  logic.filterweekday.value) {
                            return const SizedBox
                                .shrink(); // Hides the item if it doesn't match the filter
                          } else {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: pageMarginHorizontal,
                                  vertical: pageMarginVertical / 2),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        border: Border.symmetric(
                                          horizontal: BorderSide(
                                            color:
                                                AppColors.customGreyPriceColor,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            logic.albumsSchedule[index]
                                                    ['day_name']
                                                .toString(),
                                            style: context.text.titleMedium
                                                ?.copyWith(
                                              color:
                                                  AppColors.customGreyTextColor,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          // Check if the 'shows' list is not empty and contains the 'host' field.
                                          if (logic.albumsSchedule[index]
                                                      ['shows'] !=
                                                  null &&
                                              logic
                                                  .albumsSchedule[index]
                                                      ['shows']
                                                  .isNotEmpty &&
                                              logic.albumsSchedule[index]
                                                      ['shows'][0]['host'] !=
                                                  null)
                                            Text(
                                              logic.albumsSchedule[index]
                                                      ['shows'][0]['host']
                                                      ['name']
                                                  .toString(),
                                              style: context.text.titleMedium
                                                  ?.copyWith(
                                                color: AppColors
                                                    .customGreyTextColor,
                                                fontSize: 18.sp,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        width: double.maxFinite,
                                        child: Image.asset(
                                            Assets.images.upcomingEventImage1, height: 80, fit: BoxFit.cover,),
                                      ),
                                      // Use CachedNetworkImage to load image from URL if you want to display actual images.
                                      // CachedNetworkImage(
                                      //   imageUrl: logic.albumsSchedule[index]['shows'][0]['host']['avatar'],
                                      //   fit: BoxFit.cover,
                                      //   placeholder: (context, url) => productShimmer(),
                                      //   errorWidget: (context, url, error) => const Icon(Icons.error),
                                      // ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
              )
            ],
          ),
        ),
      );
    });
  }
}
