import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:somer/materal/botom.dart';
import 'package:somer/materal/intext.dart';
import 'package:somer/materal/titlesignin.dart';


class Post extends StatefulWidget {
  final String catogreyid;
const  Post({super.key, required this.catogreyid,});

  @override
  State<StatefulWidget> createState()=> _Mystate();
}
 class _Mystate extends State<Post>{
 final _formKey = GlobalKey<FormState>();
String? url;
File? file1;
   getimage()async{
  final ImagePicker picker = ImagePicker();
// Pick an image.
final XFile? image = await picker.pickImage(source: ImageSource.gallery);
// Capture a photo.
//final XFile? photo = await picker.pickImage(source: ImageSource.camera);

if(image !=null){

file1=File(image.path);
var imagename=basename(file1!.path);

  var refStorge=FirebaseStorage.instance.ref("imgp").child(imagename);
await refStorge.putFile(file1!);
url= await refStorge.getDownloadURL();


}

   }


  
TextEditingController postprice =TextEditingController();
TextEditingController posttitle =TextEditingController();
TextEditingController postlocation =TextEditingController();





 CollectionReference postt  =FirebaseFirestore.instance.collection("users");
Future<void> addpost(){

  return postt.add({
"postprice":postprice.text,
"posttitle":posttitle.text,
"postlocation":postlocation.text,

"posturl":url.toString()
  }
    
  );
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
       
        appBar: AppBar(title: const Text("cameeera"),),
        body: Form(
          key: _formKey,
          child: Container(
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
              clatext(
                          hinttext: 'enter your title posst ',
                          mycontroller: posttitle,
                          validator: (val) {
                            if (val == '') {
                              return "اكتب اسمك يا حاج";
                            }
                            return null;
                          }), clatext(
                          hinttext: 'enter your price ',
                          mycontroller: postprice,
                          validator: (val) {
                            if (val == '') {
                              return "اكتب اسمك يا حاج";
                            }
                            return null;
                          }),
                           clatext(
                          hinttext: 'enter your location ',
                          mycontroller: postlocation,
                          validator: (val) {
                            if (val == '') {
                              return "اكتب اسمك يا حاج";
                            }
                            return null;
                          }),
                          botomc(onpressed: (){
                            if(_formKey.currentState!.validate()){
                              addpost();
                          //    Navigator.of(context).pushNamed("pageone");
                                Navigator.of(context).pop();
                            }
          
                          }, textbotum: "goooooooooo")
               // if(url !=null)Image.network(url!,fit: BoxFit.contain,width: 500,height: 500,)
           
              ],
            ),
          ),
        ),
      ),

    );
  }

 }