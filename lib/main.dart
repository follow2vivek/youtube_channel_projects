import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
      themeMode: ThemeMode.light,
      theme: ThemeData(primarySwatch: Colors.amber),
    ),
  );
}

class Home extends StatelessWidget {
  const Home({Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(),
    );
  }
}
