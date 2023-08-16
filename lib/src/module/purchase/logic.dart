import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.dart';

class PurchaseLogic extends GetxController {
  final PurchaseState state = PurchaseState();

  RxInt indexPrice = 0.obs;
  RxBool selectManual = false.obs;
  TextEditingController controllerManual = TextEditingController();
}
