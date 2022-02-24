// Packages
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

// Services
import 'package:private_msg/services/media_service.dart';
import 'package:private_msg/services/database_service.dart';
import 'package:private_msg/services/cloud_storage_service.dart';
import 'package:private_msg/services/navigation_service.dart';

// Widgets
import 'package:private_msg/widgets/custom_input_fields.dart';
import 'package:private_msg/widgets/rounded_button.dart';
import 'package:private_msg/widgets/rounded_image.dart';

// Providers
import 'package:private_msg/providers/authentication_provider.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late double _deviceHeight;
  late double _deviceWidth;

  PlatformFile? _profileImage;

  final _signUpFormKey = GlobalKey<FormState>();

  String? _email;
  String? _password;
  String? _name;

  late AuthenticationProvider _auth;
  late DataBaseService _db;
  late CloudStorageService _cloudStorage;
  late NavigationService _navigation;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    _db = GetIt.instance.get<DataBaseService>();
    _cloudStorage = GetIt.instance.get<CloudStorageService>();
    _navigation = GetIt.instance.get<NavigationService>();
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.03, vertical: _deviceHeight * 0.02),
        height: _deviceHeight * 0.98,
        width: _deviceWidth * 0.97,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _profileImageField(),
            SizedBox(
              height: _deviceHeight * 0.05,
            ),
            _signUpForm(),
            SizedBox(
              height: _deviceHeight * 0.05,
            ),
            _signUpButton(),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileImageField() {
    return GestureDetector(
      onTap: () {
        GetIt.instance.get<MediaService>().pickImageFromLibrary().then((_file) {
          setState(() {
            _profileImage = _file;
          });
        });
      },
      child: () {
        if (_profileImage != null) {
          return RoundedImageFile(
              key: UniqueKey(),
              image: _profileImage!,
              size: _deviceHeight * 0.15);
        } else {
          return RoundedImageNetwork(
            key: UniqueKey(),
            imagePath:
                "https://firebasestorage.googleapis.com/v0/b/private-msg-ba7d7.appspot.com/o/images%2Fusers%2FJHbOzwBSgYYKZ8Dqk8qme3LpEw33%2Fprofile.png?alt=media&token=90b669e1-c17a-4254-9ae2-8cbf212363d9",
            size: _deviceHeight * 0.15,
          );
        }
      }(),
    );
  }

  Widget _signUpForm() {
    return Container(
      height: _deviceHeight * 0.35,
      child: Form(
        key: _signUpFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
                onSaved: (_value) {
                  setState(() {
                    _name = _value;
                  });
                },
                regEx: r".{6,}",
                hintText: "Name",
                obscureText: false),
            CustomTextFormField(
                onSaved: (_value) {
                  setState(() {
                    _email = _value;
                  });
                },
                regEx:
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                hintText: "Email",
                obscureText: false),
            CustomTextFormField(
                onSaved: (_value) {
                  setState(() {
                    _password = _value;
                  });
                },
                regEx: r".{6,}",
                hintText: "Password",
                obscureText: true),
          ],
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return RoundedButton(
      name: "Sign Up",
      height: _deviceHeight * 0.065,
      width: _deviceWidth * 0.65,
      onPressed: () async {
        if (_signUpFormKey.currentState!.validate() && _profileImage!= null) {
          _signUpFormKey.currentState!.save();
          String? _uid = await _auth.signUpUsingEmailAndPassword(_email!, _password!);
          String? _imageURL = await _cloudStorage.saveUserImageToStorage(_uid!, _profileImage!);
          await _db.createUser(_uid, _email!, _name!, _imageURL!);
          await _auth.logout();
          await _auth.signInUsingEmailAndPassword(_email!, _password!);
        }
      },
    );
  }
}
