

import 'package:flutter/material.dart';


class botomc extends StatelessWidget{
  final void Function()? onpressed;
  final String textbotum;
  const botomc({super.key,required this.onpressed, required this.textbotum});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1000,
      child: MaterialButton(
        height: 50,
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        textColor: Colors.blue,
        
        color: Colors.blue[50],
        onPressed:onpressed,
        child: Text(
          textAlign: TextAlign.center,
          
          textbotum,style: const TextStyle(fontSize: 20),)),
    );
  }
}