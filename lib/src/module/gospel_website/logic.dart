import 'package:get/get.dart';

import 'state.dart';

class GospelWebsiteLogic extends GetxController {
  final GospelWebsiteState state = GospelWebsiteState();

  RxBool expanded = false.obs;
  RxInt expandedContainer = 0.obs;
}
