import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/UserProvider.dart';
import 'package:flutter_application_1/screen/MainScreen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context);
    _userProvider.buildContext = context;

    if (_userProvider.isLogin) {
      Future.delayed(const Duration(milliseconds: 1130)).then((value) {
        Get.to(MainScreen());
      });
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) => setState(() => email = value),
                decoration: const InputDecoration(
                  hintText: '이메일을 입력하세요',
                ),
              ),
              TextField(
                onChanged: (value) => setState(() => password = value),
                decoration: const InputDecoration(
                  hintText: '비밀번호를 입력하세요',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await _userProvider.login(email: email, password: password);
                  setState(() {});
                },
                child: const Text('로그인'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
