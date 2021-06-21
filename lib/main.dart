import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/CountProvider.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MyApp());

class GoogleAuth extends StatefulWidget {
  @override
  _GoogleAuthState createState() => _GoogleAuthState();
}

class _GoogleAuthState extends State<GoogleAuth> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  bool _isLoggedIn = false;
  FirebaseUser _user;

  void _login() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      final gsa = await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.getCredential(
        idToken: gsa.idToken,
        accessToken: gsa.accessToken,
      );
      final authResult = await _auth.signInWithCredential(credential);
      _user = authResult.user;

      setState(() => _isLoggedIn = true);
    } catch (e) {
      print(e);
    }
  }

  void _logout() {
    _googleSignIn.signOut();
    setState(() => _isLoggedIn = false);
  }

  @override
  Widget build(BuildContext context) {
    if (null == _user || !_isLoggedIn) {
      return ElevatedButton(
        onPressed: _login,
        child: const Text('구글로 로그인'),
      );
    }

    return Column(
      children: [
        Image.network(
          _googleSignIn.currentUser.photoUrl,
          width: 50,
          height: 50,
        ),
        Text(
          _googleSignIn.currentUser.displayName,
        ),
        ElevatedButton(
          onPressed: _logout,
          child: const Text('로그아웃'),
        ),
      ],
    );
  }
}

/// You can remove _Screen widget to reset project when you use this template.
class _Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GoogleAuth(),
      ],
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
        home: Scaffold(body: _Screen()),
      ),
    );
  }
}
