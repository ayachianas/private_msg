// Packages
import 'package:cloud_firestore/cloud_firestore.dart';

// Models
import 'package:private_msg/models/chat_message.dart';

const String USER_COLLECTION = "users";
const String CHAT_COLLECTION = "chats";
const String MESSAGES_COLLECTION = "messages";

class DataBaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DataBaseService() {}

  Future<void> createUser(
      String _uid, String _email, String _name, String _imageURL) async {
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

  Stream<QuerySnapshot> getChatsForUser(String _uid) {
    return _db
        .collection(CHAT_COLLECTION)
        .where('members', arrayContains: _uid)
        .snapshots();
  }

  Future<QuerySnapshot> getLastMessageForChat(String _chatID) {
    return _db
        .collection(CHAT_COLLECTION)
        .doc(_chatID)
        .collection(MESSAGES_COLLECTION)
        .orderBy("sent_time", descending: true)
        .limit(1)
        .get();
  }

  Stream<QuerySnapshot> streamMessagesForChat(String _chatID) {
    return _db
        .collection(CHAT_COLLECTION)
        .doc(_chatID)
        .collection(MESSAGES_COLLECTION)
        .orderBy("sent_time", descending: false)
        .snapshots();
  }

  Future<void> addMessageToChat(String _chatID, ChatMessage _message) async {
    try {
      await _db
          .collection(CHAT_COLLECTION)
          .doc(_chatID)
          .collection(MESSAGES_COLLECTION)
          .add(_message.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateChatData(String _chatID, Map<String, dynamic> _data) async {
    try {
      await _db.collection(CHAT_COLLECTION).doc(_chatID).update(_data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUserLastSeenTime(String _uid) async {
    try {
      await _db.collection(USER_COLLECTION).doc(_uid).update({
        "last_active": DateTime.now().toUtc(),
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteChat(String _chatID) async {
    try {
      await _db.collection(CHAT_COLLECTION).doc(_chatID).delete();
    } catch (e) {
      print(e);
    }
  }
}
