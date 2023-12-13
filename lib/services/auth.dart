import 'package:firebase_auth/firebase_auth.dart';
import 'package:pethub/models/myuser.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser
  MyUser? _userfromFirebase(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<MyUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userfromFirebase(user!));
  }

 User? get currentUser {
    return _auth.currentUser;
  }

String? get firstName {
    User? user = _auth.currentUser;
    String? userEmail = user?.email;
    return userEmail != null ? userEmail.split('@')[0] : null;
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;

      return _userfromFirebase(user!);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPasssword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      return _userfromFirebase(user!);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPasssword(String email, String password) async {
  try {
    UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User? user = result.user;

    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        print('Pengguna baru terdaftar: ${user.uid}');
      }
    });

    return _userfromFirebase(user!);
  } catch (e) {
    print(e.toString());
    return null;
  }
}

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
