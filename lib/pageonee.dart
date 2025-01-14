import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// افتراضًا أن هذه حزمك الخاصة
  bool bay=false;
  bool egar=false;
   
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  List<String> imagePaths = [
    "images/home2.jpg",
    "images/home2.jpg",
    "images/home2.jpg",
    "images/home2.jpg"
  ];
  List<String> suggestions = ["بغداد", "ذي قار"];

  Timer? _timer;
  int _currentPage = 1;
  PageController? _pageController;

  @override
  void initState() {
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
  Stream<QuerySnapshot> userStream =
      FirebaseFirestore.instance.collection('users').where("bay",isEqualTo:egar).snapshots();
    

    return MaterialApp(
      home: Scaffold(
        
        endDrawer: _buildDrawer(),
        floatingActionButton: _buildFloatingActionButton(),
        appBar: _buildAppBar(),
        body: Container(
          
          color: Colors.grey[200],
          
          child: StreamBuilder<QuerySnapshot>(
  stream: userStream,
  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasError) {
      return _buildErrorWidget(snapshot.error);
    }

    // إذا كانت البيانات لا تزال قيد التحميل
    if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
      // إذا كان هناك بيانات مخزنة مؤقتًا، اعرضها
      if (snapshot.data != null && snapshot.data!.docs.isNotEmpty) {
        return _buildGridView(snapshot.data!.docs);
      }
      // إذا لم تكن هناك بيانات مخزنة مؤقتًا، اعرض مؤقت التحميل
      return const Center(child: CircularProgressIndicator());
    }

    // عرض البيانات عندما تكون متوفرة
    if (snapshot.data!.docs.isEmpty) {
      return const Center(child: Text('لا توجد بيانات متوفرة'));
    }

    return ListView(
      children: [
        _buildImageCarousel(),
        _buildCategoryRow(),
        _buildHorizontalSuggestions(),
        _buildSuggestionsTitle(),
        _buildGridView(snapshot.data!.docs),
      ],
    );
  },
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
        child: Text(
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
   //     Navigator.of(context).push(MaterialPageRoute(
     //       builder: (context) => Post(
       //           catogreyid: FirebaseAuth.instance.currentUser!.uid,
         //       )));
      },
      child: const Icon(Icons.post_add),
    );
  }

  Widget _buildImageCarousel() {
    return SizedBox(
      height: 200,
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
    );
  }

  Widget _buildCategoryRow() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          _buildSearchBar(),
         Expanded(
           child: InkWell(
            onTap: (){
          setState(() {
              bay=false;
                egar=true;
          });
              
             
            },
             child: Container(
                     alignment: Alignment.center,
                     margin: const EdgeInsets.symmetric(horizontal: 5),
                     decoration: BoxDecoration(
              color:egar ==true?Colors.blue[600]:Colors.grey[350],
              borderRadius: const BorderRadius.all(Radius.circular(20)),
                     ),
                     height: 40,
                     child: Text("للايجار",
                    
              style:  TextStyle(fontSize: 20, color:egar ==true?Colors.white:Colors.black,),
                     ),
                   ),
           ),
         ),
         Expanded(
           child: InkWell(
          
             onTap: (){
              print("---------------");
           //   print()
          setState(() {
              bay=true;
                egar=false;
          });
              
            
            },
             child: Container(
                     alignment: Alignment.center,
                     margin: const EdgeInsets.symmetric(horizontal: 5),
                     decoration: BoxDecoration(
              color:bay ==true?Colors.blue[600]:Colors.grey[350],
              borderRadius: const BorderRadius.all(Radius.circular(20)),
                     ),
                     height: 40,
                     child: Text(
                     "للبيع",
              style: TextStyle(fontSize: 20,color:bay ==true?Colors.white:Colors.black,),
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
        decoration: BoxDecoration(
          color: Colors.grey[350],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
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
        itemCount: 2,
        itemBuilder: (context, index) {
          return Text("data");// _buildSuggestionItem(suggestions[index]);
        },
      ),
    );
  }

  Widget _buildSuggestionItem(String location) {
    return Container(
        
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 100,
      height: 80,
      decoration: const BoxDecoration(
      //  color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(children: [
      
       SizedBox(
        width: 90,
        height: 70,
         child: ClipRRect(
              
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'images/home2.jpg',
                fit: BoxFit.cover,
              ),
            ),
       ),
       Text(location,style: const TextStyle(fontWeight: FontWeight.bold),)
      
  
      ],),
    );
  }

  Widget _buildSuggestionsTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          'اقتراحات قد تعجبك',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildGridView(List<QueryDocumentSnapshot> docs) {
    return InkWell(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: docs.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
        ),
        itemBuilder: (context, index) {
          final doc = docs[index];
          return _buildGridItem(doc);
        },
      ),
    );
  }

  Widget _buildGridItem(QueryDocumentSnapshot doc) {
    return InkWell(
      onTap: () {
      //  Navigator.of(context).push(MaterialPageRoute(
       //     builder: (context) => Vieww(
       //       postlocation2: doc["postlocation2"],
              
        //      nuberOftapk:doc["nuberOftapk"],
        //      numberofroom: doc["numberofroom"],
       //       mo: doc["mo"],
       //       bay: doc["bay"],
       //       postphone: doc["postphone"],
         //     posttitle: doc["posttitle"],
           ///       price: doc["postprice"],
              //    posturl: doc["posturl"],
              //    postlocation: doc['postlocation'], postsize: doc["postsize"],
               // )));
      },
      child:bay==true && doc["bay"]==false? Container(
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
                  child: Image.network(doc['posturl'], fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 10),
             Text(doc['postprice'], style: const TextStyle(fontSize: 20)),
            Text(doc['posttitle'], style: const TextStyle(fontSize: 16,color: Colors.grey)),
             Text(doc['postsize'], style: const TextStyle(fontSize: 16,color: Colors.grey)),
           
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(doc['postlocation']),
                const Icon(Icons.location_on),
              ],
            ),
          ],
        ),
      ):Container(
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
                  child: Image.network(doc['posturl'], fit: BoxFit.cover),
               
                ),
              ),
            ),
            const SizedBox(height: 10),
             Text(doc['postprice'], style: const TextStyle(fontSize: 20)),
            Text(doc['posttitle'], style: const TextStyle(fontSize: 16,color: Colors.grey)),
             Text(doc['postsize'], style: const TextStyle(fontSize: 16,color: Colors.grey)),
           
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
    );
  }

  Widget _buildErrorWidget(Object? error) {
    return Center(
      child: Text('Error: $error'),
    );
  }
}
