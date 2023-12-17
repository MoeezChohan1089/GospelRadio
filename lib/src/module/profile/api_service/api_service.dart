import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gosperadioapp/src/globalVariable/database_controller.dart';

updateProfileService({required  String name, email, about}) async {
  log(" Update Profile list ");
  try {
    var headers = {
      'Authorization': 'Bearer ${LocalDatabase.to.box.read('token')}',
      'Cookie': 'XSRF-TOKEN=eyJpdiI6ImNmMmVic0RhUDQ0ZFYzc29zZm9Qa2c9PSIsInZhbHVlIjoiOFpnUE5LYjFqc3d2VHNSZDd6Yi96bzhaL0duMzdHM3JIOXlIMkJod20wTEVCZEZQTHpzY1RqOTBGb2s5R1VQelFOODhPV3RjMWVkeEdFWm1nYVpYRWJBRERIbkZxSnNjUG5FT3dxSm9rQXdZcmRGWXpvZlorNXEyWWdMWHkwb0siLCJtYWMiOiJlZjBjNDMwODk3ZDc0NWExNzYzNTI2NDMzYzkzMTk1M2E5YjZlMWQyYzE3YTcxYmVhZGVmZGMyZDM3Yjg2Y2M5IiwidGFnIjoiIn0%3D; hallelujah_choice_radio_session=eyJpdiI6IjBhV0ZOVEtKYnIxSmFVSDdLNVpMbGc9PSIsInZhbHVlIjoiOTlPYmkxVTJ6NWVZb2EzVnl2K21tbDlLalRhSFB6ZktHbHhMSFFpMVloZFB0U0FrTXdoQTVjeTc0U2dtaUxIRzkwTmpCWTdHYU44N1VPSXNuMGRPdWYzd29ENElucWhrZUhjaVZHcEVuMkx3WGdMcHNvclpNU0FhQ0F0ZmRXcGwiLCJtYWMiOiI2MDgyMTUzM2NjMzRkYWFlMjgwYTFmY2VkODZkZTc0ZDgwNjQ2YTgxMDk1MTM5ZjZjY2NkMjMyZTYwYWVlMDMyIiwidGFnIjoiIn0%3D'
    };
    var dio = Dio();
    var response = await dio.request(
      'https://hgcradio.org/api/auth/user?name=$name&about=$about&email=$email',
      options: Options(
        method: 'PUT',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    }
    else {
      print(response.statusMessage);
    }

    return true;
  } catch (e) {
    debugPrint("====> ERROR :: in creatig account ${e.toString()} <=====");
    return false;
  }
}

updatePasswordService({required  String old, newPassword, confirmPassword}) async {
  log(" Update Profile list ");
  try {
    var headers = {
      'Authorization': 'Bearer ${LocalDatabase.to.box.read('token')}',
      'Cookie': 'XSRF-TOKEN=eyJpdiI6IlVzTk9qTm5yTWt6VTlVcjR4c0tBOFE9PSIsInZhbHVlIjoiUE9DUFFrSHhtSzZSMTBKSUluaHVmU1dtbHArQVdEZUU3MDdmd0ljQVZnN3p3L1lyZmhBRDhZMlVpQk5PRFZ4NHp0bURqeURsZXJzRy9ienpSQ0lxdmY4K2cxb0dBN0xzQVZpakppL1Q5WktLTjFzZ0ljQThOaUd3eHV3bU9wcUEiLCJtYWMiOiJjOTZiYmIzNmMwYTUzN2Y5OGRhYTdkODdjYmQ4MmM0MjNjNzljY2M4NzBkNjY4YWFlNDc5YTFjZThjYWI1ZWQwIiwidGFnIjoiIn0%3D; hallelujah_choice_radio_session=eyJpdiI6InBhZFJ1eXg3ZnQrV0RjS1IxQmVyZVE9PSIsInZhbHVlIjoialIrbVd0KzhrdGIzZzk3OWJpN2ZFckMvekkwTUJYdlpkd3Zva0RXWjF4R2RDUVg1TmtSdnFzZXM4bWthMFdYQUFyeFNDNTBoT2VpZXVYZmk2ZEFQNXBnVjU2c3lKNkRMTEdSRzJvM1BKNDNtSVpMWFVDdnZ2VFBnTjF1Z3pQenQiLCJtYWMiOiI3MzI5ZDkwMjAzMDVhNTUzN2ExNDczM2E3NjhiMDE0ZmM1MjM1YWI4YjhmNDBmYzcxNzQ5MWViM2U3YmMxMjM5IiwidGFnIjoiIn0%3D'
    };
    var dio = Dio();
    var response = await dio.request(
      'https://hgcradio.org/api/auth/password?old_password=$old&password=$newPassword&password_confirmation=$confirmPassword',
      options: Options(
        method: 'PUT',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    }
    else {
      print(response.statusMessage);
    }

    return true;
  } catch (e) {
    debugPrint("====> ERROR :: in creatig account ${e.toString()} <=====");
    return false;
  }
}

deleteAccountService(email) async{
  try {
    Dio dio = Dio();

    final data = {'email': email};

    var headers = {
      'Authorization': 'Bearer ${LocalDatabase.to.box.read('token')}',
      'Cookie': 'XSRF-TOKEN=eyJpdiI6IlVzTk9qTm5yTWt6VTlVcjR4c0tBOFE9PSIsInZhbHVlIjoiUE9DUFFrSHhtSzZSMTBKSUluaHVmU1dtbHArQVdEZUU3MDdmd0ljQVZnN3p3L1lyZmhBRDhZMlVpQk5PRFZ4NHp0bURqeURsZXJzRy9ienpSQ0lxdmY4K2cxb0dBN0xzQVZpakppL1Q5WktLTjFzZ0ljQThOaUd3eHV3bU9wcUEiLCJtYWMiOiJjOTZiYmIzNmMwYTUzN2Y5OGRhYTdkODdjYmQ4MmM0MjNjNzljY2M4NzBkNjY4YWFlNDc5YTFjZThjYWI1ZWQwIiwidGFnIjoiIn0%3D; hallelujah_choice_radio_session=eyJpdiI6InBhZFJ1eXg3ZnQrV0RjS1IxQmVyZVE9PSIsInZhbHVlIjoialIrbVd0KzhrdGIzZzk3OWJpN2ZFckMvekkwTUJYdlpkd3Zva0RXWjF4R2RDUVg1TmtSdnFzZXM4bWthMFdYQUFyeFNDNTBoT2VpZXVYZmk2ZEFQNXBnVjU2c3lKNkRMTEdSRzJvM1BKNDNtSVpMWFVDdnZ2VFBnTjF1Z3pQenQiLCJtYWMiOiI3MzI5ZDkwMjAzMDVhNTUzN2ExNDczM2E3NjhiMDE0ZmM1MjM1YWI4YjhmNDBmYzcxNzQ5MWViM2U3YmMxMjM5IiwidGFnIjoiIn0%3D'
    };

    var response = await dio.request(
      'https://hgcradio.org/api/auth/delete',
      data: data,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
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

deleteOTPService(email, otp1,otp2,otp3,otp4) async{
  try {
    Dio dio = Dio();

    final data = {'email': email,
      'otp': '$otp1$otp2$otp3$otp4'};

    var headers = {
      'Authorization': 'Bearer ${LocalDatabase.to.box.read('token')}',
      'Cookie': 'XSRF-TOKEN=eyJpdiI6IlVzTk9qTm5yTWt6VTlVcjR4c0tBOFE9PSIsInZhbHVlIjoiUE9DUFFrSHhtSzZSMTBKSUluaHVmU1dtbHArQVdEZUU3MDdmd0ljQVZnN3p3L1lyZmhBRDhZMlVpQk5PRFZ4NHp0bURqeURsZXJzRy9ienpSQ0lxdmY4K2cxb0dBN0xzQVZpakppL1Q5WktLTjFzZ0ljQThOaUd3eHV3bU9wcUEiLCJtYWMiOiJjOTZiYmIzNmMwYTUzN2Y5OGRhYTdkODdjYmQ4MmM0MjNjNzljY2M4NzBkNjY4YWFlNDc5YTFjZThjYWI1ZWQwIiwidGFnIjoiIn0%3D; hallelujah_choice_radio_session=eyJpdiI6InBhZFJ1eXg3ZnQrV0RjS1IxQmVyZVE9PSIsInZhbHVlIjoialIrbVd0KzhrdGIzZzk3OWJpN2ZFckMvekkwTUJYdlpkd3Zva0RXWjF4R2RDUVg1TmtSdnFzZXM4bWthMFdYQUFyeFNDNTBoT2VpZXVYZmk2ZEFQNXBnVjU2c3lKNkRMTEdSRzJvM1BKNDNtSVpMWFVDdnZ2VFBnTjF1Z3pQenQiLCJtYWMiOiI3MzI5ZDkwMjAzMDVhNTUzN2ExNDczM2E3NjhiMDE0ZmM1MjM1YWI4YjhmNDBmYzcxNzQ5MWViM2U3YmMxMjM5IiwidGFnIjoiIn0%3D'
    };

    var response = await dio.request(
      'https://hgcradio.org/api/auth/delete/confirm',
      data: data,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
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