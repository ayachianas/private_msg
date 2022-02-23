import 'package:flutter/material.dart';
import 'package:private_msg/pages/conversations/conversations.dart';
import 'package:private_msg/widgets/home_appbar.dart';

class SignUp extends StatefulWidget {
  final Function toggle;

  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  signUp() {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: isLoading ? Container(
        child: const Center(child: CircularProgressIndicator(),),
      ) : SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
               Form(
                 key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) {
                        return val!.length>4 ? null : "Username must contain more than 4 characters";
                      },
                      controller: usernameTextEditingController,
                      style: SimpleTextFielStyle(),
                      decoration: textFieldInputDecoration("username")
                    ),
                    TextFormField(
                      validator: (val) {
                        return val!=null && RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val) ? null : "Email must be valid";
                      },
                      controller: emailTextEditingController,
                      style: SimpleTextFielStyle(),
                      decoration: textFieldInputDecoration("email")
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (val) {
                        return val!.length>6 ? null : "Password must contain more than 6 characters";
                      },
                      controller: passwordTextEditingController,
                      style: SimpleTextFielStyle(),
                      decoration: textFieldInputDecoration("password")
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0,),
              GestureDetector(
                onTap: () {
                  signUp();
                },
                child: Container(
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
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? ", style: SimpleTextFielStyle(),),
                  GestureDetector(
                    onTap: () {
                      widget.toggle();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: const Text("Sign In now", style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          decoration: TextDecoration.underline
                        ),
                      ),
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
