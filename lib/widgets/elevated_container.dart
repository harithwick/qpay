import 'package:flutter/material.dart';

//Custom built container for minimal styling

class ElevatedContainer extends StatelessWidget {
  final Widget widget;
  final Color color;
  const ElevatedContainer({Key? key, required this.widget, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            width: 700,
            child: Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(32),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: color,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: widget)));
  }
}
