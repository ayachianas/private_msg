// Packages
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

// Services
import '../services/database_service.dart';
import '../services/navigation_service.dart';

// Models
import 'package:private_msg/models/chat_user.dart';


class AuthenticationProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final NavigationService _navigationService;
  late final DataBaseService _dataBaseService;
  late ChatUser user;

  AuthenticationProvider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _dataBaseService = GetIt.instance.get<DataBaseService>();

    _auth.authStateChanges().listen((_user) {
      if (_user != null) {
        _dataBaseService.updateUserLastSeenTime(_user.uid);
        _dataBaseService.getUser(_user.uid).then((_snapshot) {
          Map<String, dynamic> _userData = _snapshot.data()! as Map<String, dynamic>;
          user = ChatUser.fromJSON({
            "uid": _user.uid,
            "name": _userData["name"],
            "email": _userData["email"],
            "last_active": _userData["last_active"],
            "image": _userData["image"],
          });
          _navigationService.removeAndNavigateToRoute('/home');
        });
      } else {
        _navigationService.removeAndNavigateToRoute('/signIn');
      }
    });
  }

  Future<void> signInUsingEmailAndPassword(String _email, String _password) async {
    try{
      await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _password,
      );
    } on FirebaseAuthException {
      print("Error logging user into Firebase!");
    } catch (e) {
      print(e);
    }
  }
}