import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../auth.dart' as auth;

class UserProvider extends ChangeNotifier {
  User? _user;
  BuildContext? buildContext;

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
        ScaffoldMessenger.of(buildContext!).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      },
    );
  }
}
