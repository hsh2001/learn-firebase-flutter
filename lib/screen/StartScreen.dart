import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/UserProvider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'Login.dart';
import 'MainScreen.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    Future.delayed(const Duration(seconds: 2)).then((value) async {
      final user = await userProvider.loginBySavedInfo();
      await Get.to(() => user == null ? Login() : MainScreen());
    });

    return Scaffold(
      body: Container(
        child: const Center(
          child: Icon(Icons.ac_unit, size: 200),
        ),
      ),
    );
  }
}
