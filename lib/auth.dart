import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

final auth = FirebaseAuth.instance;
bool _isInit = false;

Future init() async {
  if (!_isInit) {
    return await Firebase.initializeApp();
  }
}

Future<User?> createUser({
  required String email,
  required String password,
  required Function errorHandler,
}) async {
  try {
    await init();
    final credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credential.user;
  } catch (e) {
    dynamic error = e;

    if (error.code == 'weak-password') {
      errorHandler('The password provided is too weak.');
    } else if (error.code == 'email-already-in-use') {
      errorHandler('The account already exists for that email.');
    } else {
      errorHandler(e);
    }

    return null;
  }
}

Future<User?> login({
  required String email,
  required String password,
  required Function errorHandler,
}) async {
  try {
    await init();
    final credential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credential.user;
  } catch (e) {
    dynamic error = e;

    if (error.code == 'user-not-found') {
      errorHandler('No user found for that email.');
    } else if (error.code == 'wrong-password') {
      errorHandler('Wrong password provided for that user.');
    } else {
      errorHandler(e);
    }

    return null;
  }
}
