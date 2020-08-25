import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtual_store/hepers/firebase_errors.dart';
import 'package:virtual_store/models/user.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;

  bool _loading = false;
  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;

    notifyListeners();
  }

  /*void setLoading(bool value){
    _loading = value;
    notifyListeners();
  }*/

  Future<void> signIn({User user, Function onFail, Function onSuccess}) async {
    //setLoading(true);
    loading = true;
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.senha);

      this.user = result.user;

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    //setLoading(false);
    loading = false;
  }

  Future<void> _loadCurrentUser() async {
    final FirebaseUser currentUser = await auth.currentUser();
    if (currentUser != null) {
      user = currentUser;
      print(user.uid);
    }
    notifyListeners();
  }
}
