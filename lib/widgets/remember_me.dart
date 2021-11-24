import 'package:flutter/material.dart';

class RememberMe extends StatefulWidget {
  const RememberMe({Key? key}) : super(key: key);

  static bool value = false;
  @override
  _RememberMeState createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.all(13),
                ),
              ),
              Transform.scale(
                scale: 1.5,
                child: Checkbox(
                  value: RememberMe.value,
                  onChanged: (v) {
                    setState(() {
                      RememberMe.value = v!;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
          const Text(
            'Onthouden',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
