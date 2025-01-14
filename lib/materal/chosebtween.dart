


import 'package:flutter/material.dart';


class Chose extends StatelessWidget{
 
  final String titlle;
  final void Function()? ontap;
  final Color? colorr;
  const Chose({super.key, required this.titlle, required this.ontap,required this.colorr});
  @override
  Widget build(BuildContext context) {
    return   InkWell(
              onTap: ontap,
                child: Container(
                    
                  decoration: BoxDecoration(
                     color: colorr, 
                     border: Border.all(color:colorr==Colors.blue[50]?Colors.blue:colorr!,
                     width: colorr ==Colors.blue[50]?1:0),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),bottomRight: Radius.circular(30))
                  ),
                  width: 150,
                  height: 50,
                      
                  child: Center(child: Text(titlle,textAlign: TextAlign.center,)),
                ),
              
    );
  }
}