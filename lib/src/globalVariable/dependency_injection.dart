import 'package:get/get.dart';
import '../module/engineers/logic.dart';
import '../module/home/logic.dart';

class DependencyInjection {
  static Future<void> init()  async {

    Get.put<HomeLogic>(
      HomeLogic(),
      permanent: true,
    );

  }
}