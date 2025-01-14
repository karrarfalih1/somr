import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:somer/post.dart';

class Pageonee extends StatefulWidget {
  const Pageonee({super.key});

  @override
  State<StatefulWidget> createState() => _mystate();
}

class _mystate extends State<Pageonee> {
final Stream<QuerySnapshot>userstream=FirebaseFirestore.instance.collection("users").snapshots();
  List mydata=[];
 GetData()async{
   QuerySnapshot querySnapshot=await FirebaseFirestore.instance.collection("users").get();

    mydata.addAll(querySnapshot.docs);
/*
final user = FirebaseAuth.instance.currentUser;
FirebaseFirestore.instance.collection('users').doc(user?.uid).get().then((doc) {
  mydata[0]=(doc['ferstname']) ;
  mydata[1]=(doc['email']) ;
  //mydata[2]=(doc['email']);

  return mydata;
}

)*/
}
  
  PageController? _pageController;
  int _currentPage = 0;
  Timer? _timer;

  List<String> homeh = [
    "images/home2.jpg",
    "images/home2.jpg",
    "images/home2.jpg",
    "images/home2.jpg",
    "images/home2.jpg",
    "images/home2.jpg",
    "images/home2.jpg",
  ];

  List mdn = [
    ["images/home2.jpg", "بغداد"],
    ["images/home2.jpg", "ذي قار"],
    ["images/home2.jpg", "بغداد"],
    ["images/home2.jpg", "ذي قار"],
    ["images/home2.jpg", "بغداد"],
    ["images/home2.jpg", "ذي قار"],
  ];
  List dataq = [
    {
      "img": "images/home2.jpg",
      "price": "300,000,000",
      "location": "ذي قار  /",
      "longlocation": "ذي قار / الخراف/ حي الحرية ",
      "phone": "07817132038",
      "title": "شقة سكنية"
    },
    {
      "img": "images/home2.jpg",
      "price": "300,000,000",
      "location": "ذي قار  /",
      "longlocation": "ذي قار / الخراف/ حي الحرية ",
      "phone": "07817132038",
      "title": "شقة سكنية"
    },
    {
      "img": "images/home2.jpg",
      "price": "300,000,000",
      "location": "ذي قار  /",
      "longlocation": "ذي قار / الخراف/ حي الحرية ",
      "phone": "07817132038",
      "title": "شقة سكنية"
    },
    {
      "img": "images/home2.jpg",
      "price": "300,000,000",
      "location": "ذي قار  /",
      "longlocation": "ذي قار / الخراف/ حي الحرية ",
      "phone": "07817132038",
      "title": "شقة سكنية"
    },
    {
      "img": "images/home2.jpg",
      "price": "300,000,000",
      "location": "ذي قار  /",
      "longlocation": "ذي قار / الخراف/ حي الحرية ",
      "phone": "07817132038",
      "title": "شقة سكنية"
    },
    {
      "img": "images/home2.jpg",
      "price": "300,000,000",
      "location": "ذي قار  /",
      "longlocation": "ذي قار / الخراف/ حي الحرية ",
      "phone": "07817132038",
      "title": "شقة سكنية"
    },
    {
      "img": "images/home2.jpg",
      "price": "300,000,000",
      "location": "ذي قار  /",
      "longlocation": "ذي قار / الخراف/ حي الحرية ",
      "phone": "07817132038",
      "title": "شقة سكنية"
    },
  ];
  @override
  void initState() {
   GetData();
    setState(() {
      
    });
    super.initState();
    _pageController = PageController(initialPage: _currentPage);

    // تصحيح استخدام Timer.periodic
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      setState(() {
        if (_currentPage < homeh.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        // تصحيح في Duration و animateToPage
        if (_pageController!.hasClients) {
          _pageController?.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.linear,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    // إلغاء المؤقت والتحكم عند التخلص من الصفحة
    _timer?.cancel();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        endDrawer: Drawer(
          //لنتمكن من  عكس العناصر 
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView(
              children: const [
      
           ],
            ),
          ),
        ),
         floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Post(catogreyid: FirebaseAuth.instance.currentUser!.uid,)));
        },child: const Icon(Icons.post_add),),
        appBar: AppBar(
          backgroundColor: Colors.blue[200],
          elevation: 8,
          leading: InkWell(
            onTap: ()async{
              await FirebaseAuth.instance.signOut();

            },
            child: const Icon(
              
              
              Icons.notification_add),
          ),
          title: const Row(
            children: [
              SizedBox(width: 60),
              Text(
                "قارات",
                style: TextStyle(
                  color: Colors.red,
                  // fontFamily: "fontarp",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "ع",
                style: TextStyle(
                  //     fontFamily: "fontarpa",
                  fontSize: 40,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.grey[200],
          height: 2000,
          width: 2000,
          child: StreamBuilder(stream: userstream, builder: (context,AsyncSnapshot<QuerySnapshot> snpshott){
            if(snpshott.hasError){
              return const Text("error");

            }
            if(snpshott.connectionState==ConnectionState.waiting){
              return const Text("lodding...");

            } return ListView.builder(
          
          itemCount: snpshott.data!.docs.length,
          itemBuilder: ( context, index) { 

            return  ListView(
              children: [
                Container(
                  //  color: Colors.red,
                  padding: const EdgeInsets.all(10),
            
                  height: 200,
            
                  child: PageView.builder(
                    controller: _pageController, // يجب إعادة تمكين هذا
                    itemCount: homeh.length,
            
                    itemBuilder: (context, index) => ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Image.asset(
                        homeh[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 20,),
            
                Container(
                  margin: const EdgeInsets.all(10),
                  // padding: EdgeInsets.all(10),
                  width: 800,
                  height: 50,
                  color: Colors.green,
            
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.grey[350],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: 40,
                          width: 40,
            //margin:EdgeInsets.all(20),
            
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [Icon(Icons.search)],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              color: Colors.grey[350],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          height: 40,
                          width: 50,
                          child: const Text(
                            "للايجار",
                            style: TextStyle(
                                //fontFamily: "fontarp",
                                fontSize: 20),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: Colors.grey[350],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          height: 40,
                          width: 50,
                          child: const Text(
                            "للبيع",
                            style: TextStyle(
                                //fontFamily: "fontarp",
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mdn.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Stack(
                          alignment: const Alignment(0.6, 0.85),
                          children: [
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 100,
                                width: 100,
                                //padding: EdgeInsets.all(10),
            
                                decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      mdn[index][0],
                                      fit: BoxFit.cover,
                                    ))),
                            Text(
                              mdn[index][1],
                              style: const TextStyle(
                                  //    fontFamily: "fontarpa",
                                  color: Colors.black,
                                  fontSize: 20),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(
                    "اقتراحات قد تعجبك   ",
                    style: TextStyle(fontSize: 20),
                  ),
                ]),
            
             GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snpshott.data!.docs.length,
                  //  itemCount: mydata.length,
                 //   itemCount: dataq.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.65, crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        height: 50,
                        width: 50,
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
            
        //    child: Image.network(mydata[index]["posturl"],fit: BoxFit.contain  ),
          
            child:  Image.network(snpshott.data!.docs[index]["posturl"]),
                           //         child: Image.asset(
                             //         dataq[index]["img"],
                               //       fit: BoxFit.cover, )
                                   
                                    
                                    ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 2000,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  textDirection: TextDirection
                                      .rtl, // تحديد اتجاه النص من اليمين إلى اليسار
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
            
                                    
            Text(snpshott.data!.docs[index]["posttilte"]),
         //   Text(mydata[index]["posttitle"])  ,   
                               //     Text(
                                   //   dataq[index]["title"],
                                     // style: const TextStyle(
                                       //   fontSize: 24,
                                         // fontWeight: FontWeight.bold), ),
            Text(snpshott.data!.docs[index]["postprice"]),
                                  
         //   Text(mydata[index]["postprice"]),
                               
                                  //  Text(       dataq[index]["price"],
                                    //  style: TextStyle(
                                      //    fontSize: 18,
                                        //  fontWeight: FontWeight.bold,
                                          //color: Colors.blue[300]), ),
                                 
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
              Text(snpshott.data!.docs[index]["postlocation"])      ,                    
            //Text(mydata[index]["postlocation"]),
                                     //   Text(    dataq[index]["location"],
                                       //   style: const TextStyle(
                                         //     fontSize: 18,
                                           //   fontWeight: FontWeight.bold,
                                             // color: Colors.grey),  ),
                                      
            
            
                                        const Icon(Icons.location_on),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    })
            ,
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
              ],
            );
           } );
            
   } )
      )));
  
  
}}
