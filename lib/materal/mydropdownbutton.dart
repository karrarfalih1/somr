

import 'package:flutter/material.dart';


class Mydrop extends StatelessWidget{
final void Function(String?)? onchanged;
  String selectpotionofnumberofroom;
  String hint;

   Mydrop({super.key, required this.selectpotionofnumberofroom,required this.onchanged,required this.hint});
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
                    value: selectpotionofnumberofroom,
                    hint: Text(hint),
                    items:<String>["1","2"]
                    .map((String valuee){
                      return DropdownMenuItem<String>(
                         value : valuee,
                         child:Text("$hint  $valuee")
                      
                      
                      );
                    }).toList(), onChanged:onchanged);
  }
}