import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/login.dart';
import 'components/signup.dart';
import 'logic.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key? key}) : super(key: key);

  final logic = Get.put(AuthLogic());
  final state = Get.find<AuthLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreen(),
    );
  }
}
