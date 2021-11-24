import 'package:flutter/material.dart';
import 'package:werkraat/screens/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.red,
        unselectedWidgetColor: Colors.white,
      ),
      home: const LoginPage(),
    );
  }
}
