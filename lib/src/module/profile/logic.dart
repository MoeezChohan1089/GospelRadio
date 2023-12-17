import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/module/home/view.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../globalVariable/database_controller.dart';
import 'api_service/api_service.dart';
import 'components/OTPDelete.dart';
import 'state.dart';

class ProfileLogic extends GetxController {
  final ProfileState state = ProfileState();

  GlobalKey<FormState> editProfileFormKey = GlobalKey();
  GlobalKey<FormState> editChangePasswordFormKey = GlobalKey();
  GlobalKey<FormState> deleteFormKey = GlobalKey();

  TextEditingController editNameController = TextEditingController();
  TextEditingController editEmailController = TextEditingController();
  TextEditingController editAboutController = TextEditingController();
  TextEditingController oldPassController = TextEditingController();
  TextEditingController editPassController = TextEditingController();
  TextEditingController editConfirmController = TextEditingController();
  TextEditingController OTPDeleteController = TextEditingController();
  TextEditingController OTPDeleteController1 = TextEditingController();
  TextEditingController OTPDeleteController2 = TextEditingController();
  TextEditingController OTPDeleteController3 = TextEditingController();

  RxBool obscureText = false.obs;
  RxBool obscureText1 = true.obs;
  RxBool obscureText2 = true.obs;
  RxBool isChange = false.obs;
  RxList infor = [].obs;
  RxBool isProcessing = false.obs;
  RxList personalInformation = [].obs;

  @override
  void onInit() {
    super.onInit();
    infor.value = LocalDatabase.to.box.read('userInfo') ?? [];
    update();
  }

  updateNewProfile({required BuildContext context}) async {
    // customLoader.showLoader(context);

    isProcessing.value = true;

    final updatedName = editNameController.text;
    final updatedEmail = editEmailController.text;
    final updatedAbout = editAboutController.text;

    if (await updateProfileService(
        name: updatedName,
        email: updatedEmail,
        about: updatedAbout
    )) {
      final snackBar = SnackBar(
        content: Text(
          'Profile updated successfully',
          style: context.text.bodyMedium
              ?.copyWith(fontSize: 18.sp, color: Colors.white),
        ),
        margin: EdgeInsets.only(bottom: 8),
        behavior: SnackBarBehavior.floating,
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
      List userInfo = [{
        "nameProfile": "${editNameController.text}",
        "emailProfile": "${editEmailController.text}",
        "aboutProfile": "${editAboutController.text}"
      }
      ];
      personalInformation.value = userInfo;
      LocalDatabase.to.box.write("userInfo", personalInformation.value);

      isProcessing.value = false;
      isChange.value = false;

      // customLoader.hideLoader();
      infor.value = LocalDatabase.to.box.read('userInfo') ?? [];
      // ProfileLogic.to.infor.value = infor.value;

      update();
    } else {
      // showToastMessage(message: "Error in updating profile.");
      final snackBar = SnackBar(
        content: Text(
          'Error in updating profile.',
          style: context.text.bodyMedium
              ?.copyWith(fontSize: 18.sp, color: Colors.white),
        ),
        margin: EdgeInsets.only(bottom: 8),
        behavior: SnackBarBehavior.floating,
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
      // customLoader.hideLoader();
      isProcessing.value = false;
    }
  }

  updateNewProfilePassword({required BuildContext context}) async {
    // customLoader.showLoader(context);

    isProcessing.value = true;

    if (await updatePasswordService(
        old: oldPassController.text,
        newPassword: editPassController.text,
        confirmPassword: editConfirmController.text)) {
      // shopifyAuth.signInWithEmailAndPassword(email: email, password: editPassController.text,);
      oldPassController.clear();
      editPassController.clear();
      editConfirmController.clear();
      final snackBar = SnackBar(
        content: Text(
          'Password updated successfully',
          style: context.text.bodyMedium
              ?.copyWith(fontSize: 18.sp, color: Colors.white),
        ),
        margin: EdgeInsets.only(bottom: 8),
        behavior: SnackBarBehavior.floating,
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
      isProcessing.value = false;
      isChange.value = false;
      update();
    } else {
      final snackBar = SnackBar(
        content: Text(
          'Error in updating password.',
          style: context.text.bodyMedium
              ?.copyWith(fontSize: 18.sp, color: Colors.white),
        ),
        margin: EdgeInsets.only(bottom: 8),
        behavior: SnackBarBehavior.floating,
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
      // customLoader.hideLoader();
      isProcessing.value = false;
    }
  }

  deleteAccount({required BuildContext context}) async {
    isProcessing.value = true;

    if (await deleteAccountService(
        personalInformation.value[0]['email'])) {
      // shopifyAuth.signInWithEmailAndPassword(email: email, password: editPassController.text,);
      final snackBar = SnackBar(
        content: Text(
          'OTP has been sent..',
          style: context.text.bodyMedium
              ?.copyWith(fontSize: 18.sp, color: Colors.white),
        ),
        margin: EdgeInsets.only(bottom: 8),
        behavior: SnackBarBehavior.floating,
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
      isProcessing.value = false;
      isChange.value = false;
      Get.to(OTPDeleteScreen(email: personalInformation.value[0]['emailProfile'],));
      update();
    } else {
      final snackBar = SnackBar(
        content: Text(
          'Error in updating password.',
          style: context.text.bodyMedium
              ?.copyWith(fontSize: 18.sp, color: Colors.white),
        ),
        margin: EdgeInsets.only(bottom: 8),
        behavior: SnackBarBehavior.floating,
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
      // customLoader.hideLoader();
      isProcessing.value = false;
    }
  }

  deleteOTPAccount({required BuildContext context, email}) async {
    isProcessing.value = true;

    if (await deleteOTPService(
        email,
        OTPDeleteController.text,
      OTPDeleteController1.text,
      OTPDeleteController2.text,
      OTPDeleteController3.text
    )) {
      // shopifyAuth.signInWithEmailAndPassword(email: email, password: editPassController.text,);
      final snackBar = SnackBar(
        content: Text(
          'Delete account permanently',
          style: context.text.bodyMedium
              ?.copyWith(fontSize: 18.sp, color: Colors.white),
        ),
        margin: EdgeInsets.only(bottom: 8),
        behavior: SnackBarBehavior.floating,
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
      isProcessing.value = false;
      isChange.value = false;
      LocalDatabase.to.box.remove('token');
      Get.off(HomePage());
      update();
    } else {
      final snackBar = SnackBar(
        content: Text(
          'Error in deleting account.',
          style: context.text.bodyMedium
              ?.copyWith(fontSize: 18.sp, color: Colors.white),
        ),
        margin: EdgeInsets.only(bottom: 8),
        behavior: SnackBarBehavior.floating,
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
      // customLoader.hideLoader();
      isProcessing.value = false;
    }
  }
}
