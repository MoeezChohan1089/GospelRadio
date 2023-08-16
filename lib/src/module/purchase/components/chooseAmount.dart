import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/module/purchase/logic.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../custom_widgets/customTextField.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import 'package:http/http.dart' as http;

class ChooseAmountSection extends StatefulWidget {
  ChooseAmountSection({Key? key}) : super(key: key);

  @override
  State<ChooseAmountSection> createState() => _ChooseAmountSectionState();
}

class _ChooseAmountSectionState extends State<ChooseAmountSection> {
  final logic = Get.put(PurchaseLogic());

  String messagePrice = '';
  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment(int price) async {
    try {
      paymentIntentData = await createPaymentIntent("$price", 'USD');
      var gpay =
      const PaymentSheetGooglePay(merchantCountryCode: '', testEnv: true);
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            style: ThemeMode.light,
            // appearance: PaymentSheetAppearance(
            //     colors: PaymentSheetAppearanceColors(
            //       background: Colors.red,
            //       primaryText: Colors.red,
            //     ),
            //     primaryButton: PaymentSheetPrimaryButtonAppearance(
            //         colors: PaymentSheetPrimaryButtonTheme(
            //             light: PaymentSheetPrimaryButtonThemeColors(
            //                 text: Colors.red, background: Colors.amber)))),
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            // applePay: PaymentSheetApplePay(merchantCountryCode: 'us'),

            googlePay: gpay,

            merchantDisplayName: 'Shary',
          ));
      displaypaymentsheet();
    } catch (e) {
      print('Eception+$e');
    }
  }

  displaypaymentsheet() async {
    try {
      Stripe.instance.presentPaymentSheet().then((value) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Paid successfully'),
        ));
        // GlobalClass.hasPurchased.value = true;
        // prefs.setBool('hasPurchased', true);
      });

      setState(() {
        paymentIntentData = null;
      });
    } on StripeException catch (e) {
      print('Eception+$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateamount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
            'Bearer sk_test_51N9OPdFZIhHk42tPLiBXDrXHcA9ZbQnUFMP9MhTt9c3Kk8WzHIm08BM1MKmjAIK74ZRUVuQDgXu2geZbN4heuNjK008pIo1pXk',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return json.decode(response.body.toString());
    } catch (e) {
      print('Eception+$e');
    }
  }

  calculateamount(String amount) {
    final price = int.parse(amount) * 100;
    return price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: pageMarginHorizontal + 10,),
            child: Row(
              children: [
                Text("Music Album", style: context.text.titleMedium?.copyWith(
                    color: AppColors.customWhiteTextColor, fontSize: 18.sp),),
              ],
            ),
          ),
          10.heightBox,
          logic.selectManual.value == false ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: pageMarginHorizontal / 2,),
                child: SizedBox(
                  height: 80,
                  width: 90,
                  child: ElevatedButton(
                      onPressed: () async {
                        logic.indexPrice.value = 0;
                        messagePrice = '50';
                        // ProductDetailLogic.to.addProductToCart();
                      },

                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.transparent,

                          elevation: 0,
                          // Set the text color of the button
                          padding: const EdgeInsets.all(8),
                          // Set the padding around the button content
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          side: BorderSide(
                            width: 1.0,
                            color: logic.indexPrice.value == 0 ? AppColors
                                .customPinkColor : AppColors
                                .customGreyTextColor,
                          )
                      ),
                      child: Text("\$50",
                        style: context.text.bodyMedium!.copyWith(
                            fontSize: 18.sp,
                            color: AppColors.customWhiteTextColor,
                            height: 1.1),)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: pageMarginHorizontal / 2,),
                child: SizedBox(
                  height: 80,
                  width: 90,
                  child: ElevatedButton(
                      onPressed: () async {
                        logic.indexPrice.value = 1;
                        messagePrice = '100';
                        // ProductDetailLogic.to.addProductToCart();
                      },

                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.transparent,

                          elevation: 0,
                          // Set the text color of the button
                          padding: const EdgeInsets.all(8),
                          // Set the padding around the button content
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          side: BorderSide(
                            width: 1.0,
                            color: logic.indexPrice.value == 1 ? AppColors
                                .customPinkColor : AppColors
                                .customGreyTextColor,
                          )
                      ),
                      child: Text("\$100",
                        style: context.text.bodyMedium!.copyWith(
                            fontSize: 18.sp,
                            color: AppColors.customWhiteTextColor,
                            height: 1.1),)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: pageMarginHorizontal / 2,),
                child: SizedBox(
                  height: 80,
                  width: 90,
                  child: ElevatedButton(
                      onPressed: () async {
                        logic.indexPrice.value = 2;
                        messagePrice = '150';
                      },

                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.transparent,

                          elevation: 0,
                          // Set the text color of the button
                          padding: const EdgeInsets.all(8),
                          // Set the padding around the button content
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          side: BorderSide(
                            width: 1.0,
                            color: logic.indexPrice.value == 2 ? AppColors
                                .customPinkColor : AppColors
                                .customGreyTextColor,
                          )
                      ),
                      child: Text("\$150",
                        style: context.text.bodyMedium!.copyWith(
                            fontSize: 18.sp,
                            color: AppColors.customWhiteTextColor,
                            height: 1.1),)),
                ),
              ),
            ],
          ) :
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 80,
              child: CustomTextFieldC(
                controller: logic.controllerManual,
                hintText: 'Enter your price',
                // textAlign: TextAlign.center,
                validation: (value) {
                  if (value!.isEmpty) {
                    return 'Price is required';
                  }
                  return null;
                },
                hintFontSize: 16.0,
                keyboardType: TextInputType.number,
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
                suffixIcon: Icon(
                  Icons.abc,
                  color: Colors.white,
                ),
                onTap: () async {
                  null;
                },
              ),
            ),
          ),
          30.heightBox,
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 140,
                  child: Divider(
                    thickness: 2,
                    color: Color(0xffa09e9f),
                  ),
                ),
                Text(
                  'or',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Calibri',
                      fontSize: 20,
                      color: Color(0xffa09e9f)),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: 140,
                  child: Divider(
                    thickness: 2,
                    color: Color(0xffa09e9f),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 260,
            height: 60,
            child: ElevatedButton(
                onPressed: () async {
                  logic.selectManual.value = true;
                  // Get.to(()=> PurchasePage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.customGreyTextColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  // Set the text color of the button
                  // Set the padding around the button content
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Set the border radius of the button
                  ),
                ),
                child: Text(
                  "Enter Price Manually",
                  style: context.text.bodyMedium!
                      .copyWith(
                      color: Colors.white, fontSize: 17.sp, height: 1.1),
                )),
          ),
          30.heightBox,
          SizedBox(
            width: 300,
            height: 50,
            child: ElevatedButton(
                onPressed: () async {
                  if(logic.selectManual.value == false){
                    if (logic.indexPrice == 0) {
                      makePayment(50);
                      print('as');
                    }
                    else if (logic.indexPrice == 1) {
                      makePayment(100);
                      print('as');
                    }
                    else if (logic.indexPrice == 2) {
                      makePayment(150);
                      print('as');
                    }
                  }
                  else {
                    makePayment(int.parse(logic.controllerManual.text));
                    print('as');
                  }
                  // Get.to(()=> BuyAlbumPage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.customPinkColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  // Set the text color of the button
                  // Set the padding around the button content
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Set the border radius of the button
                  ),
                ),
                child: Text(
                  "Confirm",
                  style: context.text.bodyMedium!
                      .copyWith(
                      color: Colors.white, fontSize: 17.sp, height: 1.1),
                )),
          ),
        ],
      );
    });
  }
}
