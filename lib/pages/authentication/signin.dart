// Packages
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

// Providers
import 'package:private_msg/providers/authentication_provider.dart';

// Pages
import 'package:private_msg/widgets/home_appbar.dart';

// Services
import '../../services/navigation_service.dart';

// Widgets
import '../../widgets/custom_input_fields.dart';
import '../../widgets/rounded_button.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late double _deviceHeight;
  late double _deviceWidth;

  final _signInKey = GlobalKey<FormState>();

  String? _email;
  String? _password;

  late AuthenticationProvider _auth;
  late NavigationService _navigation;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    _navigation = GetIt.instance.get<NavigationService>();
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      appBar: homeAppBar(context),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.03,
          vertical: _deviceWidth * 0.02,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _pageTitle(),
            SizedBox(height: _deviceHeight * 0.04,),
            _signInForm(),
            SizedBox(height: _deviceHeight * 0.05,),
            _signInButton(),
            SizedBox(height: _deviceHeight * 0.02,),
            _signUpLink(),
          ],
        ),
      ),
    );
  }

  Widget _pageTitle() {
    return Container(
      height: _deviceHeight * 0.10,
      child: const Text(
        'Private MSG',
        style: TextStyle(
          color: Colors.green,
          fontSize: 40,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _signInForm() {
    return Container(
      height: _deviceHeight * 0.18,
      child: Form(
        key: _signInKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
              onSaved: (_value) {
                setState(() {
                  _email = _value;
                });
              },
              regEx: r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
              hintText: 'Email',
              obscureText: false
            ),
            CustomTextFormField(
              onSaved: (_value) {
                setState(() {
                  _password = _value;
                });
              },
              regEx: r".{6,}",
              hintText: 'Password',
              obscureText: true
            ),
          ],
        ),
      ),
    );
  }

  Widget _signInButton() {
    return RoundedButton(
      name: "Sign In",
      height: _deviceHeight *0.065,
      width: _deviceWidth * 0.65,
      onPressed: () {
        if (_signInKey.currentState!.validate()) {
          _signInKey.currentState!.save();
          _auth.signInUsingEmailAndPassword(_email!, _password!);
        }
      },
    );
  }

  Widget _signUpLink() {
    return GestureDetector(
      onTap: () => _navigation.navigateToRoute('/signup'),
      child: Container(
        child: const Text(
          "Don't have an account?",
          style: TextStyle(
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
