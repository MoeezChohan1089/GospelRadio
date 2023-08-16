import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../module/auth/logic.dart';
import '../utils/constants/colors.dart';

void showCustomDialog(BuildContext context, String dataPass) {

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirmation'),
        actions: [
          Row(children: [
            Text(
              "new password: ",
              style: context.text.titleMedium?.copyWith(
                  color: AppColors.customBlackTextColor, fontSize: 18.sp),
            ),
            Text(
              "$dataPass",
              style: context.text.titleMedium?.copyWith(
                  color: Colors.black, fontSize: 18.sp),
            ),
            10.widthBox,
            GestureDetector(
                onTap: () async{
                  await Clipboard.setData(ClipboardData(text: "$dataPass"));
                },
                child: Icon(Icons.copy_all_outlined, color: Colors.black,))
          ],),

          TextButton(
            onPressed: () {
              // Close the dialog and handle 'Confirm' action
              Navigator.of(context).pop();
              // _showConfirmationSnackBar(context);
            },
            child: Text('Confirm'),
          ),
        ],
      );
    },
  );
}