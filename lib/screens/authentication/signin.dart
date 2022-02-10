import 'package:flutter/material.dart';
import 'package:private_msg/widgets/home_appbar.dart';

class SignIn extends StatefulWidget {

  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              TextField(
                style: SimpleTextFielStyle(),
                decoration: textFieldInputDecoration("email")
              ),
              TextField(
                style: SimpleTextFielStyle(),
                decoration: textFieldInputDecoration("password")
              ),
              const SizedBox(height: 8.0,),
              Container(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text("Forgot Password?", style: SimpleTextFielStyle(),),
                ),
              ),
              const SizedBox(height: 8.0,),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff007EF4),
                      Color(0xff2A75BC)
                  ]
                  ),
                  borderRadius: BorderRadius.circular(30)
                ),
                child: const Text("Sign In", style: TextStyle(
                  color: Colors.white,
                  fontSize: 17
                ),),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ", style: SimpleTextFielStyle(),),
                  const Text("Register now", style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      decoration: TextDecoration.underline
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50.0,)
            ],
          ),
        ),
      ),
    );
  }
}

InputDecoration textFieldInputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(
      color: Colors.grey,
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.blue)
    ),
    enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey)
    ),
  );
}

TextStyle SimpleTextFielStyle() {
  return const TextStyle(
    color: Colors.black
  );
}