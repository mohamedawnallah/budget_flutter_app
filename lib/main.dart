import 'package:flutter/material.dart';

import 'screens/screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Budget UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:HomeScreen(),
    );
  }
}

