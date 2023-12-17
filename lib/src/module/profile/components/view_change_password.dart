import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gosperadioapp/src/custom_widgets/customTextField.dart';
import 'package:gosperadioapp/src/utils/constants/colors.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../../custom_widgets/custom_elevated.dart';
import '../../../globalVariable/database_controller.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../logic.dart';

class ViewChangePasswordScreen extends StatefulWidget {
  const ViewChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ViewChangePasswordScreen> createState() =>
      _ViewChangePasswordScreenState();
}

class _ViewChangePasswordScreenState extends State<ViewChangePasswordScreen> {
  final logic = Get.put(ProfileLogic());
  String? password;
  String? confirmPassword;

  final logic2 = Get.put(ProfileLogic());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      logic.personalInformation.value = LocalDatabase.to.box.read('userInfo');
    });
    // logic.getDynamicHomeView();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.custombackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.custombackgroundColor,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            "Change Password",
            style: context.text.bodySmall?.copyWith(
                color: AppColors.customWhiteTextColor, fontSize: 18.sp),
          ),
          leadingWidth: 180.w,
          leading: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                    // if(bottomNav.isFancyDrawer.isTrue){
                    //   bottomNav.advancedDrawerController.showDrawer();
                    // } else {
                    //   bottomNav.navScaffoldKey.currentState?.openDrawer();
                    // }
                  },
                  icon: Icon(Icons.arrow_back, color: AppColors.customBlackTextColor,)
              ),
              Container(
                // width: 80,
                // // color: Colors.amber,
                // height: 80,
                // margin: EdgeInsets.only(top: 35.h),
                  child: Image.asset(
                    "assets/images/hgc.png",
                    fit: BoxFit.cover,
                    width: 120.w,
                    // width: 150,
                  )),
            ],
          ),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         // Get.to(() => CartPage());
          //       },
          //       icon: Icon(Icons.search, color: AppColors.customBlackTextColor,)
          //   ),
          // ],
        ),
        body: Form(
          key: logic.editChangePasswordFormKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: pageMarginHorizontal, vertical: pageMarginVertical),
            child: Column(
              children: [
                30.heightBox,
                Text("Enter your current password \nto upgrade the password",
                  textAlign: TextAlign.center,
                  style: context.text.bodyMedium
                      ?.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.customWhiteTextColor
                  ),),
                40.heightBox,
                Obx(() {
                  return CustomTextFieldC(
                    controller: logic.oldPassController,
                    hintText: "Old Password",
                    obscureText: logic.obscureText.value,
                    onChanged: (e) {
                      // logic.editEmailController.text != logic.personalInformation.value[0]['email']?
                      // logic.isChange.value = true:logic.isChange.value = false;
                      setState(() {
                        logic.editPassController.text ==
                            logic.editConfirmController.text ?
                        logic.isChange.value = true : logic.isChange.value =
                        false;
                      });
                    },
                    validation: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        logic.obscureText.value ? Icons.visibility : Icons
                            .visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        logic.obscureText.value = !logic.obscureText.value;
                      },
                    ),
                  );
                }),
                15.heightBox,
                Obx(() {
                  return CustomTextFieldC(
                    controller: logic.editPassController,
                    hintText: "Password",
                    obscureText: logic.obscureText1.value,
                    onChanged: (e) {
                      // logic.editEmailController.text != logic.personalInformation.value[0]['email']?
                      // logic.isChange.value = true:logic.isChange.value = false;
                      setState(() {
                        logic.editPassController.text ==
                            logic.editConfirmController.text ?
                        logic.isChange.value = true : logic.isChange.value =
                        false;
                      });
                    },
                    validation: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        logic.obscureText1.value ? Icons.visibility : Icons
                            .visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        logic.obscureText1.value = !logic.obscureText1.value;
                      },
                    ),
                  );
                }),
                15.heightBox,
                Obx(() {
                  return CustomTextFieldC(
                    controller: logic.editConfirmController,
                    hintText: "Confirm Password",
                    obscureText: logic.obscureText2.value,
                    onChanged: (e) {
                      setState(() {
                        logic.editPassController.text ==
                            logic.editConfirmController.text ?
                        logic.isChange.value = true : logic.isChange.value =
                        false;
                      });
                    },
                    validation: (value) {
                      confirmPassword = value;
                      if (value!.isEmpty) {
                        return 'Confirm Password is required';
                      }
                      if (logic.editConfirmController.text !=
                          logic.editPassController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        logic.obscureText2.value ? Icons.visibility : Icons
                            .visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        logic.obscureText2.value = !logic.obscureText2.value;
                      },
                    ),
                  );
                }),


                30.heightBox,

                SizedBox(
                  width: double.maxFinite,
                  child: Obx(() {
                    return GlobalElevatedButton(
                      text: "Update Password",
                      onPressed: () {
                        if (logic.oldPassController.text.isNotEmpty && logic.editPassController.text.isNotEmpty &&
                            logic.editConfirmController.text.isNotEmpty) {
                          HapticFeedback.lightImpact();
                          logic.updateNewProfilePassword(context: context);
                        } else {
                          // Profile information is the same, show message
                          // showToastMessage(message: "Your profile is the same. No changes were made.");
                        }
                      },
                      isLoading: logic.isProcessing.value,
                      isDisable: (logic.editPassController.text.isNotEmpty &&
                          logic.editConfirmController.text.isNotEmpty &&
                          logic.isChange.value) ? false : true,
                    );
                  }),


                  // ElevatedButton(
                  //     onPressed: () async {
                  //       if (logic.editFirstController.text != personalInformation[0]['firstname'] ||
                  //           logic.editLastController.text != personalInformation[0]['lastname'] ||
                  //           logic.editEmailController.text != personalInformation[0]['email']) {
                  //         // Perform update logic here
                  //         // Vibration.vibrate(duration: 100);
                  //         HapticFeedback.lightImpact();
                  //         logic.updateNewProfile(context: context);
                  //       } else {
                  //         // Profile information is the same, show message
                  //         showToastMessage(message: "Your profile is the same. No changes were made.");
                  //       }
                  //       // ProductDetailLogic.to.addProductToCart();
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.black,
                  //       foregroundColor: Colors.white,
                  //       elevation: 0,
                  //       // Set the text color of the button
                  //       padding: const EdgeInsets.all(8),
                  //       // Set the padding around the button content
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(
                  //             0), // Set the border radius of the button
                  //       ),
                  //     ),
                  //     child: Text("Edit Profile",
                  //       style: context.text.bodyMedium!.copyWith(
                  //           color: Colors.white, height: 1.1),)),
                ),


                // Padding(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: pageMarginHorizontal,
                //       vertical: pageMarginVertical * 2
                //   ),
                //   child: InkWell(
                //     onTap: () {
                //       alertShowDeleteDialogue(
                //           context: context, deleteAcc: logic.infor.value);
                //       // logic.deleteUser(context: context, id: );
                //     },
                //     child: Container(
                //       decoration: const BoxDecoration(
                //           border: Border(bottom: BorderSide(color: AppColors.appPriceRedColor))
                //       ),
                //       padding: EdgeInsets.symmetric(
                //         vertical: pageMarginVertical / 2,
                //       ),
                //       child: Text("Delete Account",
                //         textAlign: TextAlign.center,
                //         style: context.text.bodyMedium?.copyWith(color: AppColors.appPriceRedColor, fontSize: 14.sp),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        )
    );
  }
}