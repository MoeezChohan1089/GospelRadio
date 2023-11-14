import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/globalVariable/database_controller.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../../auth/components/login.dart';
import '../../home/logic.dart';
import '../../purchase/view.dart';
import '../logic.dart';
import 'musicTheAlbum.dart';

class MusicListCatalogScreen extends StatefulWidget {
  final int ID;
  final int? modelID;

  MusicListCatalogScreen({Key? key, required this.ID, this.modelID}) : super(key: key);

  @override
  State<MusicListCatalogScreen> createState() => _MusicListCatalogScreenState();
}

class _MusicListCatalogScreenState extends State<MusicListCatalogScreen> {
  final logic = Get.find<HomeLogic>();

  final logic1 = Get.put(Music_catalogLogic());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {

      // if(widget.modelID != null){
      //   if(widget.modelID == logic1.albumsListMusic.value[])
      // }

      logic1.getCatalogMusicAlbum(context, widget.ID);
    });

    print("custom ID: ${widget.ID}");
    super.initState();
    getloginstatus();
  }

  bool islogin = false;

  getloginstatus() async {
    SharedPreferences? sp = await SharedPreferences.getInstance();
    islogin = sp.getBool('islogin')!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.custombackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.custombackgroundColor,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "Music Catalog",
          style: context.text.bodySmall?.copyWith(
              color: AppColors.customWhiteTextColor, fontSize: 14.sp),
        ),
        leadingWidth: 170.w,
        leading: Row(
          children: [
            IconButton(
                onPressed: () {
                  Get.back();
                  // if(bottomNav.isFancyDrawer.isTrue){
                  //   bottomNav.advancedDrawerController.showDrawer();
                  // } else {
                  //   bottomNav.navScaffoldKey.currentState?.openDrawer();
                  // }
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.customWhiteTextColor,
                )),
            Container(
              // width: 80,
              // // color: Colors.amber,
              // height: 80,
              // margin: EdgeInsets.only(top: 35.h),
                child: Image.asset(
                  "assets/images/hgc.png",
                  fit: BoxFit.cover,
                  width: 110.w,
                  // width: 150,
                )),
          ],
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         // Get.to(() => CartPage());
        //       },
        //       icon: Icon(
        //         Icons.search,
        //         color: Colors.white,
        //       )),
        // ],
      ),
      body: Obx(() {
        return logic1.loadingCatalog.value == true
            ? ShimerListviewPage()
            : SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    10.heightBox,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        10.widthBox,
                        SizedBox(
                          width: 181.w,
                          height: 178.h,
                          child: CachedNetworkImage(
                            imageUrl: logic1.responseDataMusicList['data']
                                ['album']['image_url'],

                            // imageUrl: (productDetail?.images ?? []).isNotEmpty
                            //     ? productDetail!.images[0].originalSrc
                            //     : "",
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                            placeholder: (context, url) => productShimmer(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        // Image.network(
                        //     logic1.responseDataMusicList['data']['album']
                        //         ['image_url'],
                        //     width: 181.w,
                        //     height: 178.h,
                        //     fit: BoxFit.cover),
                        10.widthBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            14.heightBox,
                            Row(
                              children: [
                                Text(
                                  logic1.responseDataMusicList['data']['album']
                                      ['title'],
                                  style: context.text.bodySmall?.copyWith(
                                      color: AppColors.customWhiteTextColor,
                                      fontSize: 14.sp),
                                ),
                                50.widthBox,
                                islogin == true
                                    ? LocalDatabase.to.box.read('paid') != null
                                        ? GetBuilder<Music_catalogLogic>(
                                            builder: (logic) {
                                            return GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () {
                                                logic.downloadSong(
                                                    context, widget.ID);
                                                print('as');
                                              },
                                              child: Text(
                                                "Download",
                                                textAlign: TextAlign.end,
                                                style: context.text.bodySmall
                                                    ?.copyWith(
                                                  color: AppColors
                                                      .customMusicTextColor,
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                            );
                                          })
                                        : logic1.openSheet.value == true? CircularProgressIndicator(color: AppColors.customPinkColor):  GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () {
                                             if(logic1.openSheet.value == false){
                                               logic1.openSheet.value = true;
                                               makePayment(logic1
                                                   .responseDataMusicList[
                                               'data']['album']['price']);
                                               print('as');
                                             }
                                            },
                                            child: Text(
                                             "Buy Now",
                                              textAlign: TextAlign.end,
                                              style: context.text.bodySmall
                                                  ?.copyWith(
                                                color: AppColors
                                                    .customMusicTextColor,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          )
                                    : GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          Get.to(() => LoginScreen());
                                        },
                                        child: Text(
                                          "Login",
                                          textAlign: TextAlign.end,
                                          style:
                                              context.text.bodySmall?.copyWith(
                                            color:
                                                AppColors.customMusicTextColor,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            6.heightBox,
                            Text(
                              'Release Year: ${logic1.responseDataMusicList['data']['album']['release_year']}',
                              style: context.text.bodySmall?.copyWith(
                                  color: AppColors.customWhiteTextColor,
                                  fontSize: 14.sp),
                            ),
                            6.heightBox,
                            Text(
                              'Release Price: \$${logic1.responseDataMusicList['data']['album']['price']}',
                              style: context.text.bodySmall?.copyWith(
                                  color: AppColors.customWhiteTextColor,
                                  fontSize: 14.sp),
                            ),
                            6.heightBox,
                            Text(
                              logic1.responseDataMusicList['data']['album']
                                  ['artist_name'],
                              style: context.text.bodySmall?.copyWith(
                                  color: AppColors.customWhiteTextColor,
                                  fontSize: 14.sp),
                            ),
                            10.heightBox,
                            islogin == true
                                ? SizedBox(
                                    width: 160,
                                    height: 32,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          Get.to(() =>
                                              PurchasePage(ID: widget.ID));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.customPinkColor,
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                          // Set the text color of the button
                                          // Set the padding around the button content
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                4), // Set the border radius of the button
                                          ),
                                        ),
                                        child: Text(
                                          "Share Love gift",
                                          style: context.text.bodyMedium!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 12.sp,
                                                  height: 1.1),
                                        )),
                                  )
                                : SizedBox(),
                          ],
                        )
                      ],
                    ),
                    10.heightBox,
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: pageMarginHorizontal,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Music Album",
                            style: context.text.titleMedium?.copyWith(
                                color: AppColors.customWhiteTextColor,
                                fontSize: 18.sp),
                          ),
                        ],
                      ),
                    ),
                    MusicTheAlbumSection(modelID: widget.modelID,),
                  ],
                ),
              );
      }),
    );
  }

  // var price = 180;
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

            merchantDisplayName: '${LocalDatabase.to.box.read('name')}',
          ));
      displaypaymentsheet();
      logic1.openSheet.value = false;
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
            'Bearer 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',
            // 'Bearer sk_test_51N9OPdFZIhHk42tPLiBXDrXHcA9ZbQnUFMP9MhTt9c3Kk8WzHIm08BM1MKmjAIK74ZRUVuQDgXu2geZbN4heuNjK008pIo1pXk',
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
}
