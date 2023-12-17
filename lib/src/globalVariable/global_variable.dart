import 'package:get/get.dart';

import '../custom_widgets/custom_loader.dart';

CustomLoader customLoaderGlobal = CustomLoader();

RxString getUserProfileName = ''.obs;
RxString getUserProfileEmail = ''.obs;
RxString getUserProfileAbout = ''.obs;