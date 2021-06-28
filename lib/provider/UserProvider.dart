import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../auth.dart' as auth;

const _loginDBFileName = '__login_db.db';
const _loginDBTableName = '__login_table';
const _loginDBVersion = 1;

bool _isLogin = false;
bool _isLoginChecked = false;

Future<void> _onLoginDBCreate(Database db, int version) async {
  await db.execute(
    '''
    CREATE TABLE $_loginDBTableName (
      id INTEGER PRIMARY KEY, 
      email TEXT,
      password TEXT
    )
    ''',
  );
}

class UserProvider extends ChangeNotifier {
  String _email = '';
  String _password = '';
  User? _user;

  bool get isLogin => _user != null;
  User? get user => _user;

  Future<Database> _getLoginInfoDataBase() async {
    final path = join(await getDatabasesPath(), _loginDBFileName);
    return await openDatabase(
      path,
      onCreate: _onLoginDBCreate,
      version: _loginDBVersion,
    );
  }

  Future<bool> _checkLoginInfoOnDB() async {
    if (_isLoginChecked) {
      return _isLogin;
    }

    _isLoginChecked = true;

    final database = await _getLoginInfoDataBase();
    final List<Map<String, dynamic>> loginInfoList = await database.query(
      _loginDBTableName,
      orderBy: 'id DESC',
      limit: 1,
    );

    if (loginInfoList.isEmpty) {
      return false;
    }

    _password = loginInfoList.last['password'];
    _email = loginInfoList.last['email'];
    return true;
  }

  Future<void> _deleteLoginInfoOnDB() async {
    final db = await _getLoginInfoDataBase();
    await db.delete(_loginDBTableName);
  }

  Future<void> _insertLoginInfoOnDB({
    required String email,
    required String password,
  }) async {
    final db = await _getLoginInfoDataBase();
    await db.insert(_loginDBTableName, {
      'password': password,
      'email': email,
    });
  }

  void _saveEamilPassword({
    required String emailValue,
    required String passwordValue,
  }) {
    _email = emailValue;
    _password = passwordValue;
  }

  Future<User?> _loginByEmailPassword({
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

  Future<User?> loginBySavedInfo() async {
    await _checkLoginInfoOnDB();

    if (_email == '' || _password == '') {
      return null;
    }

    final _user = await login(email: _email, password: _password);

    if (_user == null) {
      // 저장된 로그인 정보 지우기
      await _deleteLoginInfoOnDB();
    }

    return _user;
  }

  Future<User?> login({
    required String email,
    required String password,
  }) async {
    _saveEamilPassword(emailValue: email, passwordValue: password);
    final _user = await _loginByEmailPassword(email: email, password: password);
    if (_user != null) {
      await _insertLoginInfoOnDB(email: email, password: password);
    }
    return _user;
  }

  Future<void> logout() async {
    await auth.logout();
    await _deleteLoginInfoOnDB();
    _user = null;
    _email = '';
    _password = '';
  }
}
