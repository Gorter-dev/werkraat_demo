import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield(
      {Key? key,
      required this.label,
      required this.controller,
      this.isPasswordField = false})
      : super(key: key);

  final String label;
  final bool isPasswordField;
  final TextEditingController controller;

  @override
  _CustomTextfieldState createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool obscureText = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: 60,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1),
        child: TextField(
          obscureText: obscureText,
          controller: widget.controller,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.0),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.0),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            suffix: widget.isPasswordField
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: Icon(obscureText
                      ? Icons.visibility
                      : Icons.visibility_off),
                  color: Colors.black,
                )
                : null,
            labelStyle: const TextStyle(color: Colors.grey),
            floatingLabelStyle: const TextStyle(color: Colors.red),
            hintText: widget.label,
          ),
        ),
      ),
    );
  }
}
