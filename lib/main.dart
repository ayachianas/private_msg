// Packages
import 'package:flutter/material.dart';

// Services
import 'package:private_msg/services/navigation_service.dart';

// Pages
import 'package:private_msg/screens/splash_page.dart';
import 'package:private_msg/screens/authentication/signin.dart';


void main() {
  runApp(SplashPage(
      key: UniqueKey(),
      onInitializationComplete: () {
        runApp(MainApp());
      }));
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Private MSG',
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: '/signIn',
      routes: {
        '/signIn': (BuildContext _context) => SignIn(),
      },
    );
  }
}
