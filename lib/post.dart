import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:somer/materal/botom.dart';
import 'package:somer/materal/chosebtween.dart';
import 'package:somer/materal/intext.dart';

class Post extends StatefulWidget {
  final String catogreyid;
  const Post({super.key, required this.catogreyid});

  @override
  State<StatefulWidget> createState() => _Mystate();
}

class _Mystate extends State<Post> {
  String? selectpotionofnumberofroom;
  String? selectpotionoftabk;
  String? selectgov;
  final _formKey = GlobalKey<FormState>();
  String? url;
  File? file1;
  bool mo1 = true;
  bool nomo = false;
  bool egar = true;

bool agric=true;
  bool bay = false;
  List<String> suggestions = [
  "الكل",
    "بغداد",
    "ذي قار",
    "بصرة",
    "سماوة",
    "ميسان",
    "تكريت",
    "النجف",
    "كربلاء",
    "الانبار",
    "بابل",
    "كركوك",
    "السليمانية"
  ];

  TextEditingController postprice = TextEditingController();
  TextEditingController posttitle = TextEditingController();
  TextEditingController postlocation = TextEditingController();
  TextEditingController postlocation2 = TextEditingController();
  TextEditingController postdescription = TextEditingController();
  TextEditingController postsize = TextEditingController();
  TextEditingController postphone = TextEditingController();

