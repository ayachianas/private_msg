// Packages
import 'package:flutter/material.dart';

// Pages
import 'package:private_msg/widgets/home_appbar.dart';

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

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
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
              onSaved: (_value) {},
              regEx: r"",
              hintText: 'Email',
              obscureText: false
            ),
            CustomTextFormField(
              onSaved: (_value) {},
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
      onPressed: () {},
    );
  }

  Widget _signUpLink() {
    return GestureDetector(
      onTap: () {},
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
