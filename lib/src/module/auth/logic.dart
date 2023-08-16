import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/globalVariable/global_variable.dart';
import 'package:gosperadioapp/src/module/auth/api_service/api_services.dart';

import '../../custom_widgets/customDialogue.dart';
import '../../utils/constants/colors.dart';
import '../home/view.dart';
import 'api_service/getData.dart';
import 'components/forgotVerfityOTP.dart';
import 'components/login.dart';
import 'components/newPassword.dart';
import 'components/otp.dart';
import 'state.dart';

class AuthLogic extends GetxController {
  static AuthLogic get to => Get.find();
  final AuthState state = AuthState();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController OTPController = TextEditingController();
  TextEditingController OTPController1 = TextEditingController();
  TextEditingController OTPController2 = TextEditingController();
  TextEditingController OTPController3 = TextEditingController();
  TextEditingController forgotOTPController = TextEditingController();
  TextEditingController forgotOTPController1 = TextEditingController();
  TextEditingController forgotOTPController2 = TextEditingController();
  TextEditingController forgotOTPController3 = TextEditingController();
  TextEditingController emailSignInController = TextEditingController();
  TextEditingController passwordSignInController = TextEditingController();
  TextEditingController emailForgotController = TextEditingController();
  GlobalKey<FormState> formKeyValue = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyValue1 = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyValue2 = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyValue3 = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyValue4 = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyValue5 = GlobalKey<FormState>();
  RxBool obscureText = true.obs;
  RxString newPassGet = ''.obs;

  RxList<TextEditingController> listOfController = RxList<TextEditingController>([]);

  createNewUser({required BuildContext context}) async {
    customLoaderGlobal.showLoader(context);

    if (await createSignupApiService(
      // user: userGet,
        name: nameController.text,
        password: passwordController.text,
        email: emailController.text,
        )) {
      ///----- API Successful

      customLoaderGlobal.hideLoader();
      Get.to(()=>OTPScreen(email: emailController.text,));
    } else {
      // ssdf@gmail.com
      // Get.showSnackbar(
      //   const GetSnackBar(
      //     isDismissible: true,
      //     message: 'Error in creating account.',
      //     duration: Duration(seconds: 2),
      //     backgroundColor: Colors.black,
      //   ),
      // );
      print("error");
      customLoaderGlobal.hideLoader();
    }
  }

  createOTPUser({required BuildContext context, required String email}) async {
    customLoaderGlobal.showLoader(context);
    print("value of OTP1: ${OTPController.text}");
    print("value of OTP2: ${OTPController1.text}");
    print("value of OTP3: ${OTPController2.text}");
    print("value of OTP4: ${OTPController3.text}");
    if (await otpRegisterApiService(
      // user: userGet,
      email: email,
      otp: OTPController.text,
      otp1: OTPController1.text,
      otp2: OTPController2.text,
      otp3: OTPController3.text
    )) {
      ///----- API Successful

      customLoaderGlobal.hideLoader();

      print("value of OTP1: ${OTPController.text}");
      print("value of OTP2: ${OTPController1.text}");
      print("value of OTP3: ${OTPController2.text}");
      print("value of OTP4: ${OTPController3.text}");
      Get.off(()=>LoginScreen());
    } else {
      // Get.showSnackbar(
      //   const GetSnackBar(
      //     isDismissible: true,
      //     message: 'Error in creating account.',
      //     duration: Duration(seconds: 2),
      //     backgroundColor: Colors.black,
      //   ),
      // );
      print("error");
      customLoaderGlobal.hideLoader();
    }
  }

  signInUser({required BuildContext context}) async {
    customLoaderGlobal.showLoader(context);

    if (await signInApiService(
      // user: userGet,
        email: emailSignInController.text,
        password: passwordSignInController.text
    )) {
      ///----- API Successful

      customLoaderGlobal.hideLoader();
      Get.off(()=>HomePage());
    } else {
      print("error");
      customLoaderGlobal.hideLoader();
    }
  }

  forgotUser({required BuildContext context}) async {
    customLoaderGlobal.showLoader(context);

    if (await forgotApiService(
      // user: userGet,
        email: emailForgotController.text
    )) {
      ///----- API Successful

      customLoaderGlobal.hideLoader();
     Get.off(()=>ForgotOTPScreen());
    } else {
      print("error");
      customLoaderGlobal.hideLoader();
    }
  }

  forgotOTPUser({required BuildContext context}) async {
    customLoaderGlobal.showLoader(context);

    ApiResponse apiResponse = await forgotOTPApiService(
      otp: forgotOTPController.text,
      otp1: forgotOTPController1.text,
      otp2: forgotOTPController2.text,
      otp3: forgotOTPController3.text
    );

    if (apiResponse.dataPass.isNotEmpty) {
      ///----- API Successful

      customLoaderGlobal.hideLoader();
      Get.off(() => LoginScreen());
      showCustomDialog(context, apiResponse.dataPass);
    } else {
      print("error");
      customLoaderGlobal.hideLoader();
    }
  }
}
