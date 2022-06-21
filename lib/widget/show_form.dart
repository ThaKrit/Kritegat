// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ShowForm extends StatelessWidget {
  final IconData iconData;
  final Function(String) changeFung;
  final String hint;
  const ShowForm({
    Key? key,
    required this.iconData,
    required this.changeFung,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: changeFung,
      decoration: InputDecoration(
        //prefixIcon: icon ด้านหน้า
        suffixIcon: Icon(iconData), //icon ด้านหลัง
        contentPadding: const EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: hint,
      ),
    );
  }
}

// //แบบที่ดูจากในเน็ต ShowTextfeil
// class ShowTextfeil extends StatelessWidget {
//   const ShowTextfeil({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//           child: TextField(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               hintText: 'Username',
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//           child: TextFormField(
//             decoration: const InputDecoration(
//               border: OutlineInputBorder(),
//               labelText: 'Password',
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
