import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/constants/assets.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../utils/constants/colors.dart';
import 'music_radio/view.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.images.welcomeBackground),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.6,
              child: Image.asset(
                Assets.images.welcomeWomen,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 70.0,
            left: 75.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage('assets/images/Logo.png'),
                  height: 100,
                  width: 100,
                )
              ],
            ),
          ),
          Positioned(
            top: 160.0,
            left: 52.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Let’s Get \nStarted',
                  style: context.text.titleMedium?.copyWith(
                      fontSize: 50.sp,
                      color: Colors.white,
                      height: 1.2,
                      fontWeight: FontWeight.w700),
                ),
                30.heightBox,
                Text(
                  "Enjoy the best radio stations \nfrom your home, don't miss \nout on anything",
                  style: context.text.titleMedium?.copyWith(
                      fontSize: 16.sp,
                      color: Colors.white,
                      height: 1.2,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50.0,
            left: 50.0,
            right: 50.0,
            child: ElevatedButton(
                onPressed: () async {
                  // String startedVar = "Started";
                  // LocalDatabase.to.box.write('started', startedVar);
                  // Get.to(() => HomePage());
                  Get.to(() => Music_radioPage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.customPinkColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  // Set the text color of the button
                  padding: const EdgeInsets.all(10),
                  // Set the padding around the button content
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        7), // Set the border radius of the button
                  ),
                ),
                child: Text(
                  "Get Started",
                  style: context.text.bodyMedium!.copyWith(
                      color: Colors.white, fontSize: 20.sp, height: 1.1),
                )),
          ),
        ],
      ),
    );
  }
}
