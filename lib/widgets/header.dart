import 'package:flutter/material.dart';
import 'dart:async';

import 'elevated_container.dart';

//The form header with the timer for the Ticket Page, the functionality of the action to take when the time runs out needs to be implemented.

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 900;
  int currentSeconds = 0;
  Timer? _timerNew;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(0, '0')}:${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([int? milliseconds]) {
    var duration = interval;
    _timerNew = Timer.periodic(duration, (timer) {
      setState(() {
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
      });
    });
  }

  @override
  void initState() {
    startTimeout();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timerNew!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      color: Color(0xffEB3070),
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "TICKET SECURED",
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          SizedBox(height: 32),
          Text(
            "${timerText} remaining",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(height: 32),
          Text(
            "You have the full 15 minutes to complete payment, so don't rush",
            style: TextStyle(fontSize: 14, color: Colors.white),
          )
        ],
      ),
    );
  }
}
