import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:somer/test11.dart';



class Addt extends StatefulWidget{
  const Addt({super.key});

  @override
  State<StatefulWidget> createState() => _Mystate();
}


TextEditingController controllersmoney=TextEditingController();
TextEditingController controllername=TextEditingController();
String? money;
CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            "money":controllersmoney.text,
            "ferstname":controllername.text
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

class _Mystate extends State<Addt>{
 
  @override
  void initState() {
   
    
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
       appBar: AppBar(title: const Text("Add element"),),
       body: Column(children: [
        const SizedBox(height: 90,),
        const Text("add any thing",style: TextStyle(fontSize: 40,color: Colors.black),),
        TextFormField(
          controller: controllersmoney,

        ), const SizedBox(height: 30,),
        const Text("feertname"),
        TextFormField(
          
          controller: controllername,

        ),
        MaterialButton(
          child: const Text("Add",style: TextStyle(fontSize: 40,color: Colors.black)),
          
          onPressed: (){
          addUser();
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const realtime()));
        })
       ],),
      ),
    );
  }

}