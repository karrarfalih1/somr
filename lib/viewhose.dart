import 'package:flutter/material.dart';
import 'package:somer/materal/titlesignin.dart';
import 'package:cached_network_image/cached_network_image.dart';
class Vieww extends StatelessWidget {
  final String price;
  final String posturl;
  final String postlocation;
  final String posttitle;
  final bool bay;
  final bool mo;
  final bool agric;
  final String numberofroom;
  final String postlocation2;
  final String nuberOftapk;
  final String postphone;
  final String postsize;
  final String gov;
  final String time;
  const Vieww(

      {super.key,
      required this.postlocation2,
      required this.postsize,
      required this.nuberOftapk,
      required this.postphone,
      required this.bay,
      required this.mo,
       required this.numberofroom,

      required this.price,
      required this.posturl,
      required this.postlocation,
      required this.posttitle, required this.gov, required this.agric, required this.time});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
        //  padding: const EdgeInsets.all(10),
          //  height: 00,
          width: 2000,
          child: ListView(
            children: [
              SizedBox(
                width: 2000,
                height: 270,
               
                child: Hero(
                  tag: posturl,
                  child: ClipRRect(
                    borderRadius:const BorderRadius.only(bottomLeft:Radius.circular(20),bottomRight: Radius.circular(20)),
                    child: CachedNetworkImage(imageUrl: posturl,fit: BoxFit.cover,)))
              ),
              Container( 
                margin: const EdgeInsets.only(bottom: 6),
                color: Colors.blue,
                height: 0.1,
                width: 1000,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [const TEXT(testt: "المساحة"), Text("$postsize m2 ")],
                  ),
                  Column(
                    children: [const TEXT(testt: "السعر"), Text("$price IQD")],
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 6),
                color: Colors.blue,
                height: 0.2,
                width: 1000,
              ),
              ListTile(
                subtitle: Text(
                  postlocation2,
                  textDirection: TextDirection.rtl,
                ),
                title: Text(
                  postlocation,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.location_on),
              ),
              Container(
                //   margin: EdgeInsets.only(top: 6),
                color: Colors.blue,
                height: 0.2,
                width: 1000,
              ),
              const ListTile(
                title: Text(
                  " التفاصيل",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.account_tree_outlined),
              ),
              Container(
                  child: Row(
                children: [
                  const Expanded(
                      child: SizedBox(
                    width: 200,
                    height: 3,
                  )),
                  Expanded(
                      child: Container(
                    width: 200,
                    height: 0.2,
                    color: Colors.blue,
                  ))
                ],
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "عدد الغرف  ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.hotel_outlined)
                        ],
                      ),
                      Text(
                       numberofroom,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "عدد الطوابق  ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.home_work_outlined)
                        ],
                      ),
                      Text(
                        nuberOftapk,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(mo==true?"مؤثث":"غير مؤثث"
                     ,
                      textDirection: TextDirection.rtl,
                      style:
                          const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "  حالة الاثاث :",
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                trailing: const Icon(
                  Icons.chair,
                  size: 18,
                ),
              ),     ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(agric==true?"طابو":"زراعي"
                     ,
                      textDirection: TextDirection.rtl,
                      style:
                          const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      " الصنف :",
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                trailing: const Icon(
                  Icons.chair,
                  size: 18,
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                     bay==false?"للبيع":" للايجار",
                      textDirection: TextDirection.rtl,
                      style:
                          const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "   نوع العقار :",
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                trailing: const Icon(
                  Icons.align_horizontal_right_outlined,
                  size: 18,
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                     postphone,
                      textDirection: TextDirection.rtl,
                      style:
                          const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "  الهاتف :",
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  
                  ],
                ),
                trailing: const Icon(
                  Icons.phone,
                  size: 18,
                ),
              ),
                 ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                     time,
                      textDirection: TextDirection.rtl,
                      style:
                          const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "  تاريخ النشر :",
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  
                  ],
                ),
                trailing: const Icon(
                  Icons.date_range,
                  size: 18,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                width: 200,
                height: 0.2,
                color: Colors.blue,
              ),
              const Text(
                "الوصف      ",
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                height: 200,
                width: 2000,
                decoration: BoxDecoration(
                    border: Border.all(width: 0.2, color: Colors.blue)),
                child: Text(
                  posttitle,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(fontSize: 17),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
