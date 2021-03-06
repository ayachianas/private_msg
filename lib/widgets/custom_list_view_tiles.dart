// Packages
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Widgets
import 'package:private_msg/widgets/rounded_image.dart';
import 'package:private_msg/widgets/message_bubbles.dart';

// Models
import 'package:private_msg/models/chat_message.dart';
import 'package:private_msg/models/chat_user.dart';

class CustomListViewTile extends StatelessWidget {
  final double height;
  final String title;
  final String subtitle;
  final String imagePath;
  final bool isActive;
  final bool isSelected;
  final Function onTap;

  CustomListViewTile({
    required this.height,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.isActive,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: isSelected
          ? Icon(
              Icons.check,
              color: Colors.black,
            )
          : null,
      onTap: () => onTap(),
      minVerticalPadding: height * 0.2,
      leading: RoundedImageNetworkWithStatusIndicator(
        key: UniqueKey(),
        size: height / 2,
        imagePath: imagePath,
        isActive: isActive,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.black54,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class CustomListViewTileWithActivity extends StatelessWidget {
  final double height;
  final String title;
  final String subtitle;
  final String imagePath;
  final bool isActive;
  final bool isActivity;
  final Function onTap;

  CustomListViewTileWithActivity({
    required this.height,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.isActive,
    required this.isActivity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(),
      minVerticalPadding: height * 0.2,
      leading: RoundedImageNetworkWithStatusIndicator(
        key: UniqueKey(),
        size: height / 2,
        imagePath: imagePath,
        isActive: isActive,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: isActivity
          ? Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SpinKitThreeBounce(
                  color: Colors.grey,
                  size: height * 0.1,
                ),
              ],
            )
          : Text(
              subtitle,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
    );
  }
}

class CustomChatListViewTile extends StatelessWidget {
  final double deviceWidth;
  final double deviceHeight;
  final bool isOwnMessage;
  final ChatMessage message;
  final ChatUser sender;

  CustomChatListViewTile({
    required this.deviceWidth,
    required this.deviceHeight,
    required this.isOwnMessage,
    required this.message,
    required this.sender,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 10,
      ),
      width: deviceWidth,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment:
            isOwnMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          !isOwnMessage
              ? RoundedImageNetwork(
                  key: UniqueKey(),
                  imagePath: sender.imgURL,
                  size: deviceWidth * 0.04,
                )
              : Container(),
          SizedBox(
            width: deviceWidth * 0.05,
          ),
          message.type == MessageType.TEXT
              ? TextMessageBubble(
                  isOwnMessage: isOwnMessage,
                  message: message,
                  height: deviceHeight * 0.06,
                  width: deviceWidth,
                )
              : ImageMessageBubble(
                  isOwnMessage: isOwnMessage,
                  message: message,
                  height: deviceHeight * 0.3,
                  width: deviceWidth * 0.55,
                ),
        ],
      ),
    );
  }
}
