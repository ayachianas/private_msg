// Packages
import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Services
import 'package:private_msg/services/database_service.dart';

// Providers
import 'package:private_msg/providers/authentication_provider.dart';

// Models
import 'package:private_msg/models/chat.dart';
import 'package:private_msg/models/chat_message.dart';
import 'package:private_msg/models/chat_user.dart';

class ChatsPageProvider extends ChangeNotifier {
  AuthenticationProvider _auth;

  late DataBaseService _db;

  List<Chat>? chats;

  late StreamSubscription _chatsStream;

  ChatsPageProvider(this._auth) {
    _db = GetIt.instance.get<DataBaseService>();
    getChats();
  }

  @override
  void dispose() {
    _chatsStream.cancel();
    super.dispose();
  }

  void getChats() async {
    try {
      _chatsStream =
          _db.getChatsForUser(_auth.user.uid).listen((_snapshot) async {
        chats = await Future.wait(_snapshot.docs.map((_doc) async {
          Map<String, dynamic> _chatData = _doc.data() as Map<String, dynamic>;
          // Get Users in Chat
          List<ChatUser> _members = [];
          for (var _uid in _chatData["members"]) {
            DocumentSnapshot _userSnapshot = await _db.getUser(_uid);
            Map<String, dynamic> _userData =
                _userSnapshot.data() as Map<String, dynamic>;
            _userData["uid"] = _userSnapshot.id;
            _members.add(ChatUser.fromJSON(_userData));
          }
          // Get last message for Chat
          List<ChatMessage> _messages = [];
          QuerySnapshot _chatMessage = await _db.getLastMessageForChat(_doc.id);
          if (_chatMessage.docs.isNotEmpty) {
            Map<String, dynamic> _messageData =
                _chatMessage.docs.first.data()! as Map<String, dynamic>;
            ChatMessage _message = ChatMessage.fromJSON(_messageData);
            _messages.add(_message);
          }
          // Return Chat instance
          return Chat(
            uid: _doc.id,
            currentUserUid: _auth.user.uid,
            members: _members,
            messages: _messages,
            activity: _chatData["is_activity"],
            group: _chatData["is_group"],
          );
        }).toList());
        notifyListeners();
      });
    } catch (e) {
      print("Error getting chats.");
      print(e);
    }
  }
}
