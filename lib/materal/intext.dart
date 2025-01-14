import 'package:flutter/material.dart';

class clatext extends StatelessWidget {
  final String hinttext;
  final String? Function(String?)? validator;
  final String? errortext;
  final bool typetext;
  final void Function(String)? auto;
 final TextAlign textalign;
 final TextInputType? keyboardtype;
  final TextEditingController mycontroller;

   const clatext({
    
    super.key,
    required this.hinttext,
    required this.mycontroller,
    required this.validator,
this.keyboardtype,
    this.auto,
    this.errortext,
    this.typetext=false,
    this.textalign=TextAlign.center

  });
  @override
  Widget build(Object context) {
    return TextFormField(
      keyboardType: keyboardtype,
      obscureText: typetext,
      validator: validator,
      controller: mycontroller,
      onChanged: auto,
      textAlign:textalign ,
      decoration: InputDecoration(
        
          errorText: errortext,
          hintText: hinttext,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
          contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(50)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.blue[50]),
    );
  }
}
