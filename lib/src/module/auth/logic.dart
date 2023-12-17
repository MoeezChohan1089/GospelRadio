import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/globalVariable/global_variable.dart';
import 'package:gosperadioapp/src/module/auth/api_service/api_services.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../home/view.dart';
import 'api_service/getData.dart';
import 'components/forgotVerfityOTP.dart';
import 'components/login.dart';
import 'components/newPassword.dart';
import 'components/otp.dart';
import 'components/singInOTP.dart';
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
  TextEditingController OTPSignInController = TextEditingController();
  TextEditingController OTPSignInController1 = TextEditingController();
  TextEditingController OTPSignInController2 = TextEditingController();
  TextEditingController OTPSignInController3 = TextEditingController();
  TextEditingController forgotOTPController = TextEditingController();
  TextEditingController forgotOTPController1 = TextEditingController();
  TextEditingController forgotOTPController2 = TextEditingController();
  TextEditingController forgotOTPController3 = TextEditingController();
  TextEditingController emailSignInController = TextEditingController();
  TextEditingController passwordSignInController = TextEditingController();
  TextEditingController emailForgotController = TextEditingController();
  TextEditingController forgotNewPasswordController = TextEditingController();
  TextEditingController forgotConfirmNewPasswordController =
      TextEditingController();
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyValue1 = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyValueSignInOTP = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyValue3 = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyValue4 = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyValue5 = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyValue6 = GlobalKey<FormState>();
  RxBool obscureText = true.obs;
  RxBool obscureText2 = true.obs;
  RxBool obscureText3 = true.obs;
  RxString newPassToken = ''.obs;

  RxList<TextEditingController> listOfController =
      RxList<TextEditingController>([]);

  createNewUser({required BuildContext context}) async {
    customLoaderGlobal.showLoader(context);

    if (await createSignupApiService(
      context: context,
      // user: userGet,
      name: nameController.text,
      password: passwordController.text,
      email: emailController.text,
    )) {
      ///----- API Successful

      customLoaderGlobal.hideLoader();
      final snackBar = SnackBar(
        content: Text(
          'OTP has been sent in your email.',
          style: context.text.bodyMedium
              ?.copyWith(fontSize: 18.sp, color: Colors.white),
        ),
        margin: EdgeInsets.only(bottom: 8),
        behavior: SnackBarBehavior.floating,
      );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // Get.snackbar('Message', 'OTP has been sent in your email.',
      //     backgroundColor: Colors.black,
      //     colorText: AppColors.customWhiteTextColor);
      Get.off(() => OTPScreen(
            email: emailController.text,
          ));
      // nameController.clear();
      // passwordController.clear();
      // emailController.clear();
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
        otp3: OTPController3.text)) {
      ///----- API Successful

      customLoaderGlobal.hideLoader();

      print("value of OTP1: ${OTPController.text}");
      print("value of OTP2: ${OTPController1.text}");
      print("value of OTP3: ${OTPController2.text}");
      print("value of OTP4: ${OTPController3.text}");
      Get.off(() => LoginScreen());
    } else {
      print("error");
      customLoaderGlobal.hideLoader();
      final snackBar = SnackBar(
        content: Text(
          'Error in creating account',
          style: context.text.bodyMedium
              ?.copyWith(fontSize: 18.sp, color: Colors.white),
        ),
        margin: EdgeInsets.only(bottom: 8),
        behavior: SnackBarBehavior.floating,
      );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  signInUser({required BuildContext context}) async {
    customLoaderGlobal.showLoader(context);

    if (await signInApiService(
        // user: userGet,
        email: emailSignInController.text,
        password: passwordSignInController.text)) {
      ///----- API Successful

      customLoaderGlobal.hideLoader();
      final snackBar = SnackBar(
        content: Text(
          'OTP has been sent in your email..',
          style: context.text.bodyMedium
              ?.copyWith(fontSize: 18.sp, color: Colors.white),
        ),
        margin: EdgeInsets.only(bottom: 8),
        behavior: SnackBarBehavior.floating,
      );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // Get.snackbar('Message', 'Login Successfully..',
      //     backgroundColor: Colors.black,
      //     colorText: AppColors.customWhiteTextColor);
      Get.to(() => OTPSignInScreen(
        email: emailSignInController.text,
      ));
    } else {
      print("error");
      customLoaderGlobal.hideLoader();
      final snackBar = SnackBar(
        content: Text(
          'Your email or password is wrong.',
          style: context.text.bodyMedium
              ?.copyWith(fontSize: 18.sp, color: Colors.white),
        ),
        margin: EdgeInsets.only(bottom: 8),
        behavior: SnackBarBehavior.floating,
      );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // Get.snackbar('Message', '',
      //     backgroundColor: Colors.black,
      //     colorText: AppColors.customWhiteTextColor);
    }
  }

  signinOTPUser({required BuildContext context, required String email}) async {
    customLoaderGlobal.showLoader(context);
    print("value of OTP1: ${OTPSignInController.text}");
    print("value of OTP2: ${OTPSignInController1.text}");
    print("value of OTP3: ${OTPSignInController2.text}");
    print("value of OTP4: ${OTPSignInController3.text}");
    if (await otpSignInApiService(
      // user: userGet,
        email: email,
        otp: OTPSignInController.text,
        otp1: OTPSignInController1.text,
        otp2: OTPSignInController2.text,
        otp3: OTPSignInController3.text)) {
      ///----- API Successful

      customLoaderGlobal.hideLoader();

      print("value of OTP1: ${OTPSignInController.text}");
      print("value of OTP2: ${OTPSignInController1.text}");
      print("value of OTP3: ${OTPSignInController2.text}");
      print("value of OTP4: ${OTPSignInController3.text}");
      emailSignInController.clear();
      passwordSignInController.clear();
      Get.off(() => HomePage());
      final snackBar = SnackBar(
        content: Text(
          'Login Successfully..',
          style: context.text.bodyMedium
              ?.copyWith(fontSize: 18.sp, color: Colors.white),
        ),
        margin: EdgeInsets.only(bottom: 8),
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      print("error");
      customLoaderGlobal.hideLoader();
      final snackBar = SnackBar(
        content: Text(
          'Error in creating account',
          style: context.text.bodyMedium
              ?.copyWith(fontSize: 18.sp, color: Colors.white),
        ),
        margin: EdgeInsets.only(bottom: 8),
        behavior: SnackBarBehavior.floating,
      );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  forgotUser({required BuildContext context}) async {
    customLoaderGlobal.showLoader(context);

    if (await forgotApiService(
        // user: userGet,
        context: context,
        email: emailForgotController.text)) {
      ///----- API Successful

      customLoaderGlobal.hideLoader();
      // Get.snackbar('Message', 'Password reset link has been sent.',
      //     backgroundColor: Colors.black,
      //     colorText: AppColors.customWhiteTextColor);
      emailForgotController.clear();
      Get.off(() => ForgotOTPScreen());
    } else {
      print("error");
      final snackBar = SnackBar(
        content: Text(
          'Your email is wrong',
          style: context.text.bodyMedium?.copyWith(fontSize: 18.sp),
        ),
        margin: EdgeInsets.only(bottom: 8),
        behavior: SnackBarBehavior.floating,
      );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      customLoaderGlobal.hideLoader();
    }
  }

  forgotOTPUser({required BuildContext context}) async {
    customLoaderGlobal.showLoader(context);

    ApiResponse apiResponse = await forgotOTPApiService(
        otp: forgotOTPController.text,
        otp1: forgotOTPController1.text,
        otp2: forgotOTPController2.text,
        otp3: forgotOTPController3.text);

    if (apiResponse.dataPass.isNotEmpty) {
      ///----- API Successful

      customLoaderGlobal.hideLoader();
      Get.off(() => NewPassordScreen());
      newPassToken.value = apiResponse.dataPass;
    } else {
      customLoaderGlobal.hideLoader();
      final snackBar = SnackBar(
        content: Text(
          'Your OTP is wrong',
          style: context.text.bodyMedium?.copyWith(fontSize: 18.sp),
        ),
        margin: EdgeInsets.only(bottom: 8),
        behavior: SnackBarBehavior.floating,
      );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print("error");
    }
  }

  forgotResetPassword({required BuildContext context}) async {
    customLoaderGlobal.showLoader(context);
    print("token after forgot: ${newPassToken.value}");
    final response = await forgotApiResetPassword(
        token: newPassToken.value,
        newPassword: forgotNewPasswordController.text,
        confirmPassword: forgotConfirmNewPasswordController.text);
    forgotNewPasswordController.clear();
    forgotConfirmNewPasswordController.clear();
    customLoaderGlobal.hideLoader();
    final snackBar = SnackBar(
      content: Text(
        'Your Password has been updated..',
        style: context.text.bodyMedium?.copyWith(fontSize: 18.sp),
      ),
      margin: EdgeInsets.only(bottom: 8),
      behavior: SnackBarBehavior.floating,
    );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Get.off(() => LoginScreen());
  }
}
