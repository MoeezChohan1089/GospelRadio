import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

import 'state.dart';

class Music_radioLogic extends GetxController {
  final Music_radioState state = Music_radioState();
  Rx<int> currentImageIndex = 0.obs;
  RxBool loadingStreamMusic = false.obs;
  AudioPlayer player1 = AudioPlayer();

  @override
  void onInit() {
    super.onInit();
    player1.setUrl('https://my.hgcradio.org:8000/radio.mp3');
  }
}
