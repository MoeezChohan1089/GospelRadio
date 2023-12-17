import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/constants/assets.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../../custom_widgets/customTextField.dart';
import '../../../utils/constants/colors.dart';
import '../logic.dart';


class OTPDeleteScreen extends StatefulWidget {
  String? email;

  OTPDeleteScreen({Key? key, this.email}) : super(key: key);

  @override
  State<OTPDeleteScreen> createState() => _OTPDeleteScreenState();
}

class _OTPDeleteScreenState extends State<OTPDeleteScreen> {

  final logic = Get.put(ProfileLogic());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: logic.deleteFormKey,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.images.welcomeBackground),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 120,
              left: 0,
              right: 0,
              child: Opacity(
                opacity: 0.6,
                child: Container(
                  alignment: Alignment.topRight,

                  child: SvgPicture.asset(
                    Assets.icons.polygonIcon,
                  ),
                ),
              ),
            ),
            Positioned(
                top: 30,
                left: 20,
                right: 20,
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          // width: 80,
                          // // color: Colors.amber,
                          // height: 80,
                          // margin: EdgeInsets.only(top: 35.h),
                            child: Image.asset(
                              "assets/images/hgc.png",
                              fit: BoxFit.cover,

                              // width: 150,
                            )),
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                )),

            Positioned(
              top: 170.0,
              left: 30.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    Assets.icons.musicDummyIcon,
                    height: 40,
                  ),
                  20.heightBox,
                  Text(
                    'OTP',
                    style: context.text.titleMedium?.copyWith(fontSize: 40.sp,
                        color: Colors.white,
                        height: 1.2,
                        fontWeight: FontWeight.w700),
                  ),
                  6.heightBox,
                  Text(
                    'Verification',
                    textAlign: TextAlign.start,
                    style: context.text.titleMedium?.copyWith(fontSize: 20.sp,
                        color: Colors.white,
                        height: 1.2,
                        fontWeight: FontWeight.w700),
                  ),


                ],
              ),
            ),
            Positioned(
              bottom: 230.0,
              left: 30.0,
              right: 30.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Verify your 4-digit code here',
                    textAlign: TextAlign.start,
                    style: context.text.titleMedium?.copyWith(fontSize: 16.sp,
                        color: Colors.white,
                        height: 1.2,
                        fontWeight: FontWeight.w700),
                  ),
                  10.heightBox,
                  OtpTextField(
                    handleControllers: (q){
                      if (q.length >= 1 && q[0] != null) {
                        logic.OTPDeleteController = q[0]!;
                      }
                      if (q.length >= 2 && q[1] != null) {
                        logic.OTPDeleteController1 = q[1]!;
                      }
                      if (q.length >= 3 && q[2] != null) {
                        logic.OTPDeleteController2 = q[2]!;
                      }
                      if (q.length >= 4 && q[3] != null) {
                        logic.OTPDeleteController3 = q[3]!;
                      }
                    },
                    numberOfFields: 4,
                    fillColor: AppColors.customPinkColor,
                    textStyle: TextStyle(color: AppColors.customWhiteTextColor),
                    borderColor: AppColors.customPinkColor,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    //set to true to show as box or false to show as dash
                    showFieldAsBox: true,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      //handle validation or checks here
                    },
                  ),
                  30.heightBox,
                  ElevatedButton(
                    onPressed: () async {
                      if(logic.deleteFormKey.currentState!.validate()){
                        logic.deleteOTPAccount(context: context, email: widget.email);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.customPinkColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      // Set the text color of the button
                      padding: const EdgeInsets.symmetric(horizontal: 80,
                          vertical: 10),
                      // Set the padding around the button content
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            7), // Set the border radius of the button
                      ),
                    ),
                    child: Text(
                      'Verify',
                      textAlign: TextAlign.start,
                      style: context.text.titleMedium?.copyWith(fontSize: 18
                          .sp,
                          color: Colors.white,
                          height: 1.2,
                          fontWeight: FontWeight.w700),
                    ),),
                ],
              ),
            ),
            // Positioned(
            //   bottom: 120.0,
            //   left: 30.0,
            //   right: 30.0,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       ElevatedButton(
            //           onPressed: () async {
            //             // Get.to(()=> HomePage());
            //           },
            //           style: ElevatedButton.styleFrom(
            //             backgroundColor: AppColors.customMusicTextColor,
            //             foregroundColor: Colors.white,
            //             elevation: 0,
            //             // Set the text color of the button
            //             padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            //             // Set the padding around the button content
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(
            //                   7), // Set the border radius of the button
            //             ),
            //           ),
            //           child: Icon(Icons.arrow_forward, size: 30,)),
            //       Row(
            //         children: [
            //           Text(
            //               "Or",
            //               style: context.text.titleMedium?.copyWith(color: AppColors.customWhiteTextColor, fontSize: 16.sp)
            //
            //           ),
            //           TextButton(
            //             onPressed: (){
            //
            //             },
            //             child: Text(
            //                 "Sign Up",
            //                 style: context.text.titleMedium?.copyWith(color: AppColors.customWhiteTextColor, fontSize: 16.sp)
            //
            //             ),
            //           ),
            //         ],
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
