// Packages
import 'package:flutter/material.dart';
import 'package:private_msg/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

// Services
import 'package:private_msg/services/navigation_service.dart';

// Pages
import 'package:private_msg/pages/splash_page.dart';
import 'package:private_msg/pages/authentication/signin.dart';
import 'package:private_msg/pages/home_page.dart';


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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (BuildContext _context) {
            return AuthenticationProvider();
          },
        ),
      ],
      child: MaterialApp(
        title: 'Private MSG',
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: '/signIn',
        routes: {
          '/signIn': (BuildContext _context) => SignIn(),
          '/home': (BuildContext _context) => HomePage(),
        },
      ),
    );
  }
}
