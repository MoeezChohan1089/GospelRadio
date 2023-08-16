
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';

class TodayEventSection extends StatelessWidget {
  const TodayEventSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal, vertical: pageMarginVertical),
          child: Row(
            children: [
              Text("Today Event", style: context.text.titleMedium?.copyWith(color: AppColors.customWhiteTextColor, fontSize: 18.sp),),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal,),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(Assets.images.todayEventImage)),
        ),
      ],
    );
  }
}
