import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header(
      {Key? key,
      this.displayBack = true,
      this.image =
          "http://www.werkraat.nl/resources/images/logos/logo-werkraat-280px.png"})
      : super(key: key);

  /// This determines whether to display the back arrow or not
  final bool displayBack;

  /// Source location of the network image
  final String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: displayBack
              ? const Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 40,
                )
              : Container(),
        ),
        const Spacer(),
        SizedBox(
          height: 50,
          child:
              // Image.asset('assets/images/logo.png'),
              Image.network(image),
        ),
        const Spacer(),
        const SizedBox(
          width: 40,
        ),
      ],
    );
  }
}
