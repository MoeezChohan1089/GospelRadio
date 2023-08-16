import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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

// Step 2: Extract the "name" property for each show and create a list of show names

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      logic.getScheduleListEngineers(context);
      String currentDay = DateFormat('EEEE').format(DateTime.now());
      logic.filterweekday.value = currentDay;
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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
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
                      Text("Albums: ${widget.name}",
                        style: context.text.bodyMedium?.copyWith(
                            color: AppColors.customMusicTextColor, fontSize: 18
                            .sp),),
                      Text("Email: ${widget.email}",
                        style: context.text.bodyMedium?.copyWith(
                            color: AppColors.customWhiteTextColor, fontSize: 18
                            .sp),),
                      Text("Slug: ${widget.slug}",
                        style: context.text.bodyMedium?.copyWith(
                            color: AppColors.customWhiteTextColor, fontSize: 18
                            .sp),)
                    ],
                  )
                ],
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
              Container(
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
              10.heightBox,
             SizedBox(
               height: 160.h,
               child:  logic.loadingSchedule.value == true
                   ? ShimerListviewPage() // Placeholder for loading state
                   : SingleChildScrollView(
                 child: Column(
                   children: List.generate(
                       logic.showNames.value.length, (index) {
                     // bool isMatchingShow = logic.jsonShow.value == widget.ID && logic.jsonDay == logic.filterweekday.value;
                     //     List<String>.from(logic.jsonDay).contains(logic.filterweekday.value);
                     // print("duplicate: ${logic.jsonDay.contains(logic.filterweekday.value)}");
                     bool isMatchingDay = List<String>.from(logic.jsonDay).contains(logic.filterweekday.value);
                     print("Is matching day? $isMatchingDay");

                     return logic.jsonShow.value == widget.ID && isMatchingDay? Padding(
                       padding: EdgeInsets.symmetric(
                           horizontal: pageMarginHorizontal,
                           vertical: pageMarginVertical / 2),
                       child:  Container(
                         margin: EdgeInsets.symmetric(vertical: 4),
                         padding: EdgeInsets.symmetric(vertical: 10),
                         width: double.maxFinite,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(20.r),
                           color: AppColors.customWebsiteListColor,
                         ),
                         child: Text(logic.showNames.value[index],
                           textAlign: TextAlign.center,
                           style: context.text.bodyMedium?.copyWith(
                               color: AppColors.customWhiteTextColor),),
                       ),
                     ): (index == 0)? Text("No Schedule Available.",
                       textAlign: TextAlign.center,
                       style: context.text.bodyMedium?.copyWith(
                           color: AppColors.customWhiteTextColor),):SizedBox();
                   }),
                 ),
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
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColors.customWebsiteListColor
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.message, color: AppColors.customWhiteTextColor,),
                          10.widthBox,
                          Text(
                            "dfsfsfsfsdfsfsd",
                            style: context.text.titleMedium?.copyWith(
                                color: AppColors.customWhiteTextColor,
                                fontSize: 18.sp),
                          ),
                          Spacer(),
                          Text(
                            "Aug 09",
                            style: context.text.titleMedium?.copyWith(
                                color: AppColors.customWhiteTextColor,
                                fontSize: 18.sp),
                          ),
                        ],
                      ),
                    ),
                    14.heightBox,
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: AppColors.customWebsiteListColor
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.message, color: AppColors.customWhiteTextColor,),
                          10.widthBox,
                          Text(
                            "hey there",
                            style: context.text.titleMedium?.copyWith(
                                color: AppColors.customWhiteTextColor,
                                fontSize: 18.sp),
                          ),
                          Spacer(),
                          Text(
                            "jun 11",
                            style: context.text.titleMedium?.copyWith(
                                color: AppColors.customWhiteTextColor,
                                fontSize: 18.sp),
                          ),
                        ],
                      ),
                    ),
                    14.heightBox,
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: AppColors.customWebsiteListColor
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.message, color: AppColors.customWhiteTextColor,),
                          10.widthBox,
                          Text(
                            "Hello is it ok?",
                            style: context.text.titleMedium?.copyWith(
                                color: AppColors.customWhiteTextColor,
                                fontSize: 18.sp),
                          ),
                          Spacer(),
                          Text(
                            "May 05",
                            style: context.text.titleMedium?.copyWith(
                                color: AppColors.customWhiteTextColor,
                                fontSize: 18.sp),
                          ),
                        ],
                      ),
                    ),
                    14.heightBox,
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: AppColors.customWebsiteListColor
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.message, color: AppColors.customWhiteTextColor,),
                          10.widthBox,
                          Text(
                            "Testing comment section?",
                            style: context.text.titleMedium?.copyWith(
                                color: AppColors.customWhiteTextColor,
                                fontSize: 18.sp),
                          ),
                          Spacer(),
                          Text(
                            "Feb 08",
                            style: context.text.titleMedium?.copyWith(
                                color: AppColors.customWhiteTextColor,
                                fontSize: 18.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
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
