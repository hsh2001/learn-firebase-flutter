import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/UserProvider.dart';
import 'package:flutter_application_1/screen/StartScreen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

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
        home: StartScreen(),
      ),
    );
  }
}
