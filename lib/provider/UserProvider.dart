import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../auth.dart' as auth;

class UserProvider extends ChangeNotifier {
  User? _user;

  bool get isLogin => _user != null;
  User? get user => _user;

  Future<User?> login({
    required String email,
    required String password,
  }) async {
    return _user = await auth.login(
      email: email,
      password: password,
      errorHandler: (errorMessage) {
        Get.snackbar('로그인 오류', errorMessage);
      },
    );
  }
}
