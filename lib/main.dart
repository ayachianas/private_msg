import 'package:flutter/material.dart';
import 'package:private_msg/screens/authentication/authenticate.dart';
import 'package:private_msg/screens/splash_page.dart';
import 'package:private_msg/services/navigation_service.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SplashPage(
      key: UniqueKey(),
      onInitializationComplete: () {
        runApp(MaterialApp(
          title: 'Private MSG',
          home: Authenticate(),
          navigatorKey: NavigationService.navigatorKey,
        ));
      }
    );
  }
}
