// Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Widgets
import 'package:private_msg/widgets/top_bar.dart';
import 'package:private_msg/widgets/custom_list_view_tiles.dart';
import 'package:private_msg/widgets/custom_input_fields.dart';

// Models
import 'package:private_msg/models/chat.dart';
import 'package:private_msg/models/chat_message.dart';

// Providers
import 'package:private_msg/providers/authentication_provider.dart';
import 'package:private_msg/providers/chat_page_provider.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;

  ChatPage({
    required this.chat,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;
  late ChatPageProvider _pageProvider;

  late GlobalKey<FormState> _messageFormState;
  late ScrollController _messagesListViewController;

  @override
  void initState() {
    super.initState();
    _messageFormState = GlobalKey<FormState>();
    _messagesListViewController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatPageProvider>(
          create: (_) => ChatPageProvider(
            widget.chat.uid,
            _auth,
            _messagesListViewController,
          ),
        ),
      ],
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(
      builder: (BuildContext _context) {
        _pageProvider = _context.watch<ChatPageProvider>();
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: _deviceWidth * 0.03,
                vertical: _deviceHeight * 0.02,
              ),
              height: _deviceHeight,
              width: _deviceWidth * 0.97,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TopBar(
                    widget.chat.title(),
                    fontSize: 10,
                    primaryAction: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    secondaryAction: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  _messagesListView(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _messagesListView() {
    if (_pageProvider.messages != null) {
      if (_pageProvider.messages!.length != 0) {
        return Container(
          height: _deviceHeight * 0.74,
          child: ListView.builder(
            itemCount: _pageProvider.messages!.length,
            itemBuilder: (BuildContext _context, int _index) {
              ChatMessage _message = _pageProvider.messages![_index];
              bool isOwnMessage = _message.senderID == _auth.user.uid;
              return Container(
                child: CustomChatListViewTile(
                  deviceHeight: _deviceHeight,
                  deviceWidth: _deviceWidth * 0.8,
                  message: _message,
                  isOwnMessage: isOwnMessage,
                  sender: widget.chat.members
                      .where((_member) => _member.uid == _message.senderID)
                      .first,
                ),
              );
            },
          ),
        );
      } else {
        return const Align(
          alignment: Alignment.center,
          child: Text(
            "Say Hi!",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        );
      }
    } else {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      );
    }
  }
}
