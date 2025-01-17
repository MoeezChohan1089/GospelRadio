import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/module/welcome.dart';
import 'package:path_provider/path_provider.dart';

import '../globalVariable/database_controller.dart';
import 'music_radio/view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController animation;
  late Animation<double> fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    fadeInFadeOut = Tween<double>(begin: 0.1, end: 0.9).animate(animation);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
      } else if (status == AnimationStatus.dismissed) {
        animation.forward();
      }
    });
    animation.forward();
    Timer(Duration(seconds: 3), () async {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      final dir = Directory('${appDocDir.path}/saveFiles')
        ..create(recursive: true);
      print("splash path: ${dir.path}");
      // Get.to(() => WelcomeScreen());
      Get.off(() =>(LocalDatabase.to.box.read('started') != null)? Music_radioPage() :WelcomeScreen());
    });
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // bottomNavigationBar: Wrap(
        //   children: [
        //     Container(
        //       color: Colors.transparent,
        //       child: Column(
        //         children: [
        //           Container( margin: EdgeInsets.only(left: 60),child: Center(child: Text("Powered By", style: TextStyle(fontSize: 14, color: Colors.white,  fontFamily: "Basic_family",),))),
        //           Container( margin: EdgeInsets.only(bottom: 12), child: Center(child: Image.asset('assets/ic_eclixtech.png', width:130))),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: fadeInFadeOut,
                  child: Center(
                    child: Image.asset(
                      'assets/images/Logo.png',
                      width: 185,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text(
                  "Hallelujah Gospel Choice\n Radio",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w500
                      // fontFamily: "Schyler",
                      ),
                )),
              ],
            ),
            Positioned(
                bottom: 20,
                right: 10,
                left: 10,
                child: Column(
                  children: [
                    //   Container( margin: EdgeInsets.only(left: 60),child: Center(child: Text(AppLocalizations.of(context)!.appPowered, style: TextStyle(fontSize: 14, color: Colors.white,  fontFamily: "Basic_family",),))),
                    // Image.asset('assets/eclixLogo.webp', width:130),
                  ],
                ))
          ],
        ));
  }
}
