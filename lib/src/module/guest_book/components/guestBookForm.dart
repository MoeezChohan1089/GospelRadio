// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';

import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../../custom_widgets/customTextField.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import 'package:http/http.dart';

class GuestBookFormSection extends StatefulWidget {
  const GuestBookFormSection({Key? key}) : super(key: key);

  @override
  State<GuestBookFormSection> createState() => _GuestBookFormSectionState();
}

class _GuestBookFormSectionState extends State<GuestBookFormSection> {
  var name = TextEditingController();
  var email = TextEditingController();
  var country = TextEditingController();
  var city = TextEditingController();
  var state = TextEditingController();
  var invite_name = TextEditingController();
  var invite_email = TextEditingController();
  var invite_country = TextEditingController();
  var invite_city = TextEditingController();
  var invite_state = TextEditingController();
  // var message = TextEditingController();
  String message = 's';
  void Submit(name, email, country, city, state, invite_name, invite_email,
      invite_country, invite_city, invite_state, message) async {
    Response response = await post(
        Uri.parse(
            'https://hgcradio.org/api/subscribe'), //for login just change name instead of register
        body: {
          'name': name,
          'email': email,
          'country': country,
          'city': city,
          'state': state,
          'invite_name': invite_name,
          'invite_email': invite_email,
          'invite_city': invite_city,
          'invite_state': invite_state,
          'invite_country': invite_country,
          'message': message,
        });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data['status']);
      final snackBar = SnackBar(
        content: Text('Submitted Successfully'),
      );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      var data = jsonDecode(response.body.toString());
      print('Failed');
      sncbr(data['status'], data['message']);
    }
  }

  sncbr(title, message) {
    Get.snackbar(title, message, backgroundColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal / 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              15.heightBox,
              Text(
                "Enter Your Information",
                style: context.text.bodyLarge
                    ?.copyWith(color: AppColors.customWhiteTextColor
                        // height: 0.1
                        ),
              ),
              15.heightBox,
              Text(
                "Full Name",
                style: context.text.bodyLarge
                    ?.copyWith(color: AppColors.customWhiteTextColor
                        // height: 0.1
                        ),
              ),
              10.heightBox,
              CustomTextFieldC(
                controller: name,
                // controller: logic.emailTextController,
                hintText: 'Name',
                // textAlign: TextAlign.center,
                validation: (value) {
                  if (value!.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                hintFontSize: 16.0,
                isOutlineInputBorder: true,
                isOutlineInputBorderColor: AppColors.customWhiteTextColor,
                textColor: Colors.white,
                // textFieldFillColor: Colors.transparent,
                // fontWeight: FontWeight.bold,
                fieldborderRadius: 6,
                outlineTopLeftRadius: 6,
                outlineTopRightRadius: 6,
                outlineBottomLeftRadius: 6,
                outlineBottomRightRadius: 6,
                textFontSize: 16.0,
                hintTextColor: Colors.white,
                onTap: () async {
                  null;
                },
              ),
              10.heightBox,
              Text(
                "Email",
                style: context.text.bodyLarge
                    ?.copyWith(color: AppColors.customWhiteTextColor
                        // height: 0.1
                        ),
              ),
              10.heightBox,
              CustomTextFieldC(
                controller: email,
                // controller: logic.emailTextController,
                hintText: 'Email',
                // textAlign: TextAlign.center,
                validation: (value) {
                  if (value!.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
                hintFontSize: 16.0,
                isOutlineInputBorder: true,
                isOutlineInputBorderColor: AppColors.customWhiteTextColor,
                textColor: Colors.white,
                // textFieldFillColor: Colors.transparent,
                // fontWeight: FontWeight.bold,
                fieldborderRadius: 6,
                outlineTopLeftRadius: 6,
                outlineTopRightRadius: 6,
                outlineBottomLeftRadius: 6,
                outlineBottomRightRadius: 6,
                textFontSize: 16.0,
                hintTextColor: Colors.white,
                onTap: () async {
                  null;
                },
              ),
              10.heightBox,
              Text(
                "Country",
                style: context.text.bodyLarge
                    ?.copyWith(color: AppColors.customWhiteTextColor
                        // height: 0.1
                        ),
              ),
              10.heightBox,
              CustomTextFieldC(
                controller: country,
                // controller: logic.emailTextController,
                hintText: 'country',
                // textAlign: TextAlign.center,
                validation: (value) {
                  if (value!.isEmpty) {
                    return 'country is required';
                  }
                  return null;
                },
                hintFontSize: 16.0,
                isOutlineInputBorder: true,
                isOutlineInputBorderColor: AppColors.customWhiteTextColor,
                textColor: Colors.white,
                // textFieldFillColor: Colors.transparent,
                // fontWeight: FontWeight.bold,
                fieldborderRadius: 6,
                outlineTopLeftRadius: 6,
                outlineTopRightRadius: 6,
                outlineBottomLeftRadius: 6,
                outlineBottomRightRadius: 6,
                textFontSize: 16.0,
                hintTextColor: Colors.white,
                onTap: () async {
                  null;
                },
              ),
              10.heightBox,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "State",
                          style: context.text.bodyLarge
                              ?.copyWith(color: AppColors.customWhiteTextColor
                                  // height: 0.1
                                  ),
                        ),
                        10.heightBox,
                        CustomTextFieldC(
                          controller: state,
                          // controller: logic.emailTextController,
                          hintText: 'state',
                          // textAlign: TextAlign.center,
                          validation: (value) {
                            if (value!.isEmpty) {
                              return 'country is required';
                            }
                            return null;
                          },
                          hintFontSize: 16.0,
                          isOutlineInputBorder: true,
                          isOutlineInputBorderColor:
                              AppColors.customWhiteTextColor,
                          textColor: Colors.white,
                          // textFieldFillColor: Colors.transparent,
                          // fontWeight: FontWeight.bold,
                          fieldborderRadius: 6,
                          outlineTopLeftRadius: 6,
                          outlineTopRightRadius: 6,
                          outlineBottomLeftRadius: 6,
                          outlineBottomRightRadius: 6,
                          textFontSize: 16.0,
                          hintTextColor: Colors.white,
                          onTap: () async {
                            null;
                          },
                        ),
                      ],
                    ),
                  ),
                  10.widthBox,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "City",
                          style: context.text.bodyLarge
                              ?.copyWith(color: AppColors.customWhiteTextColor
                                  // height: 0.1
                                  ),
                        ),
                        10.heightBox,
                        CustomTextFieldC(
                          controller: city,
                          // controller: logic.emailTextController,
                          hintText: 'city',
                          // textAlign: TextAlign.center,
                          validation: (value) {
                            if (value!.isEmpty) {
                              return 'country is required';
                            }
                            return null;
                          },
                          hintFontSize: 16.0,
                          isOutlineInputBorder: true,
                          isOutlineInputBorderColor:
                              AppColors.customWhiteTextColor,
                          textColor: Colors.white,
                          // textFieldFillColor: Colors.transparent,
                          // fontWeight: FontWeight.bold,
                          fieldborderRadius: 6,
                          outlineTopLeftRadius: 6,
                          outlineTopRightRadius: 6,
                          outlineBottomLeftRadius: 6,
                          outlineBottomRightRadius: 6,
                          textFontSize: 16.0,
                          hintTextColor: Colors.white,
                          onTap: () async {
                            null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              15.heightBox,
              Text(
                "Invite your friend & Family Member",
                style: context.text.bodyLarge
                    ?.copyWith(color: AppColors.customWhiteTextColor
                        // height: 0.1
                        ),
              ),
              15.heightBox,
              Text(
                "Full Name",
                style: context.text.bodyLarge
                    ?.copyWith(color: AppColors.customWhiteTextColor
                        // height: 0.1
                        ),
              ),
              10.heightBox,
              CustomTextFieldC(
                controller: invite_name,
                // controller: logic.emailTextController,
                hintText: 'full name',
                // textAlign: TextAlign.center,
                validation: (value) {
                  if (value!.isEmpty) {
                    return 'country is required';
                  }
                  return null;
                },
                hintFontSize: 16.0,
                isOutlineInputBorder: true,
                isOutlineInputBorderColor: AppColors.customWhiteTextColor,
                textColor: Colors.white,
                // textFieldFillColor: Colors.transparent,
                // fontWeight: FontWeight.bold,
                fieldborderRadius: 6,
                outlineTopLeftRadius: 6,
                outlineTopRightRadius: 6,
                outlineBottomLeftRadius: 6,
                outlineBottomRightRadius: 6,
                textFontSize: 16.0,
                hintTextColor: Colors.white,
                onTap: () async {
                  null;
                },
              ),
              10.heightBox,
              Text(
                "Email",
                style: context.text.bodyLarge
                    ?.copyWith(color: AppColors.customWhiteTextColor
                        // height: 0.1
                        ),
              ),
              10.heightBox,
              CustomTextFieldC(
                controller: invite_email,
                // controller: logic.emailTextController,
                hintText: 'email address',
                // textAlign: TextAlign.center,
                validation: (value) {
                  if (value!.isEmpty) {
                    return 'country is required';
                  }
                  return null;
                },
                hintFontSize: 16.0,
                isOutlineInputBorder: true,
                isOutlineInputBorderColor: AppColors.customWhiteTextColor,
                textColor: Colors.white,
                // textFieldFillColor: Colors.transparent,
                // fontWeight: FontWeight.bold,
                fieldborderRadius: 6,
                outlineTopLeftRadius: 6,
                outlineTopRightRadius: 6,
                outlineBottomLeftRadius: 6,
                outlineBottomRightRadius: 6,
                textFontSize: 16.0,
                hintTextColor: Colors.white,
                onTap: () async {
                  null;
                },
              ),
              10.heightBox,
              Text(
                "Country",
                style: context.text.bodyLarge
                    ?.copyWith(color: AppColors.customWhiteTextColor
                        // height: 0.1
                        ),
              ),
              10.heightBox,
              CustomTextFieldC(
                controller: invite_country,
                // controller: logic.emailTextController,
                hintText: 'country',
                // textAlign: TextAlign.center,
                validation: (value) {
                  if (value!.isEmpty) {
                    return 'country is required';
                  }
                  return null;
                },
                hintFontSize: 16.0,
                isOutlineInputBorder: true,
                isOutlineInputBorderColor: AppColors.customWhiteTextColor,
                textColor: Colors.white,
                // textFieldFillColor: Colors.transparent,
                // fontWeight: FontWeight.bold,
                fieldborderRadius: 6,
                outlineTopLeftRadius: 6,
                outlineTopRightRadius: 6,
                outlineBottomLeftRadius: 6,
                outlineBottomRightRadius: 6,
                textFontSize: 16.0,
                hintTextColor: Colors.white,
                onTap: () async {
                  null;
                },
              ),
              10.heightBox,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "State",
                          style: context.text.bodyLarge
                              ?.copyWith(color: AppColors.customWhiteTextColor
                                  // height: 0.1
                                  ),
                        ),
                        10.heightBox,
                        CustomTextFieldC(
                          controller: invite_state,
                          // controller: logic.emailTextController,
                          hintText: 'state',
                          // textAlign: TextAlign.center,
                          validation: (value) {
                            if (value!.isEmpty) {
                              return 'country is required';
                            }
                            return null;
                          },
                          hintFontSize: 16.0,
                          isOutlineInputBorder: true,
                          isOutlineInputBorderColor:
                              AppColors.customWhiteTextColor,
                          textColor: Colors.white,
                          // textFieldFillColor: Colors.transparent,
                          // fontWeight: FontWeight.bold,
                          fieldborderRadius: 6,
                          outlineTopLeftRadius: 6,
                          outlineTopRightRadius: 6,
                          outlineBottomLeftRadius: 6,
                          outlineBottomRightRadius: 6,
                          textFontSize: 16.0,
                          hintTextColor: Colors.white,
                          onTap: () async {
                            null;
                          },
                        ),
                      ],
                    ),
                  ),
                  10.widthBox,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "City",
                          style: context.text.bodyLarge
                              ?.copyWith(color: AppColors.customWhiteTextColor
                                  // height: 0.1
                                  ),
                        ),
                        10.heightBox,
                        CustomTextFieldC(
                          controller: invite_city,
                          // controller: logic.emailTextController,
                          hintText: 'city',
                          // textAlign: TextAlign.center,
                          validation: (value) {
                            if (value!.isEmpty) {
                              return 'country is required';
                            }
                            return null;
                          },
                          hintFontSize: 16.0,
                          isOutlineInputBorder: true,
                          isOutlineInputBorderColor:
                              AppColors.customWhiteTextColor,
                          textColor: Colors.white,
                          // textFieldFillColor: Colors.transparent,
                          // fontWeight: FontWeight.bold,
                          fieldborderRadius: 6,
                          outlineTopLeftRadius: 6,
                          outlineTopRightRadius: 6,
                          outlineBottomLeftRadius: 6,
                          outlineBottomRightRadius: 6,
                          textFontSize: 16.0,
                          hintTextColor: Colors.white,
                          onTap: () async {
                            null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: pageMarginHorizontal * 2,
                    vertical: pageMarginVertical),
                child: Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                      onPressed: () async {
                        // Get.to(()=> HomePage());
                        Submit(
                            name.text,
                            email.text,
                            country.text,
                            city.text,
                            state.text,
                            invite_name.text,
                            invite_email.text,
                            invite_country.text,
                            invite_city.text,
                            invite_state.text,
                            'succ');
                        name.clear();
                        email.clear();
                        country.clear();
                        city.clear();
                        state.clear();
                        invite_name.clear();
                        invite_email.clear();
                        invite_country.clear();
                        invite_city.clear();
                        invite_state.clear();
                        print('object');
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
                        "Submit",
                        style: context.text.bodyMedium!.copyWith(
                            color: Colors.white, fontSize: 18.sp, height: 1.1),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
