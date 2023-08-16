import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/globalVariable/database_controller.dart';
import 'package:gosperadioapp/src/module/home/view.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants/assets.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/margins_spacnings.dart';
import 'auth/view.dart';
import 'contact/view.dart';
import 'engineers/view.dart';
import 'gospel_website/view.dart';
import 'guest_book/view.dart';
import 'play_history/view.dart';
import 'schedule/view.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  //share link for android
  //https://play.google.com/store/apps/details?id=com.pdf.converter.editor.jpgtopdf.maker

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _initPackageInfo();
    getloginstatus();
  }

  bool islogin = false;
  getloginstatus() async {
    SharedPreferences? sp = await SharedPreferences.getInstance();
    // name = sp.getString('name') ?? 'Username';
    // email = sp.getString('email') ?? 'username@gmail.com';
    islogin = sp.getBool('islogin')!;
  }

  String name = 'Username';
  String email = 'username@gmail.com';
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.custombackgroundColor,
      elevation: 0,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            50.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: pageMarginVertical + 4),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Welcome",
                    textAlign: TextAlign.start,
                    style: context.text.titleMedium?.copyWith(
                        color: AppColors.customWhiteTextColor,
                        fontSize: 24.sp)),
              ),
            ),
            20.heightBox,
            (LocalDatabase.to.box.read('token') != null)?  Padding(
              padding: EdgeInsets.symmetric(horizontal: pageMarginVertical + 4),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: AppColors.customWebsiteListColor,
                      borderRadius: BorderRadius.circular(10.r)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(LocalDatabase.to.box.read('name'),
                          textAlign: TextAlign.start,
                          style: context.text.titleMedium?.copyWith(
                              color: AppColors.customWhiteTextColor,
                              fontSize: 20.sp)),
                      Text(LocalDatabase.to.box.read('email'),
                          textAlign: TextAlign.start,
                          style: context.text.titleMedium?.copyWith(
                              color: AppColors.customWhiteTextColor,
                              fontSize: 18.sp)),
                    ],
                  ),
                ),
              ),
            ):SizedBox(),
            30.heightBox,
            InkWell(
              onTap: () {
                Navigator.pop(context);
                // launch(
                //     "https://play.google.com/store/apps/details?id=health.calculator.and.weight.loss.tracker");
                // if (Platform.isIOS) {
                //   launch("https://apps.apple.com/us/app/1608350899");
                // }
                // // // Android
                // if (Platform.isAndroid) {
                //   launch(
                //       "https://play.google.com/store/apps/details?id=com.pdf.photos.converter.image.pic");
                // }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icons.homeIcon,
                      height: 18,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Home",
                        style: context.text.titleMedium?.copyWith(
                            color: AppColors.customWhiteTextColor,
                            fontSize: 16.sp))
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Get.to(() => PlayHistoryPage());
                // Navigator.of(context).pop();
                // final Uri params = Uri(
                //   scheme: 'mailto',
                //   path: 'advancetechnology982@gmail.com',
                //   query:
                //   'subject=Health Calculator & Weight Loss Tracker Feedback', //add subject and body here
                // );
                // launchUrl(params);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icons.playIcon,
                      height: 18,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Play/History",
                        style: context.text.titleMedium?.copyWith(
                            color: AppColors.customWhiteTextColor,
                            fontSize: 16.sp))
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => SchedulePage());
                // try {
                //   Navigator.pop(context);
                //   // iOS
                //   // if (Platform.isIOS) {
                //   //   Share.share(
                //   //       '${AppLocalizations.of(context)!.heyDownload}!= https://apps.apple.com/us/app/1608350899');
                //   // }
                //   // // // Android
                //   // if (Platform.isAndroid) {
                //   Share.share(
                //       '${AppLocalizations.of(context)!.download} != https://play.google.com/store/apps/details?id=health.calculator.and.weight.loss.tracker');
                //   // }
                // } catch (e) {
                //   print("error $e");
                // }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icons.scheduleIcon,
                      height: 18,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Schedule",
                        style: context.text.titleMedium?.copyWith(
                            color: AppColors.customWhiteTextColor,
                            fontSize: 16.sp))
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Get.to(() => GospelWebsitePage());

                // launch(
                //     "https://advancetechnology982000.blogspot.com/2022/10/health-weight-loss-tracker.html");
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icons.gospelIcon,
                      height: 18,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Gospel Website",
                        style: context.text.titleMedium?.copyWith(
                            color: AppColors.customWhiteTextColor,
                            fontSize: 16.sp))
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Get.to(() => EngineersPage());
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icons.studioIcon,
                      height: 18,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Studio Engineers",
                        style: context.text.titleMedium?.copyWith(
                            color: AppColors.customWhiteTextColor,
                            fontSize: 16.sp))
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Get.to(() => GuestBookPage());
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  children: [
                    // Image.asset('assets/images/ic_privacy_policy.webp',height: 20, color: Theme.of(context).colorScheme.inverseSurface,),
                    SvgPicture.asset(
                      Assets.icons.guestBookIcon,
                      height: 18,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Guest Books",
                        style: context.text.titleMedium?.copyWith(
                            color: AppColors.customWhiteTextColor,
                            fontSize: 16.sp))
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Get.to(() => ContactPage());
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  children: [
                    // Image.asset('assets/images/ic_privacy_policy.webp',height: 20, color: Theme.of(context).colorScheme.inverseSurface,),
                    SvgPicture.asset(
                      Assets.icons.musicIcon,
                      height: 18,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Contact",
                        style: context.text.titleMedium?.copyWith(
                            color: AppColors.customWhiteTextColor,
                            fontSize: 16.sp))
                  ],
                ),
              ),
            ),
            LocalDatabase.to.box.read('token') == null
                ? InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(() => AuthPage());
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Row(
                        children: [
                          // Image.asset('assets/images/ic_privacy_policy.webp',height: 20, color: Theme.of(context).colorScheme.inverseSurface,),
                          SvgPicture.asset(
                            Assets.icons.logoutIcon,
                            height: 18,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Login",
                              style: context.text.titleMedium?.copyWith(
                                  color: AppColors.customWhiteTextColor,
                                  fontSize: 16.sp))
                        ],
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      LocalDatabase.to.box.remove('token');
                      Get.off(() => HomePage());
                      Get.snackbar('logout', 'Logout Sussessfully..');
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Row(
                        children: [
                          // Image.asset('assets/images/ic_privacy_policy.webp',height: 20, color: Theme.of(context).colorScheme.inverseSurface,),
                          SvgPicture.asset(
                            Assets.icons.logoutIcon,
                            height: 18,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Logout",
                              style: context.text.titleMedium?.copyWith(
                                  color: AppColors.customWhiteTextColor,
                                  fontSize: 16.sp))
                        ],
                      ),
                    ),
                  ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: pageMarginVertical + 4),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Ver 0.0.2",
                    textAlign: TextAlign.start,
                    style: context.text.titleMedium?.copyWith(
                        color: AppColors.customWhiteTextColor,
                        fontSize: 14.sp)),
              ),
            ),
            16.heightBox,
          ],
        ),
      ),
    );
  }
}
