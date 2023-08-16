import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'src/globalVariable/database_controller.dart';
import 'src/globalVariable/dependency_injection.dart';
import 'src/module/splash.dart';
import 'src/utils/theme/theme_config.dart';

void main() async {
  Get.put(LocalDatabase());
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_live_51HDlCsEAGys7uBYAIxj7ksoznlq0DFBzIolyG8iKjgP16AbLXPRAAQyePu0u9sBjAc5ogNeSHYvCcUTmuN0yuEWm00Z8t89mNU';
      // 'pk_test_51N9OPdFZIhHk42tP1p5CVwfKn9H4HCjLJBrUHuzUIxMi6x3EooRoIHYoIhoihHvaoIyyykunZD7kSMGgkk9SFmZV00F60MIjc1';
  await GetStorage.init();
  await DependencyInjection.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(414, 942),
        minTextAdapt: true,
        splitScreenMode: false,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            home: SplashScreen(),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },
          );
        });
  }
}
