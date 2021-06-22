import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/UserProvider.dart';
import 'package:flutter_application_1/screen/Login.dart';
import 'package:flutter_application_1/screen/MainScreen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class _Screen extends StatefulWidget {
  @override
  __ScreenState createState() => __ScreenState();
}

class __ScreenState extends State<_Screen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    Future.delayed(const Duration(seconds: 3)).then((value) {
      Get.to(() => userProvider.isLogin ? MainScreen() : Login());
    });

    return Container(
      child: const Center(
        child: Text('Logo here'),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: GetMaterialApp(
        title: 'Hello flutter',
        theme: ThemeData(primaryColor: Colors.blue),
        home: Scaffold(body: _Screen()),
      ),
    );
  }
}
