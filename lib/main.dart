import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qpay/models/ticket_provider.dart';
import 'screens/home_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => TicketInfo(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QPay',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
