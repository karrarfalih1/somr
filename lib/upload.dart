import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:somer/materal/titlesignin.dart';

void main() {
  runApp(const Upload());
}

class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<StatefulWidget> createState()=> _Mystate();
}
 class _Mystate extends State<Upload>{
String? url;
File? file1;
   getimage()async{
  final ImagePicker picker = ImagePicker();
// Pick an image.
final XFile? image = await picker.pickImage(source: ImageSource.camera);
// Capture a photo.
//final XFile? photo = await picker.pickImage(source: ImageSource.camera);

if(image !=null){

file1=File(image.path);
var imagename=basename(file1!.path);

  var refStorge=FirebaseStorage.instance.ref("imgp").child(imagename);
await refStorge.putFile(file1!);
url= await refStorge.getDownloadURL();


}

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
              if(url !=null)Image.network(url!,fit: BoxFit.contain,width: 500,height: 500,)
          
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