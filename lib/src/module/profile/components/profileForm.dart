import 'package:date_picker_timeline/extra/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gosperadioapp/src/custom_widgets/customTextField.dart';
import 'package:gosperadioapp/src/module/profile/logic.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../../custom_widgets/custom_elevated.dart';
import '../../../globalVariable/database_controller.dart';
import '../../../utils/constants/margins_spacnings.dart';
import 'OTPDelete.dart';
import 'view_change_password.dart';

class EditProfileFormScreen extends StatefulWidget {
  const EditProfileFormScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileFormScreen> createState() => _EditProfileFormScreenState();
}

class _EditProfileFormScreenState extends State<EditProfileFormScreen> {
  final logic = Get.put(ProfileLogic());
  String? password;
  String? confirmPassword;

  final logic2 = Get.put(ProfileLogic());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      logic.personalInformation.value = LocalDatabase.to.box.read('userInfo');
      if (logic.personalInformation.value.isNotEmpty) {
        logic.editNameController.text =
        logic.personalInformation.value[0]['nameProfile'];
        logic.editEmailController.text =
        logic.personalInformation.value[0]['emailProfile'];
        logic.editAboutController.text =
        logic.personalInformation.value[0]['aboutProfile'];
      }
    });
    // logic.getDynamicHomeView();
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Form(
        key: logic.editProfileFormKey,
        child: Padding(
          padding: EdgeInsets.symmetric(

              horizontal: pageMarginHorizontal, vertical: pageMarginVertical),
          child: Column(
            children: [
              20.heightBox,

              CustomTextFieldC(
                controller: logic.editNameController,
                hintText: "Full Name",
                onChanged: (e) {
                  (logic.editNameController.text !=
                      logic.personalInformation.value[0]['nameProfile']) ?
                  logic.isChange.value = true : logic.isChange.value = false;
                },
                validation: (value) {
                  if (value!.isEmpty) {
                    return 'First Name is required';
                  }
                  return null;
                },
              ),
              15.heightBox,
              CustomTextFieldC(
                controller: logic.editEmailController,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
                onChanged: (e) {
                  logic.editEmailController.text != logic.personalInformation
                      .value[0]['emailProfile'] ?
                  logic.isChange.value = true : logic.isChange.value = false;
                },
                validation: (value) {
                  if (value!.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
              ),

              15.heightBox,
              CustomTextFieldC(
                controller: logic.editAboutController,
                maxLines: 3,
                hintText: "About",
                keyboardType: TextInputType.emailAddress,
                onChanged: (e) {
                  logic.editAboutController.text != logic.personalInformation
                      .value[0]['aboutProfile'] ?
                  logic.isChange.value = true : logic.isChange.value = false;
                },
                validation: (value) {
                  if (value!.isEmpty) {
                    return 'About is required';
                  }
                  return null;
                },
              ),
              30.heightBox,

              SizedBox(
                width: double.maxFinite,
                child: GlobalElevatedButton(
                  text: "Edit Profile",
                  onPressed: () {
                    if (logic.editNameController.text !=
                        logic.personalInformation.value[0]['nameProfile'] ||
                        logic.editEmailController.text !=
                            logic.personalInformation.value[0]['emailProfile'] ||
                        logic.editAboutController.text !=
                            logic.personalInformation.value[0]['aboutProfile']
                    ) {
                      logic.updateNewProfile(context: context);
                    } else {
                      // Profile information is the same, show message
                      print('fffff');
                    }
                  },
                  isLoading: logic.isProcessing.value,
                  isDisable: logic.isChange.value ? false : true,
                ),


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


              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: pageMarginHorizontal / 2,
                    vertical: pageMarginVertical + 4
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(ViewChangePasswordScreen());
                      },
                      child: Text("Change Password",
                        style: context.text.bodyMedium
                            ?.copyWith(
                            color: Colors.white
                        ),),
                    ),
                    GestureDetector(
                      onTap: () {
                        logic.deleteAccount(context: context);
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Text("Delete Account",
                          style: context.text.bodyMedium
                              ?.copyWith(
                              color: Colors.white
                          ),),
                      ),
                    ),
                  ],
                ),
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
      );
    });
  }
}