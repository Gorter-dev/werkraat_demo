import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
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
  AudioPlayer player = AudioPlayer();

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
                    //* SIGN IN
                    UserCredential user = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text);

                    print(user.user!.email);

                    //* CREATE USER PROFILE IN DATABASE
                    FirebaseFirestore.instance
                        .collection("userData")
                        .doc(user.user!.uid)
                        .set({
                      "name": "Steven",
                      "email": user.user!.email,
                      "songs": [
                        "song1",
                        "song2",
                        "song3",
                      ]
                    });

                    //* ADD FILE FROM ASSETS TO STORAGE
                    // Uint8List data;
                    // final ByteData bytes =
                        // await rootBundle.load('assets/images/song.mp3');
                    // data = bytes.buffer.asUint8List();
                    // try {
                    //   await FirebaseStorage.instance
                    //       .ref()
                    //       .child("songs")
                    //       .child("song2.mp3")
                    //       .putData(data);
                    // } catch (e) {
                    //   print("ERROR: $e");
                    // }

                    //* GET USER PROFILE
                    List mySongs = [];
                    DocumentSnapshot doc = await FirebaseFirestore.instance
                        .collection("userData")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get();
                    mySongs = (doc.data() as Map<String, dynamic>)["songs"];
                    print(mySongs);

                    //* GET URL FROM SONG
                    String url = await FirebaseStorage.instance
                        .ref()
                        .child("songs")
                        .child("song2")
                        .getDownloadURL();
                    print(url);

                    //* SET URL TO AUDIO PLAYER
                    player.setUrl(url);

                    //* PLAY AUDIO
                    player.play();

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
