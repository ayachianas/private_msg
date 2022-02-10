import 'package:flutter/material.dart';
import 'package:private_msg/widgets/home_appbar.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                  decoration: textFieldInputDecoration("username")
              ),
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
                child: const Text("Sign Up", style: TextStyle(
                  color: Colors.white,
                  fontSize: 17
                ),),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? ", style: SimpleTextFielStyle(),),
                  const Text("Sign In now", style: TextStyle(
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
      )
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
