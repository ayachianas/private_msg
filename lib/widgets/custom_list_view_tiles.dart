// Packages
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Widgets
import 'package:private_msg/widgets/rounded_image.dart';

// Models
import 'package:private_msg/models/chat_message.dart';
import 'package:private_msg/models/chat_user.dart';


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
