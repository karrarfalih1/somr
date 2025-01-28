import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropdown Button Example'),
      ),
      body: Center(
        child: DropdownButton<String>(
          hint: const Text("اختر خيارًا"),
          value: selectedOption,
          items: <String>['الخيار الأول','الخيار الثاني', 'الخيار الثالث']
              .map((String valuee) {
            return DropdownMenuItem<String>(
              value: valuee,
              child: Text(valuee),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedOption = newValue;
            });
          },
        ),
      ),
    );
  }
}
