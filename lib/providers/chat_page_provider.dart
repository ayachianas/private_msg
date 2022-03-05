// Packages
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

// Services
import 'package:private_msg/services/database_service.dart';
import 'package:private_msg/services/cloud_storage_service.dart';
import 'package:private_msg/services/media_service.dart';
import 'package:private_msg/services/navigation_service.dart';

// Providers
import 'package:private_msg/providers/authentication_provider.dart';

// Models
import 'package:private_msg/models/chat_message.dart';

class ChatPageProvider extends ChangeNotifier {
  late DataBaseService _db;
  late CloudStorageService _storage;
  late MediaService _media;
  late NavigationService _navigation;

  AuthenticationProvider _auth;
  ScrollController _messagesListViewController;

  String _chatId;
  List<ChatMessage>? messages;

  late StreamSubscription _messagesStream;

  String? _message;

  String getMessage() {
    return _message!;
  }

  ChatPageProvider(
    this._chatId,
    this._auth,
    this._messagesListViewController,
  ) {
    _db = GetIt.instance.get<DataBaseService>();
    _storage = GetIt.instance.get<CloudStorageService>();
    _media = GetIt.instance.get<MediaService>();
    _navigation = GetIt.instance.get<NavigationService>();
    listenToMessages();
  }

  @override
  void dispose() {
    _messagesStream.cancel();
    super.dispose();
  }

  void goBack() {
    _navigation.goBack();
  }

  void listenToMessages() {
    try {
      _messagesStream = _db.streamMessagesForChat(_chatId).listen((_snapshot) {
        List<ChatMessage> _messages = _snapshot.docs.map((_doc) {
          Map<String, dynamic> _messageData =
              _doc.data() as Map<String, dynamic>;
          return ChatMessage.fromJSON(_messageData);
        }).toList();
        messages = _messages;
        notifyListeners();
      });
    } catch (e) {
      print("Error getting messages.");
      print(e);
    }
  }

  void sendTextMessage() {
    if (_message != null) {
      ChatMessage _messageToSend = ChatMessage(
        content: _message!,
        type: MessageType.TEXT,
        senderID: _auth.user.uid,
        sentTime: DateTime.now(),
      );
      _db.addMessageToChat(_chatId, _messageToSend);
    }
  }

  void sendImageMessage() async {
    try {
      PlatformFile? _file = await _media.pickImageFromLibrary();
      if (_file != null) {
        String? _downloadURL = await _storage.saveChatImageToStorage(
            _chatId, _auth.user.uid, _file);
        ChatMessage _messageToSend = ChatMessage(
          content: _downloadURL!,
          type: MessageType.IMAGE,
          senderID: _auth.user.uid,
          sentTime: DateTime.now(),
        );
        _db.addMessageToChat(_chatId, _messageToSend);
      }
    } catch (e) {
      print("Error sending image message.");
      print(e);
    }
  }

  void deleteChat() {
    goBack();
    _db.deleteChat(_chatId);
  }
}
