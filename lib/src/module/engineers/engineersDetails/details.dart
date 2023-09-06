import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gosperadioapp/src/module/engineers/logic.dart';
import 'package:gosperadioapp/src/module/schedule/logic.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:intl/intl.dart';

import '../../../custom_widgets/datePickerWidget.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import 'commentForm.dart';

class EngineerDetails extends StatefulWidget {
  int? ID;
  String? avatar;
  String? name;
  String? email;
  String? slug;

  EngineerDetails(
      {super.key, this.ID, this.avatar, this.name, this.email, this.slug});

  @override
  State<EngineerDetails> createState() => _EngineerDetailsState();
}

class _EngineerDetailsState extends State<EngineerDetails> {
  final logic = Get.put(ScheduleLogic());
  final logic1 = Get.put(EngineersLogic());

// Step 2: Extract the "name" property for each show and create a list of show names

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      logic.fetchRadioShows();
      // logic.getScheduleListEngineers(context);

      String currentDay = DateFormat('EEEE').format(DateTime.now());
      logic.filterweekday.value = currentDay;
      // logic.fetchAndFilterShows(logic.filterweekday.value);
      logic1.getCommentFromApiService(widget.ID!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.custombackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.custombackgroundColor,
        scrolledUnderElevation: 0,
        // centerTitle: true,
        // title: Text(
        //   "Tapify".toUpperCase(),
        //   style:
        //   TextStyle(fontFamily: 'Sofia Pro Regular', fontSize: 18.sp),
        // ),
        leading: IconButton(
            onPressed: () {
              Get.back();
              // if(bottomNav.isFancyDrawer.isTrue){
              //   bottomNav.advancedDrawerController.showDrawer();
              // } else {
              //   bottomNav.navScaffoldKey.currentState?.openDrawer();
              // }
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        centerTitle: true,
        title: Text(
          "Weekly Schedule",
          textAlign: TextAlign.center,
          style: context.text.bodyMedium?.copyWith(
              color: AppColors.customWhiteTextColor, fontSize: 16.sp),
        ),
      ),
      body: Obx(() {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: pageMarginHorizontal,),
              child: Row(
                children: [
                  SizedBox(
                    height: 110,
                    width: 110,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.r),
                      child: CachedNetworkImage(
                        imageUrl: widget.avatar!,

                        // imageUrl: (productDetail?.images ?? []).isNotEmpty
                        //     ? productDetail!.images[0].originalSrc
                        //     : "",
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                        placeholder: (context, url) => productShimmer(),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                    ),
                  ),
                  10.widthBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 240.w,
                        child: Text("Albums: ${widget.name}",
                          maxLines: 1,
                          style: context.text.bodyMedium?.copyWith(
                            overflow: TextOverflow.ellipsis,
                              color: AppColors.customMusicTextColor, fontSize: 18
                              .sp),),
                      ),
                      Container(
                        width: 240.w,
                        child: Text("Email: ${widget.email}",
                          maxLines: 1,
                          style: context.text.bodyMedium?.copyWith(
                              overflow: TextOverflow.ellipsis,
                              color: AppColors.customWhiteTextColor, fontSize: 18
                              .sp),),
                      ),
                      Container(
                        width: 240.w,
                        child: Text("Slug: ${widget.slug}",
                          maxLines: 1,
                          style: context.text.bodyMedium?.copyWith(
                              overflow: TextOverflow.ellipsis,
                              color: AppColors.customWhiteTextColor, fontSize: 18
                              .sp),),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: pageMarginHorizontal,
                  vertical: pageMarginVertical),
              child: Row(
                children: [
                  Text(
                    "Weekly Schedule",
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
            SizedBox(
              height: 180.h,
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
                                    // horizontal: pageMarginHorizontal,
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
                                            Text("Artist: $showArtist",
                                              textAlign: TextAlign.start,
                                              style: context.text.bodyMedium
                                                  ?.copyWith(
                                                  color: AppColors
                                                      .customWhiteTextColor),),
                                            Text("Status: $status",
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
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: pageMarginHorizontal,
                  vertical: pageMarginVertical),
              child: Row(
                children: [
                  Text(
                    "Comments",
                    style: context.text.titleMedium?.copyWith(
                        color: AppColors.customWhiteTextColor,
                        fontSize: 18.sp),
                  ),
                ],
              ),
            ),
            10.heightBox,
            Expanded(
              child: logic1.getLoadComment.value? ShimerListviewPage(): SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(

                  children: List.generate(logic1.getComment.value.length, (index){
                    String dateString = logic1.getComment.value[index]['created_at'];
                    DateTime dateTime = DateTime.parse(dateString);

                    final formatDate = DateFormat('MMM dd').format(dateTime);
                    return logic1.getComment.value.isNotEmpty? Padding(
                      padding: EdgeInsets.symmetric(vertical: pageMarginVertical/2),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: AppColors.customWebsiteListColor
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.message, color: AppColors.customWhiteTextColor,),
                                10.widthBox,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name: ${logic1.getComment.value[index]['name']?? ""}",
                                        style: context.text.titleMedium?.copyWith(
                                            color: AppColors.customWhiteTextColor,
                                            fontSize: 16.sp),
                                      ),
                                      Text(
                                        "Email: ${logic1.getComment.value[index]['email']?? ""}",
                                        style: context.text.titleMedium?.copyWith(
                                            color: AppColors.customWhiteTextColor,
                                            fontSize: 16.sp),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            10.heightBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${logic1.getComment.value[index]['comment']?? ""}",
                                  style: context.text.titleMedium?.copyWith(
                                      color: AppColors.customWhiteTextColor,
                                      fontSize: 20.sp),
                                ),
                                Text(
                                  "$formatDate",
                                  style: context.text.titleMedium?.copyWith(
                                      color: AppColors.customWhiteTextColor,
                                      fontSize: 18.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ):Center(child: Text("No Comments", style: context.text.bodyMedium?.copyWith(color: AppColors.customWhiteTextColor),),);
                  }),
                ),
              )
            )
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your desired action here
          print('Floating action button pressed!');
          Get.to(() => CommentFormScreen(idHost: widget.ID,));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
