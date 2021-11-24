import 'package:flutter/material.dart';

class CustomBottomAppbar extends StatelessWidget {
  const CustomBottomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 75,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.home,
                color: Colors.orange,
                size: 30,
              ),
              Text(
                'Home',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 15,
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.search,
                color: Colors.orange,
                size: 30,
              ),
              Text(
                'Zoeken',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 15,
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.library_music,
                color: Colors.orange,
                size: 30,
              ),
              Text(
                'Bibliotheek',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 15,
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.person,
                color: Colors.orange,
                size: 30,
              ),
              Text(
                'Profiel',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 15,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
