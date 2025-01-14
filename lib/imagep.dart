import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:somer/materal/titlesignin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState()=> _Mystate();
}
 class _Mystate extends State<MyApp>{

File? file1;
   getimage()async{
  final ImagePicker picker = ImagePicker();
// Pick an image.
final XFile? image = await picker.pickImage(source: ImageSource.camera);
// Capture a photo.
//final XFile? photo = await picker.pickImage(source: ImageSource.camera);
file1=File(image!.path);
setState(() {
  
});
   }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("cameeera"),),
        body: Container(
          width: 1000,
          color: Colors.amber,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             // SizedBox(height: 50,),
              MaterialButton(
                color: Colors.grey,
                
                onPressed: ()async{
                
                await getimage();
          
              },
                child: const TEXT(testt: "tack mey pic1")),
              if(file1 !=null)Image.file(file1!,fit: BoxFit.contain,width: 500,height: 500,)
          
            ],
          ),
        ),
      ),

    );
  }

 }
/**File? file1;
 
 getimage()async{
  final ImagePicker picker = ImagePicker();
// Pick an image.
final XFile? image = await picker.pickImage(source: ImageSource.gallery);
// Capture a photo.
//final XFile? photo = await picker.pickImage(source: ImageSource.camera);
file1=File(image!.path);


 } */