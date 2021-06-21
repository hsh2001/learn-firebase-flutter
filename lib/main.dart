import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/CountProvider.dart';
import 'package:provider/provider.dart';

import 'auth.dart';

void main() async {
  // await Firebase.initializeApp(
  //   options: const FirebaseOptions(
  //     apiKey: 'AIzaSyCe9rfnYZ9d1j6Q8Jkl-JW1U2NL4_MLzQk',
  //     appId: '1:1013845001654:ios:7f6633acf2e92b95caad17',
  //     messagingSenderId: '',
  //     projectId: 'test-636a3',
  //   ),
  // );

  runApp(MyApp());
}

class _Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => createUser(
        email: 'tmdgus0084@naver.com',
        password: '1234',
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