  // Function to pick an image from the gallery
  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      file1 = File(image.path);
      var imageName = basename(file1!.path);
      var refStorage = FirebaseStorage.instance.ref("imgp").child(imageName);
      await refStorage.putFile(file1!);
      url = await refStorage.getDownloadURL();
      setState(() {});
    }
  }

  // Reference to Firestore collection
  CollectionReference posts = FirebaseFirestore.instance.collection("users");

  // Function to add a new post to Firestore
  Future<void> addPost() {
    return posts.add({
      "postprice": postprice.text,
      "posttitle": posttitle.text,
      "postlocation": postlocation.text,
      "postlocation2": postlocation2.text,
      "posturl": url.toString(),
      "postsize": postsize.text,
      "postphone": postphone.text,
      "mo": mo1,
      "bay": bay,
      "numberofroom": selectpotionofnumberofroom.toString(),
      "nuberOftapk": selectpotionoftabk.toString(),
      "gov": selectgov.toString(),
      "agric":agric,
      "time": FieldValue.serverTimestamp(),
    });
  }

  // Main build method to create the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("اضافة منشور"),
          backgroundColor: Colors.teal,
        ),
        body: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.all(20),
            child: ListView(
              children: [
                InkWell(
                  child: Container(
                    color: Colors.blue[50],
                    width: 400,
                    height: 200,
                    child: url == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: const Icon(
                                    Icons.add_photo_alternate,
                                    size: 70,
                                  )),
                              const Text("اضف صورة العقار")
                            ],
                          )
                        : Image.file(
                            file1!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                clatext(
                  keyboardtype: TextInputType.number,
                  hinttext: 'السعر',
                  mycontroller: postprice,
                  validator: (val) {
                    if (val == "") {
                      return "هذا الحقل مطلوب";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding:const EdgeInsets.symmetric(horizontal: 100),
                  decoration: BoxDecoration(

                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      
                    
                    )
                  ),
                  width: 150,
                  height: 50,
                  child: DropdownButton<String>(
                      //هذا لالغاء الخط الخفيف في  البوتوم
                      underline: const SizedBox.shrink(),
                      value: selectgov,
                      hint: Container( child: const Center(child: Text("المحافضة "))),
                      items: <String>[
                        suggestions[0],
                        suggestions[1],
                        suggestions[2],
                        suggestions[3],
                        suggestions[4],
                        suggestions[5],
                        suggestions[6],
                        suggestions[7],
                        suggestions[8],
                        suggestions[9],
                        suggestions[10],
                        suggestions[11]
                      ].map((String valuee) {
                        return DropdownMenuItem<String>(
                          value: valuee,
                          child: Text("     $valuee"),
                        );
                      }).toList(),
                      onChanged: (String? newvalue) {
                        setState(() {
                          selectgov = "$newvalue";
                        });
                      }),
                ),
                const SizedBox(
                  height: 15,
                ),
                clatext(
                  hinttext: 'القضاء او الحي  واقرب نقطه داله',
                  mycontroller: postlocation2,
                  validator: (val) {
                    if (val == "") {
                      return "هذا الحقل مطلوب";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                clatext(
                  hinttext: 'الوصف (اضف ملاحضاتك )',
                  mycontroller: posttitle,
                  validator: (val) {
                    if (val == "") {
                      return "هذا الحقل مطلوب";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                clatext(
                  keyboardtype: TextInputType.number,
                  hinttext: 'المساحة ',
                  mycontroller: postsize,
                  validator: (val) {
                    if (val == "") {
                      return "هذا الحقل مطلوب";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                clatext(
                  keyboardtype: TextInputType.number,
                  hinttext: 'رقم الهاتف ',
                  mycontroller: postphone,
                  validator: (val) {
                    if (val == "") {
                      return "هذا الحقل مطلوب";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    //   height:23,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Chose(
                          titlle: 'مؤثث',
                          ontap: () {
                            setState(() {
                              mo1 = true;
                              nomo = false;
                            });
                          },
                          colorr:
                              mo1 == true ? Colors.blue[50] : Colors.grey[200]),
                      Chose(
                          titlle: 'غير مؤثث',
                          ontap: () {
                            setState(() {
                              mo1 = false;
                              nomo = true;
                            });
                          },
                          colorr: nomo == true
                              ? Colors.blue[50]
                              : Colors.grey[200]),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    //   height:23,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Chose(
                          titlle: 'زراعي',
                          ontap: () {
                            setState(() {
                           agric=false;
                            });
                          },
                          colorr:
                              agric == false ? Colors.blue[50] : Colors.grey[200]),
                      Chose(
                          titlle: 'طابو',
                          ontap: () {
                            setState(() {
                            agric=true;
                            });
                          },
                          colorr: agric == true
                              ? Colors.blue[50]
                              : Colors.grey[200]),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    //   height:23,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Chose(
                          titlle: 'للبيع ',
                          ontap: () {
                            setState(() {
                              egar = true;
                              bay = false;
                            });
                          },
                          colorr: egar == true
                              ? Colors.blue[50]
                              : Colors.grey[200]),
                      Chose(
                          titlle: 'للايجار',
                          ontap: () {
                            setState(() {
                              egar = false;
                              bay = true;
                            });
                          },
                          colorr:
                              bay == true ? Colors.blue[50] : Colors.grey[200]),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: selectpotionoftabk == null
                              ? Colors.grey[200]
                              : Colors.blue[50],
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      width: 150,
                      height: 50,
                      child: DropdownButton<String>(
                          //هذا لالغاء الخط الخفيف في  البوتوم
                          underline: const SizedBox.shrink(),
                          value: selectpotionoftabk,
                          hint: const Text("          عدد الطوابق"),
                          items: <String>["1", "2", "3", "4", "5"]
                              .map((String valuee) {
                            return DropdownMenuItem<String>(
                                value: valuee,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("     $valuee"),
                                    const Text(" عدد الطوابق   "),
                                  ],
                                ));
                          }).toList(),
                          onChanged: (String? newvalue) {
                            setState(() {
                              selectpotionoftabk = "$newvalue";
                            });
                          }),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: selectpotionofnumberofroom == null
                              ? Colors.grey[200]
                              : Colors.blue[50],
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      width: 150,
                      height: 50,
                      child: DropdownButton<String>(
                          //هذا لالغاء الخط الخفيف في  البوتوم
                          underline: const SizedBox.shrink(),
                          value: selectpotionofnumberofroom,
                          hint: const Text("         عدد الغرف"),
                          items: <String>[
                            "1",
                            "2",
                            "3",
                            "4",
                            "5",
                            "6",
                            "7",
                            "8",
                            "9",
                            "10",
                            "11",
                            "12",
                            "13",
                            "14",
                            "15",
                            "16"
                          ].map((String valuee) {
                            return DropdownMenuItem<String>(
                                value: valuee,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("     $valuee"),
                                    const Text(" عدد الغرف   "),
                                  ],
                                ));
                          }).toList(),
                          onChanged: (String? newvalue) {
                            setState(() {
                              selectpotionofnumberofroom = "$newvalue";
                            });
                          }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                botomc(
                  onpressed: () {

                    if(url !=null){ 

                
                      
                        if (_formKey.currentState!.validate()) {

                      addPost();

                      //    Navigator.of(context).pushNamed("pageone");
                     

           
                    }}else{

                    showDialog(context: context, builder: (context){
                      return const AlertDialog(
                        title: Text("تنبيه"),
                       content:  Text("يجب  تحديد صورة للعقار"),
                      );
                    });
                    }
                 
                  },
                  textbotum: 'نشر',
                )
              ],
            ),
          ),
        ));
  }
}
