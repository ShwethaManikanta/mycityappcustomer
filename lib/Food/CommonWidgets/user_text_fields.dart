import 'package:flutter/material.dart';

class UserTextField extends StatelessWidget {
  final String titleLabel;
  final IconData icon;

  final TextEditingController controller;
  final TextInputType inputType;

  const UserTextField(
      {Key? key,
      required this.titleLabel,
      required this.icon,
      required this.controller,
      required this.inputType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: titleLabel,
          suffixIcon: Icon(
            icon,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            // borderSide: BorderSide(color: Colors.black),
          ),
        ),
        validator: (value) {
          // if (value.length != maxLength) {
          //   if (maxLength == 6) {
          //     return "Minimum 6 Digits Required";
          //   } else {
          //     return "Minimum 10 Digits Required";
          //   }
          // }
          return null;
        },
      ),
    );
  }
}
