import 'package:get/get.dart';
import '../module/engineers/logic.dart';
import '../module/home/logic.dart';
import '../module/music_radio/logic.dart';
import '../module/play_history/logic.dart';

class DependencyInjection {
  static Future<void> init()  async {

    Get.put<HomeLogic>(
      HomeLogic(),
      permanent: true,
    );

    Get.put<PlayHistoryLogic>(
      PlayHistoryLogic(),
      permanent: true,
    );

    Get.put<Music_radioLogic>(
      Music_radioLogic(),
      permanent: true,
    );

  }
}