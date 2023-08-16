
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.customGreyTextColor, width: 1),
              borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
              children: [
                Image.asset(Assets.images.musicCatalogImage, width: 66, height: 66,),
                6.widthBox,
                Container(
                  width: 184,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Born to Worship',
                        style: context.text.titleMedium?.copyWith(fontSize: 14.sp, color: AppColors.customPinkColor, fontWeight: FontWeight.w700),
                      ),
                      6.widthBox,
                      Text(
                        'Apostle Gary L. Wyatt',
                        style: context.text.titleMedium?.copyWith(fontSize: 16.sp, color: AppColors.customWhiteTextColor, fontWeight: FontWeight.w700),
                      ),
                      8.widthBox,
                      Text(
                        'This is the first Born to Worship CD.....',
                        style: context.text.titleMedium?.copyWith(fontSize: 16.sp, overflow: TextOverflow.ellipsis, color: AppColors.customWhiteTextColor, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text(
                  '\$15',
                  style: context.text.titleMedium?.copyWith(fontSize: 18.sp, color: AppColors.customPinkColor, fontWeight: FontWeight.w700),
                ),
                6.widthBox,
              ],
            ),
          ),
        )
      ],
    );
  }
}
