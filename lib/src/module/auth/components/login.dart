import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/module/auth/components/signup.dart';
import 'package:gosperadioapp/src/module/home/view.dart';
import 'package:gosperadioapp/src/utils/constants/assets.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../custom_widgets/customTextField.dart';
import '../../../utils/constants/colors.dart';
import '../logic.dart';
import 'forgot.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final logic = Get.put(AuthLogic());
  bool iserror = false;
  GlobalKey<FormState> formKeyValuee = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: formKeyValuee,
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
                  top: 150.0.h,
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
                        'Sign In',
                        style: context.text.titleMedium?.copyWith(
                            fontSize: 40.sp,
                            color: Colors.white,
                            height: 1.2,
                            fontWeight: FontWeight.w700),
                      ),
                      6.heightBox,
                      Text(
                        'to start play',
                        textAlign: TextAlign.start,
                        style: context.text.titleMedium?.copyWith(
                            fontSize: 20.sp,
                            color: Colors.white,
                            height: 1.2,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  top: 100.0,
                  left: 30.0,
                  right: 30.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Email",
                        style:
                            context.text.bodyLarge?.copyWith(color: Colors.white
                                // height: 0.1
                                ),
                      ),
                      6.heightBox,
                      Container(
                        height: 80,
                        child: CustomTextFieldC(
                          controller: logic.emailSignInController,
                          hintText: 'Email',
                          // textAlign: TextAlign.center,
                          validation: (value) {
                            if (value!.isEmpty) {
                              return 'Email is required';
                            }
                            // Email Regex Pattern
                            String pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = RegExp(pattern);
                            if (!regex.hasMatch(value)) {
                              return 'Enter a valid email address';
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
                          suffixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        "Password",
                        style:
                            context.text.bodyLarge?.copyWith(color: Colors.white
                                // height: 0.1
                                ),
                      ),
                      6.heightBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx(() {
                            return Container(
                              height: 60,
                              // height: 40,
                              child: CustomTextFieldC(
                                controller: logic.passwordSignInController,
                                hintText: 'Password',
                                obscureText: logic.obscureText.value,
                                // textAlign: TextAlign.center,
                                validation: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password is required';
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
                                suffixIcon: IconButton(
                                  icon: Icon(logic.obscureText.value
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  // Icons.visibility_off),
                                  onPressed: () {
                                    logic.obscureText.value =
                                        !logic.obscureText.value;
                                  },
                                ),
                                onTap: () async {
                                  null;
                                },
                              ),
                            );
                          }),
                          Container(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPasswordScreen()));
                              },
                              child: Text(
                                "Forgot password?",
                                textAlign: TextAlign.end,
                                style: context.text.bodyMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                      10.heightBox,
                    ],
                  ),
                ),
                // Positioned(
                //     bottom: 320.0,
                //     left: 30.0,
                //     right: 30.0,
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           "Password",
                //           style:
                //               context.text.bodyLarge?.copyWith(color: Colors.white
                //                   // height: 0.1
                //                   ),
                //         ),
                //         6.heightBox,
                //         Obx(() {
                //           return Container(
                //             height: 80,
                //             // height: 40,
                //             child: CustomTextFieldC(
                //               controller: logic.passwordSignInController,
                //               hintText: 'Password',
                //               obscureText: logic.obscureText.value,
                //               // textAlign: TextAlign.center,
                //               validation: (value) {
                //                 if (value!.isEmpty) {
                //                   return 'Password is required';
                //                 }
                //                 return null;
                //               },
                //               hintFontSize: 16.0,
                //               isOutlineInputBorder: true,
                //               isOutlineInputBorderColor:
                //                   AppColors.customWhiteTextColor,
                //               textColor: Colors.white,
                //               // textFieldFillColor: Colors.transparent,
                //               // fontWeight: FontWeight.bold,
                //               fieldborderRadius: 6,
                //               outlineTopLeftRadius: 6,
                //               outlineTopRightRadius: 6,
                //               outlineBottomLeftRadius: 6,
                //               outlineBottomRightRadius: 6,
                //               textFontSize: 16.0,
                //               hintTextColor: Colors.white,
                //               suffixIcon: IconButton(
                //                 icon: Icon(logic.obscureText.value
                //                     ? Icons.visibility_off
                //                     : Icons.visibility),
                //                 // Icons.visibility_off),
                //                 onPressed: () {
                //                   logic.obscureText.value =
                //                       !logic.obscureText.value;
                //                 },
                //               ),
                //               onTap: () async {
                //                 null;
                //               },
                //             ),
                //           );
                //         }),
                //         10.heightBox,
                //       ],
                //     )),
                Positioned(
                  bottom: 130.0,
                  left: 30.0,
                  right: 30.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                SharedPreferences sp =
                                    await SharedPreferences.getInstance();
                                if (formKeyValuee.currentState!.validate()) {
                                  await AuthLogic.to
                                      .signInUser(context: context);
                                  print(sp.getString('token'));
                                  // print(sp.getString('islogin'));
                                }
                                print('object');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.customMusicTextColor,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                // Set the text color of the button
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10),
                                // Set the padding around the button content
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      7), // Set the border radius of the button
                                ),
                              ),
                              child: Icon(
                                Icons.arrow_forward,
                                size: 30,
                              )),
                          Row(
                            children: [
                              Text("Or",
                                  style: context.text.titleMedium?.copyWith(
                                      color: Colors.white, fontSize: 16.sp)),
                              TextButton(
                                onPressed: () {
                                  Get.to(() => SignUpScreen());
                                },
                                child: Text("Sign Up",
                                    style: context.text.titleMedium?.copyWith(
                                        color: Colors.white, fontSize: 16.sp)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
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
                                  Get.off(HomePage());
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
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
// Future<void> makePayment() async {
//   try {
//     paymentIntentData = await createPaymentIntent("$price", 'USD');
//     var gpay =
//         const PaymentSheetGooglePay(merchantCountryCode: '', testEnv: true);
//     await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//       style: ThemeMode.light,
//       // appearance: PaymentSheetAppearance(
//       //     colors: PaymentSheetAppearanceColors(
//       //       background: Colors.red,
//       //       primaryText: Colors.red,
//       //     ),
//       //     primaryButton: PaymentSheetPrimaryButtonAppearance(
//       //         colors: PaymentSheetPrimaryButtonTheme(
//       //             light: PaymentSheetPrimaryButtonThemeColors(
//       //                 text: Colors.red, background: Colors.amber)))),
//       paymentIntentClientSecret: paymentIntentData!['client_secret'],
//       // applePay: PaymentSheetApplePay(merchantCountryCode: 'us'),

//       googlePay: gpay,

//       merchantDisplayName: 'Shary',
//     ));
//     displaypaymentsheet();
//   } catch (e) {
//     print('Eception+$e');
//   }
// }

// displaypaymentsheet() async {
//   try {
//     Stripe.instance.presentPaymentSheet().then((value) async {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('Paid successfully'),
//       ));
//       GlobalClass.hasPurchased.value = true;
//       prefs.setBool('hasPurchased', true);
//     });

//     setState(() {
//       paymentIntentData = null;
//     });
//   } on StripeException catch (e) {
//     print('Eception+$e');
//   }
// }

// createPaymentIntent(String amount, String currency) async {
//   try {
//     Map<String, dynamic> body = {
//       'amount': calculateamount(amount),
//       'currency': currency,
//       'payment_method_types[]': 'card'
//     };
//     var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         body: body,
//         headers: {
//           'Authorization':
//               'Bearer sk_test_51N9OPdFZIhHk42tPLiBXDrXHcA9ZbQnUFMP9MhTt9c3Kk8WzHIm08BM1MKmjAIK74ZRUVuQDgXu2geZbN4heuNjK008pIo1pXk',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         });
//     return json.decode(response.body.toString());
//   } catch (e) {
//     print('Eception+$e');
//   }
// }

// calculateamount(String amount) {
//   final price = int.parse(amount) * 100;
//   return price.toString();
// }
}
