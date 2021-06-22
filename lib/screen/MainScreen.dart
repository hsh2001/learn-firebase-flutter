import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/UserProvider.dart';
import 'package:flutter_application_1/screen/Login.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    userProvider.buildContext = context;

    if (!userProvider.isLogin) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Login()),
      );
    }

    return Scaffold(
      body: Container(
        child: const Center(child: Text('환영합니다')),
      ),
    );
  }
}
