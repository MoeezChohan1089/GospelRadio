import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/globalVariable/database_controller.dart';
import 'package:gosperadioapp/src/globalVariable/global_variable.dart';
import 'package:gosperadioapp/src/module/auth/api_service/api_services.dart';
import 'package:gosperadioapp/src/module/home/view.dart';
import 'package:gosperadioapp/src/module/profile/logic.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants/assets.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/margins_spacnings.dart';
import 'auth/view.dart';
import 'contact/view.dart';
import 'downloads_album/view.dart';
import 'engineers/view.dart';
import 'gospel_website/view.dart';
import 'guest_book/view.dart';
import 'music_radio/view.dart';
import 'music_radio/view1.dart';
import 'music_radio/view2.dart';
import 'play_history/view.dart';
import 'profile/view.dart';
import 'schedule/view.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  //share link for android
  //https://play.google.com/store/apps/details?id=com.pdf.converter.editor.jpgtopdf.maker

  final logic = Get.put(ProfileLogic());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserProfileService();
    });
    logic.infor.value = LocalDatabase.to.box.read('userInfo') ?? [];
    super.initState();
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
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            10.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: pageMarginVertical + 4),
              child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/Logo.png",
                    fit: BoxFit.cover,
                    width: 170.w,
                    // width: 150,
                  )),
            ),
            // 20.heightBox,
            (LocalDatabase.to.box.read('token') != null)
                ? Obx(() {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: pageMarginVertical + 4),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: AppColors.customWebsiteListColor,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(logic.infor.value[0]['nameProfile'],
                            textAlign: TextAlign.start,
                            style: context.text.titleMedium?.copyWith(
                                color: AppColors.customWhiteTextColor,
                                fontSize: 20.sp)),
                        Text(logic.infor.value[0]['emailProfile'],
                            textAlign: TextAlign.start,
                            style: context.text.titleMedium?.copyWith(
                                color: AppColors.customWhiteTextColor,
                                fontSize: 18.sp)),
                      ],
                    ),
                  ),
                ),
              );
            })
                : SizedBox(),
            20.heightBox,
            LocalDatabase.to.box.read('token') != null
                ? InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Get.to(() => ProfilePage());
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
                padding:
                EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: AppColors.customPinkColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Edit Profile",
                        style: context.text.titleMedium?.copyWith(
                            color: AppColors.customWhiteTextColor,
                            fontSize: 16.sp))
                  ],
                ),
              ),
            )
                : SizedBox(),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Get.to(() => Music_radioPage());
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
                    Icon(
                      Icons.music_note,
                      size: 20,
                      color: AppColors.customPinkColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Listen Live",
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
                Get.to(HomePage());
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
                    Text("Catalog Album",
                        style: context.text.titleMedium?.copyWith(
                            color: AppColors.customWhiteTextColor,
                            fontSize: 16.sp))
                  ],
                ),
              ),
            ),
            LocalDatabase.to.box.read('token') != null
                ? InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Get.to(() => DownloadsAlbumPage());
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
                padding:
                EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.download,
                      color: AppColors.customPinkColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Downloads",
                        style: context.text.titleMedium?.copyWith(
                            color: AppColors.customWhiteTextColor,
                            fontSize: 16.sp))
                  ],
                ),
              ),
            )
                : SizedBox(),
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
                final snackBar = SnackBar(
                  content: Text(
                    'Logout Sussessfully..',
                    style: context.text.bodyMedium
                        ?.copyWith(fontSize: 18.sp, color: Colors.white),
                  ),
                  margin: EdgeInsets.only(bottom: 8),
                  behavior: SnackBarBehavior.floating,
                );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: pageMarginVertical + 4),
            //   child: Align(
            //     alignment: Alignment.topRight,
            //     child: Text("Ver 0.0.2",
            //         textAlign: TextAlign.start,
            //         style: context.text.titleMedium?.copyWith(
            //             color: AppColors.customWhiteTextColor,
            //             fontSize: 14.sp)),
            //   ),
            // ),
            16.heightBox,
          ],
        ),
      ),
    );
  }
}
