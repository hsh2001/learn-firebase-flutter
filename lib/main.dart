import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/CountProvider.dart';
import 'package:provider/provider.dart';

import 'auth.dart';

void main() => runApp(MyApp());

class _Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => createUser(
        email: 'tmdgus0084@naver.com',
        password: 'asdfasdfasdf1234',
        errorHandler: print,
      ),
      child: const Text('로그인'),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CountProvider()),
      ],
      child: MaterialApp(
        title: 'Hello flutter',
        theme: ThemeData(primaryColor: Colors.blue),
        home: Scaffold(body: Center(child: _Screen())),
      ),
    );
  }
}
