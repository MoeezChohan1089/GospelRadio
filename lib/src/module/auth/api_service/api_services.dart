import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gosperadioapp/src/globalVariable/database_controller.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../globalVariable/global_variable.dart';
import 'getData.dart';

createSignupApiService(
    {required BuildContext context,
    required String name,
    email,
    password}) async {
  try {
    Dio dio = Dio();

    final data = {
      'name': name,
      'email': email,
      'username': name,
      'password': password,
      'password_confirmation': password
    };

    final response = await dio.post(
      'https://hgcradio.org/api/auth/register',
      data: data,
    );

    Map<String, dynamic> responseData = response.data;

    // Handle the response
    if (response.statusCode == 200 && responseData["status"] == "Success") {
      // Request succeeded

      // Process the response data as needed

      log("==>> Create SignUp response data -> $responseData =====");
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('email', name);
      sp.setString('name', email);

      return true;
    } else if (response.statusCode == 401 &&
        responseData["status"] == "Error") {
      // Request failed
      final snackBar = SnackBar(
        content: Text(
          '${responseData['message']['email']}',
          style: context.text.bodyMedium
              ?.copyWith(fontSize: 18.sp, color: Colors.white),
        ),
        margin: EdgeInsets.only(bottom: 8),
        behavior: SnackBarBehavior.floating,
      );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
  } catch (error) {
    // Handle any Dio errors or exceptions
    debugPrint("==>> SIGN UP ERROR : $error =====");
    final snackBar = SnackBar(
      content: Text(
        'Something went wrong..',
        style: context.text.bodyMedium
            ?.copyWith(fontSize: 18.sp, color: Colors.white),
      ),
      margin: EdgeInsets.only(bottom: 8),
      behavior: SnackBarBehavior.floating,
    );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return false;
  }
}

otpRegisterApiService({required String email, otp, otp1, otp2, otp3}) async {
  try {
    Dio dio = Dio();

    final data = {'email': email, 'otp': '$otp$otp1$otp2$otp3'};

    final response = await dio.post(
      'https://hgcradio.org/api/auth/register/verification',
      data: data,
    );

    Map<String, dynamic> responseData = response.data;

    // Handle the response
    if (response.statusCode == 200 && responseData["status"] == "Success") {
      // Request succeeded

      // Process the response data as needed

      log("==>> Create OTP response data -> $responseData =====");

      return true;
    } else {
      // Request failed
      debugPrint("==>> OTP ERROR : Not 200 --> ${response.data} =====");
      return false;
    }
  } catch (error) {
    // Handle any Dio errors or exceptions
    debugPrint("==>> OTP ERROR : $error =====");
    return false;
  }
}

signInApiService({required String email, password}) async {
  try {
    Dio dio = Dio();

    final data = {'email': email, 'password': password};

    final response = await dio.post(
      'https://hgcradio.org/api/auth/login',
      data: data,
    );

    Map<String, dynamic> responseData = response.data;

    // Handle the response
    if (response.statusCode == 200 && responseData["status"] == "Success") {
      // Request succeeded

      // Process the response data as needed

      return true;
    } else {
      // Request failed
      debugPrint("==>> Sign In ERROR : Not 200 --> ${response.data} =====");
      return false;
    }
  } catch (error) {
    // Handle any Dio errors or exceptions
    debugPrint("==>> Sign In ERROR : $error =====");
    return false;
  }
}

otpSignInApiService({required String email, otp, otp1, otp2, otp3}) async {
  try {
    SharedPreferences sp = await SharedPreferences.getInstance();
    Dio dio = Dio();

    final data = {'email': email, 'otp': '$otp$otp1$otp2$otp3'};

    final response = await dio.post(
      'https://hgcradio.org/api/auth/login/otp',
      data: data,
    );

    Map<String, dynamic> responseData = response.data;

    // Handle the response
    if (response.statusCode == 200 && responseData["status"] == "Success") {
      // Request succeeded

      // Process the response data as needed

      log("==>> Sign In response data -> $responseData =====");
      sp.setString('token', responseData['data']['token']);

      // LocalDatabase.to.box.write('name', responseData['data']['user']['name']);
      // LocalDatabase.to.box
      //     .write('email', responseData['data']['user']['email']);

      List userInfo = [{
        "nameProfile": "${responseData['data']['user']['name']}",
  "emailProfile": "${responseData['data']['user']['email']}",
  "aboutProfile": "${responseData['data']['user']['about']}"
}];
      LocalDatabase.to.box.write("userInfo", userInfo);
      LocalDatabase.to.box.write('token', responseData['data']['token']);

      sp.setBool('islogin', true);

      return true;
    } else {
      // Request failed
      debugPrint("==>> OTP ERROR : Not 200 --> ${response.data} =====");
      return false;
    }
  } catch (error) {
    // Handle any Dio errors or exceptions
    debugPrint("==>> OTP ERROR : $error =====");
    return false;
  }
}

forgotApiService({required BuildContext context, required String email}) async {
  try {
    Dio dio = Dio();

    final data = {
      'email': email,
    };

    final response = await dio.post(
      'https://hgcradio.org/api/auth/forget-password',
      data: data,
    );

    Map<String, dynamic> responseData = response.data;

    // Handle the response
    if (response.statusCode == 200 && responseData["status"] == "Success") {
      // Request succeeded

      // Process the response data as needed

      log("==>> Forgot response data -> $responseData =====");

      final snackBar = SnackBar(
        content: Text(
          '${responseData['data']}',
          style: context.text.bodyMedium
              ?.copyWith(fontSize: 18.sp, color: Colors.white),
        ),
        margin: EdgeInsets.only(bottom: 8),
        behavior: SnackBarBehavior.floating,
      );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return true;
    } else {
      // Request failed
      debugPrint("==>> Forgot ERROR : Not 200 --> ${response.data} =====");
      return false;
    }
  } catch (error) {
    // Handle any Dio errors or exceptions
    debugPrint("==>> Forgot ERROR : $error =====");
    return false;
  }
}

Future<ApiResponse> forgotOTPApiService(
    {required String otp, otp1, otp2, otp3}) async {
  try {
    Dio dio = Dio();

    final data = {
      'otp': '$otp$otp1$otp2$otp3',
    };

    final response = await dio.post(
      'https://hgcradio.org/api/auth/verify-otp',
      data: data,
    );

    Map<String, dynamic> responseData = response.data;

    // Handle the response
    if (response.statusCode == 200 && responseData["status"] == "Success") {
      // Request succeeded

      // Process the response data as needed

      log("==>> Forgot OTP response data -> $responseData =====");

      return ApiResponse(dataPass: responseData['data']);
    } else {
      // Request failed
      debugPrint("==>> Forgot OTP ERROR : Not 200 --> ${response.data} =====");
      return ApiResponse(dataPass: '');
    }
  } catch (error) {
    // Handle any Dio errors or exceptions
    debugPrint("==>> Forgot OTP ERROR : $error =====");
    return ApiResponse(dataPass: '');
  }
}

forgotApiResetPassword(
    {required String token,
    required String newPassword,
    required String confirmPassword}) async {
  try {
    Dio dio = Dio();

    final data = {
      'token': token,
      'password': newPassword,
      'password_confirmation': confirmPassword
    };

    final response = await dio.post(
      'https://hgcradio.org/api/auth/reset-password',
      data: data,
    );

    Map<String, dynamic> responseData = response.data;

    // Handle the response
    if (response.statusCode == 200 && responseData["status"] == "Success") {
      // Request succeeded

      // Process the response data as needed

      log("==>> Rest Password response data -> $responseData =====");
      // Get.snackbar('Message', '${responseData['data']}',
      //     backgroundColor: Colors.black,
      //     colorText: AppColors.customWhiteTextColor);

      return true;
    } else {
      // Request failed
      debugPrint("==>> Forgot ERROR : Not 200 --> ${response.data} =====");
      return false;
    }
  } catch (error) {
    // Handle any Dio errors or exceptions
    debugPrint("==>> Forgot ERROR : $error =====");
    return false;
  }
}

getUserProfileService() async{
  var headers = {
    'Authorization': 'Bearer ${LocalDatabase.to.box.read('token')}',
    'Cookie': 'XSRF-TOKEN=eyJpdiI6ImNmMmVic0RhUDQ0ZFYzc29zZm9Qa2c9PSIsInZhbHVlIjoiOFpnUE5LYjFqc3d2VHNSZDd6Yi96bzhaL0duMzdHM3JIOXlIMkJod20wTEVCZEZQTHpzY1RqOTBGb2s5R1VQelFOODhPV3RjMWVkeEdFWm1nYVpYRWJBRERIbkZxSnNjUG5FT3dxSm9rQXdZcmRGWXpvZlorNXEyWWdMWHkwb0siLCJtYWMiOiJlZjBjNDMwODk3ZDc0NWExNzYzNTI2NDMzYzkzMTk1M2E5YjZlMWQyYzE3YTcxYmVhZGVmZGMyZDM3Yjg2Y2M5IiwidGFnIjoiIn0%3D; hallelujah_choice_radio_session=eyJpdiI6IjBhV0ZOVEtKYnIxSmFVSDdLNVpMbGc9PSIsInZhbHVlIjoiOTlPYmkxVTJ6NWVZb2EzVnl2K21tbDlLalRhSFB6ZktHbHhMSFFpMVloZFB0U0FrTXdoQTVjeTc0U2dtaUxIRzkwTmpCWTdHYU44N1VPSXNuMGRPdWYzd29ENElucWhrZUhjaVZHcEVuMkx3WGdMcHNvclpNU0FhQ0F0ZmRXcGwiLCJtYWMiOiI2MDgyMTUzM2NjMzRkYWFlMjgwYTFmY2VkODZkZTc0ZDgwNjQ2YTgxMDk1MTM5ZjZjY2NkMjMyZTYwYWVlMDMyIiwidGFnIjoiIn0%3D'
  };
  var dio = Dio();
  var response = await dio.request(
    'https://hgcradio.org/api/user',
    options: Options(
      method: 'GET',
      headers: headers,
    ),
  );

  if (response.statusCode == 200) {
    print("dddddfffff: ${ response.data['data']['user']}");
    getUserProfileName.value = response.data['data']['user']['name'];
    getUserProfileEmail.value = response.data['data']['user']['email'];
    getUserProfileAbout.value = response.data['data']['user']['about'];

    // LocalDatabase.to.box.write('nameProfile', getUserProfileName.value);
    // LocalDatabase.to.box.write('emailProfile', getUserProfileEmail.value);

    List userInfo = [{
      "nameProfile": "${getUserProfileName.value}",
      "emailProfile": "${getUserProfileEmail.value}",
      "aboutProfile": "${getUserProfileAbout.value}"
}];

    LocalDatabase.to.box.write("userInfo", userInfo);
  }
  else {
    print(response.statusMessage);
  }
}
