import 'package:flutter/material.dart';

class Homep extends StatefulWidget {
  const Homep({super.key});

  @override
  State<StatefulWidget> createState() => _mystate();
}

class _mystate extends State<Homep> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("welcome"),
      ),
    ));
  }
}
