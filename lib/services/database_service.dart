// Packages
import 'package:cloud_firestore/cloud_firestore.dart';


const String USER_COLLECTION = "users";
const String CHAT_COLLECTION = "chats";
const String MESSAGES_COLLECTION = "messages";


class DataBaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DataBaseService() {}

  Future<void> createUser(String _uid, String _email, String _name, String _imageURL) async {
    try {
      await _db.collection(USER_COLLECTION).doc(_uid).set({
        "email": _email,
        "image": _imageURL,
        "last_active": DateTime.now().toUtc(),
        "name": _name,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<DocumentSnapshot> getUser(String _uid) {
    return _db.collection(USER_COLLECTION).doc(_uid).get();
  }

  Future<void> updateUserLastSeenTime(String _uid) async {
    try {
      await _db.collection(USER_COLLECTION).doc(_uid).update({
        "last_active": DateTime.now().toUtc(),
      });
    } catch(e) {
      print(e);
    }
  }
}