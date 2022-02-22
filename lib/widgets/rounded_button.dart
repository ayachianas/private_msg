import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String name;
  final double height;
  final double width;
  final Function onPressed;

  const RoundedButton({
    required this.name,
    required this.height,
    required this.width,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: TextButton(
        onPressed: () {},
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height * 0.25),
        color: Colors.blue,
      ),
    );
  }
}
