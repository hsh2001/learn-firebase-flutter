import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/UserProvider.dart';
import 'package:flutter_application_1/screen/StartScreen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child: Text('환영합니다')),
            Container(
              width: 120,
              child: ElevatedButton(
                onPressed: () async {
                  await _userProvider.logout();
                  await Get.offAll(() => StartScreen());
                  Get.snackbar('로그아웃', '성공적으로 로그아웃되었습니다.');
                },
                child: Row(
                  children: const [
                    Icon(Icons.logout),
                    Text('로그아웃'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
