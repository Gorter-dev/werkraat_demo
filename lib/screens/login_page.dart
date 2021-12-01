import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:werkraat/screens/home.dart';
import 'package:werkraat/widgets/background.dart';
import 'package:werkraat/widgets/custom_button.dart';
import 'package:werkraat/widgets/custom_textfield.dart';
import 'package:werkraat/widgets/header.dart';
import 'package:werkraat/widgets/remember_me.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    () async {
      _prefs = await SharedPreferences.getInstance();
      if (_prefs != null) {
        if (_prefs?.getString('email') != null ||
            _prefs?.getString('email') != "") {
          RememberMe.value = _prefs?.getBool('rememberMe') ?? false;
          if (RememberMe.value) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Home(
                  email: _prefs!.getString('email')!,
                ),
              ),
            );
          }
        }
      }
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              const Header(
                displayBack: true,
              ),
              const Spacer(
                flex: 5,
              ),
              const Text(
                "Inloggen",
                style: TextStyle(fontSize: 45, color: Colors.white),
              ),
              const Spacer(),
              CustomTextfield(
                controller: _emailController,
                label: "Email",
              ),
              CustomTextfield(
                isPasswordField: true,
                controller: _passwordController,
                label: "Wachtwoord",
              ),
              const RememberMe(),
              const Spacer(
                flex: 3,
              ),
              CustomButton(
                text: "Inloggen",
                onPressed: () async {
                  if (_emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    UserCredential user = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text);

                    print(user.user!.email);

                    // if (_prefs != null) {
                    // _prefs!.setString("email", _emailController.text);
                    // _prefs!.setString("password", _passwordController.text);
                    // _prefs!.setBool("rememberMe", RememberMe.value);
                    // }
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => Home(
                          email: _emailController.text,
                        ),
                      ),
                    );
                  }
                },
              ),
              const Spacer(),
              const Text(
                'Wachtwoord vergeten?',
                style: TextStyle(
                    color: Colors.white, decoration: TextDecoration.underline),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Nog geen account? ',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Registreer',
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
