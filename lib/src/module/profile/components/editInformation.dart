import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../logic.dart';

class EditProfileImageSection extends StatelessWidget {
  final ProfileLogic logic = Get.put(ProfileLogic());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: pageMarginVertical, horizontal: pageMarginHorizontal),
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: AppColors.customWebsiteListColor,
            borderRadius: BorderRadius.circular(10.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(() {
              final firstName = logic.infor.isNotEmpty ? logic.infor[0]['nameProfile'] : '';
              return Text(
                '$firstName',
                style: context.text.labelMedium?.copyWith(fontSize: 25.sp, color: Colors.white, fontWeight: FontWeight.bold),
              );
            }),
            Obx(() {
              final email = logic.infor.isNotEmpty ? logic.infor[0]['emailProfile'] : '';
              return Text(
                email,
                style: context.text.bodyMedium?.copyWith(fontSize: 14.sp, color: Colors.white),
              );
            }),
          ],
        ),
      ),
    );
  }
}