import 'package:flutter/material.dart';

class ShowButton extends StatelessWidget {
  const ShowButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text("Login"),
      style: TextButton.styleFrom(
        primary: Colors.white, //Text Color
        backgroundColor:
            Color.fromARGB(255, 0, 173, 185), //Button Background Color
      ),
      onPressed: () {},
    );
  }
}
