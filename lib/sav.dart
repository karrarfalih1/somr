import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:somer/post.dart';
import 'package:somer/viewhose.dart';
import 'package:cached_network_image/cached_network_image.dart';
// افتراضًا أن هذه حزمك الخاصة
bool bay = false;
bool egar = false;
int governorate=0;
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
///////////////////////////new work
  List mydata = [];
  List mydatabay = [];
  List mydataagar = [];
   List govlistgeneral = [];
   String? govselect;
  GetData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    mydata.addAll(querySnapshot.docs.map((doc) => doc.data()).toList());
    QuerySnapshot querySnapshotbay = await FirebaseFirestore.instance
        .collection('users')
        .where('bay', isEqualTo: true)
        .get();
    mydataagar.addAll(querySnapshotbay.docs.map((doc) => doc.data()).toList());
    QuerySnapshot querySnapshotagar = await FirebaseFirestore.instance
        .collection('users')
        .where('bay', isEqualTo: false)
        .get();
    mydatabay.addAll(querySnapshotagar.docs.map((doc) => doc.data()).toList());  
     QuerySnapshot govdata = await FirebaseFirestore.instance
        .collection('users')
        .where('bay', isEqualTo: false ).where('bay', isEqualTo: false )
        .get();
  }
govfilter(List govlist){
  
for (int i =0; i <  govlist.length; i++) {
  if(govlist[i]['gov']=="1"){
govlistgeneral.addAll(govlist);
  }
}
print(govlistgeneral);
}
  List<String> imagePaths = [
    "images/home2.jpg",
    "images/home2.jpg",
    "images/home2.jpg",
    "images/home2.jpg"  ];

  List<String> suggestions = ["الكل","بغداد", "ذي قار","بصرة","سماوة","ميسان","تكريت","النجف","كربلاء","الانبار","تكريت","كركوك","السليمانية"];

  Timer? _timer;
  int _currentPage = 1;
  PageController? _pageController;

  @override
  void initState() {
     GetData();
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _startAutoPageChange();
    } 
  void _startAutoPageChange() {
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      setState(() {
        _currentPage = (_currentPage + 1) % imagePaths.length;
        if (_pageController!.hasClients) {
          _pageController?.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Stream<QuerySnapshot> userStream =
    //    FirebaseFirestore.instance.collection('users').snapshots();

    return MaterialApp(
      home: Scaffold(
        
        endDrawer: _buildDrawer(),
        floatingActionButton: _buildFloatingActionButton(),
      //  appBar: _buildAppBar(),
        body: SizedBox(
          child: ListView(
            children: [
              //You don't undersand
              _buildImageCarousel(),
              _buildCategoryRow(),
              _buildHorizontalSuggestions(),
              _buildSuggestionsTitle(),
              _buildGridView(mydata)
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blue[200],
      elevation: 8,
      leading: IconButton(
        icon: const Icon(Icons.logout),
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
        },
      ),
      title: const Center(
          child:  Text(
            'عقارات',
            style: TextStyle(
              color: Colors.red,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: const [
            // Add drawer items here
          ],
        ),
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
             Navigator.of(context).push(MaterialPageRoute(
               builder: (context) => Post(
                   catogreyid: FirebaseAuth.instance.currentUser!.uid,
               )));
      },
      child: const Icon(Icons.post_add),
    );
  }

  Widget _buildImageCarousel() {
    return Stack(
    children: [
    
      SizedBox(
        height: 270,
        child: PageView.builder(
          controller: _pageController,
          itemCount: imagePaths.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Image.asset(
                imagePaths[index],
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
     const   SizedBox(
       // color: Colors.red,
        height:50 ,
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
 Text(
            'عقارات',
            style: TextStyle(
              color: Colors.red,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],),
      ),
    ],
    );
  }

  Widget _buildCategoryRow() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          //   _buildSearchBar(),
          Expanded(
            child: InkWell(
              onTap: () {
                
                setState(() {
                  mydata.clear();
                  mydata.addAll(mydataagar);
                  bay = false;
                  egar = true;
                });
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: egar == true ? Colors.blue[600] : Colors.grey[350],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                height: 40,
                child: Text(
                  "للايجار",
                  style: TextStyle(
                    fontSize: 20,
                    color: egar == true ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                print("---------------");
                //   print()
                setState(() {
                  mydata.clear();
                  mydata.addAll(mydatabay);
                  bay = true;
                  egar = false;
                 
                });
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: bay == true ? Colors.blue[600] : Colors.grey[350],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                height: 40,
                child: Text(
                  "للبيع",
                  style: TextStyle(
                    fontSize: 20,
                    color: bay == true ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildSearchBar() {
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 78, 78),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        height: 40,
        child: const Icon(Icons.search),
      ),
    );
  }

  Widget _buildHorizontalSuggestions() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return _mohafadat(index);// _buildSuggestionItem(suggestions[index]);
        },
      ),
    );
  }
Widget _mohafadat(index ){
return  SizedBox(height: 200,
width: 100,
  child: InkWell(
 onTap: (){
  setState(() {
     governorate=index;
  });

 
 },
    child: Card(
      color: index==governorate?Colors.amber:null,
      child: Center(child: Text("${suggestions[index]}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),),),
  ),);
}
 
  Widget _buildSuggestionsTitle() {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: (){
govfilter(mydata);
          },
          child: Text(
            'اقتراحات قد تعجبك',
            style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildGridView(mydata) {
    return InkWell(
          child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: mydata.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
          final doc = mydata[index];
          return _buildGridItem(doc);
        },
      ),
    );
  }

  Widget _buildGridItem(doc) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Vieww(
                    postlocation2: doc["postlocation2"],
                    nuberOftapk: doc["nuberOftapk"],
                    numberofroom: doc["numberofroom"],
                    gov:doc['gov'],
                    mo: doc["mo"],
                    bay: doc["bay"],
                    postphone: doc["postphone"],
                    posttitle: doc["posttitle"],
                    price: doc["postprice"],
                    posturl: doc["posturl"],
                    postlocation: doc['postlocation'],
                    postsize: doc["postsize"], agric: true, time: '',
                    )));
        },
        child: Container(
          decoration: const BoxDecoration(
            //   color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  width: 200,
                  //  color: Colors.amber,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    
                    child:Hero(
                      tag: "${doc['posturl']}",
                      child: CachedNetworkImage(imageUrl:doc['posturl'],fit: BoxFit.cover, )),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(doc['postprice'], style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 169, 127, 0))),
              Text(doc['posttitle'],
                  style: const TextStyle(fontSize: 16, color: Colors.grey)),
              Text(doc['postsize'],
                  style: const TextStyle(fontSize: 16, color: Colors.grey)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(doc['postlocation']),
                  const Icon(Icons.location_on),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(Object? error) {
    return Center(
      child: Text('Error: $error'),
    );
  }
}
