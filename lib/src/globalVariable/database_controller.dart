import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalDatabase extends GetxController {
  static LocalDatabase get to => Get.find();
  final box = GetStorage();

}