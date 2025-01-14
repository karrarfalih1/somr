import 'package:flutter/material.dart';

class Logo extends StatefulWidget{
  const Logo({super.key});

  @override
  State<StatefulWidget> createState()=> _mystate();
}

class _mystate extends State<Logo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 15),
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.blue[50],
                    borderRadius: const BorderRadius.all(Radius.circular(60))
                  ),
                  child: Image.asset("images/home-button.png",fit: BoxFit.fill,),
                 
              ),
    );
  }

}