import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../globalVariable/global_variable.dart';
import 'state.dart';

class ContactLogic extends GetxController
    with GetSingleTickerProviderStateMixin {
  static ContactLogic get to => Get.find();
  final ContactState state = ContactState();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  GlobalKey<FormState> contactFormKeyValue = GlobalKey<FormState>();

  // sendContactMessage(BuildContext context, String name, String email, String message) async {
  //   try {
  //     customLoaderGlobal.showLoader(context);
  //     // Create Dio instance
  //     Dio dio = Dio();
  //
  //     // Prepare the request data
  //     Map<String, dynamic> requestData = {
  //       'name': name,
  //       'email': email,
  //       'message': message,
  //     };
  //
  //     // Send the POST request
  //     final response = await dio.post('https://hgcradio.org/api/contact', data: requestData);
  //
  //     // Handle the response
  //     if (response.statusCode == 200 && response.data['status'] == 'Success') {
  //       log(response.data); // Response data from the server
  //       customLoaderGlobal.hideLoader();
  //       Get.snackbar('message', 'Message sent successfully..');
  //     } else {
  //       customLoaderGlobal.hideLoader();
  //       print('Failed to send message. Status code: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     customLoaderGlobal.hideLoader();
  //     print('Error sending message: $error');
  //   }
  // }

  sendContactMessage(
      BuildContext context, String name, String email, String message) async {
    try {
      customLoaderGlobal.showLoader(context);
      Dio dio = Dio();

      final data = {
        'name': name,
        'email': email,
        'message': message,
      };

      var response = await dio.request(
        'https://hgcradio.org/api/contact',
        options: Options(
          method: 'POST',
        ),
        data: data,
      );

      // Handle the response
      if (response.statusCode == 200) {
        print("result: ${json.encode(response.data)}");
        customLoaderGlobal.hideLoader();
        final snackBar = SnackBar(
          content: Text(
            'Message sent successfully..',
            style: context.text.bodyMedium
                ?.copyWith(fontSize: 18.sp, color: Colors.white),
          ),
          margin: EdgeInsets.only(bottom: 8),
          behavior: SnackBarBehavior.floating,
        );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        // Request failed
        customLoaderGlobal.hideLoader();
        print('Failed to send message. Status code: ${response.statusMessage}');
      }
    } catch (error) {
      // Handle any Dio errors or exceptions
      customLoaderGlobal.hideLoader();
      print('Status code: ${error}');
    }
  }
}
