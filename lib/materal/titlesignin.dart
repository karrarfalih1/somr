
import 'package:flutter/material.dart';

class  TEXT extends StatelessWidget{
  final String    testt;
  const TEXT ({super.key ,required this.testt});
  @override
  Widget build(BuildContext context) {
    return Text(testt, style:
                          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),);
  }


}