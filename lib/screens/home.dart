import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:werkraat/screens/login_page.dart';
import 'package:werkraat/widgets/background.dart';
import 'package:werkraat/widgets/custom_bottom_appbar.dart';
import 'package:werkraat/widgets/custom_textfield.dart';
import 'package:werkraat/widgets/header.dart';
import 'package:werkraat/widgets/remember_me.dart';

class Home extends StatefulWidget {
  const Home({Key? key, this.email = ""}) : super(key: key);

  final String email;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List albums = [
    'https://pyxis.nymag.com/v1/imgs/acb/00c/b7f75f4d87758910134354256ae0b66326-lil-nas-x-montero.rsquare.w1200.jpg',
    'https://pyxis.nymag.com/v1/imgs/acb/00c/b7f75f4d87758910134354256ae0b66326-lil-nas-x-montero.rsquare.w1200.jpg',
    'https://pyxis.nymag.com/v1/imgs/acb/00c/b7f75f4d87758910134354256ae0b66326-lil-nas-x-montero.rsquare.w1200.jpg',
    'https://pyxis.nymag.com/v1/imgs/acb/00c/b7f75f4d87758910134354256ae0b66326-lil-nas-x-montero.rsquare.w1200.jpg',
    'https://pyxis.nymag.com/v1/imgs/acb/00c/b7f75f4d87758910134354256ae0b66326-lil-nas-x-montero.rsquare.w1200.jpg',
    'https://pyxis.nymag.com/v1/imgs/acb/00c/b7f75f4d87758910134354256ae0b66326-lil-nas-x-montero.rsquare.w1200.jpg',
    'https://pyxis.nymag.com/v1/imgs/acb/00c/b7f75f4d87758910134354256ae0b66326-lil-nas-x-montero.rsquare.w1200.jpg'
  ];
  double offset = 0;
  @override
  Widget build(BuildContext context) {
    if (offset == 0) {
      offset = MediaQuery.of(context).size.height * 0.2;
    }
    return Scaffold(
      body: Background(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              const Header(
                displayBack: false,
              ),
              Row(
                children: [
                  const Spacer(),
                  Text(
                    'Welkom ${widget.email}!',
                    style: const TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  const Spacer(
                    flex: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      SharedPreferences.getInstance().then((prefs) {
                        prefs.clear();
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: const Text('Uitgelogd'),
                                  content:
                                      const Text('U bent succesvol uitgelogd.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        const LoginPage()));
                                      },
                                      child: const Text('OK'),
                                    )
                                  ],
                                ));
                      });
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.pink,
                      ),
                      height: 50,
                      width: 50,
                      child: Center(
                        child: Text(
                          widget.email[0].toUpperCase(),
                          style: const TextStyle(
                              fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Spacer(),
                                    const Text(
                                      'Ontdekken',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Row(
                                      children: const [
                                        Text('Vind je favoriete nummers',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Spacer(),
                                        Icon(
                                          Icons.play_arrow,
                                          size: 30,
                                          color: Colors.orange,
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 130,
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: [
                                for (String album in albums)
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Image.network(album),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          'Lil Nas X',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onVerticalDragEnd: (details) {
                          int max = 500;
                          int min = 100;

                          if (offset > (((max + min) / 2) - 100)) {
                            Timer.periodic(Duration(microseconds: 100),
                                (timer) {
                              if (offset < max) {
                                setState(() {
                                  offset += 1;
                                });
                              } else {
                                timer.cancel();
                              }
                            });
                          } else {
                            Timer.periodic(Duration(microseconds: 100),
                                (timer) {
                              if (offset > min) {
                                setState(() {
                                  offset -= 1;
                                });
                              } else {
                                timer.cancel();
                              }
                            });
                          }
                        },
                        onVerticalDragUpdate: (details) {
                          setState(() {
                            if (!(offset <= 100 && details.delta.dy > 0) &&
                                !(offset >= 500 && details.delta.dy < 0)) {
                              offset -= details.delta.dy;
                            }
                          });
                        },
                        child: Container(
                          height: offset,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const CustomBottomAppbar(),
            ],
          ),
        ),
      ),
    );
  }
}
