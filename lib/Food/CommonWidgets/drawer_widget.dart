import 'package:flutter/material.dart';

Drawer drawer() {
  return Drawer(
    elevation: 2,
    child: SafeArea(
      child: Column(
        children: [const Text("new ")],
      ),
    ),
  );
}
