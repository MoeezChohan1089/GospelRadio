
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';

class ChoosePaymentScreen extends StatelessWidget {
  const ChoosePaymentScreen({Key? key}) : super(key: key);

  customSelectionButton({required BuildContext context, required String iconPath, required String title}){
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.customGreyTextColor, width: 1),
            borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              height: 18,
            ),
            6.widthBox,
            Container(
              width: 184,
              child:  Text(
                '$title',
                style: context.text.titleMedium?.copyWith(fontSize: 14.sp, color: AppColors.customGreyTextColor, fontWeight: FontWeight.w700),
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16,),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: pageMarginVertical+4),
            child: Row(
              children: [
                Text("Choose Payment", style: context.text.titleMedium?.copyWith(color: AppColors.customWhiteTextColor, fontSize: 18.sp),),
              ],
            ),
          ),
          customSelectionButton(context: context, iconPath: Assets.icons.masterCardIcon, title: "**** **** **** 3690"),
          customSelectionButton(context: context, iconPath: Assets.icons.visaIcon, title: "**** **** **** 3690"),
          customSelectionButton(context: context, iconPath: Assets.icons.payPalIcon, title: "**** **** **** 3690"),
          customSelectionButton(context: context, iconPath: Assets.icons.vimeoIcon, title: "**** **** **** 3690"),
          customSelectionButton(context: context, iconPath: Assets.icons.zelleIcon, title: "**** **** **** 3690"),
          customSelectionButton(context: context, iconPath: Assets.icons.dollarIcon, title: "**** **** **** 3690"),
        ],
      ),
    );
  }
}
