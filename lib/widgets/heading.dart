import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final label;
  const Heading({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
