import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:somer/post.dart';
import 'package:somer/viewhose.dart';
import 'package:cached_network_image/cached_network_image.dart';

// افتراضًا أن هذه حزمك الخاصة
bool bay = false;
bool egar = false;
bool all = true;
int governorate = 0;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List mydata = [];
  List data = [];
  List mydatabay = [];

  List mydataagar = [];

  List govlistgeneral = [];
  //تخزن صور الالعلانات
  List advertisment = [];

  String? govselect;
  getadvertiameent() async {
    QuerySnapshot querySnapshotadv =
        await FirebaseFirestore.instance.collection("advertisement").get();
    advertisment
        .addAll(querySnapshotadv.docs.map((doc) => doc.data()).toList());
  }

GetData() async {
    _timer?.cancel();
    _pageController?.dispose();
    advertisment.clear();
    govlistgeneral.clear();
    mydatabay.clear();
    mydataagar.clear();
    mydata.clear();
    data.clear();

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    mydata.addAll(querySnapshot.docs.map((doc) => doc.data()).toList());
    QuerySnapshot querySnapshotbay = await FirebaseFirestore.instance
        .collection('users')
        .where('bay', isEqualTo: true)
        .get();
    data.addAll(mydata);
    mydataagar.addAll(querySnapshotbay.docs.map((doc) => doc.data()).toList());
    QuerySnapshot querySnapshotagar = await FirebaseFirestore.instance
        .collection('users')
        .where('bay', isEqualTo: false)
        .get();
    mydatabay.addAll(querySnapshotagar.docs.map((doc) => doc.data()).toList());
  }

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
  govfilter(List govlist, govselect) {
    data.clear();

    govlistgeneral.clear();

    if (governorate == 0) {
      data.addAll(govlist);
    } else {
      for (int i = 0; i < govlist.length; i++) {
        if (govlist[i]['gov'] == govselect) {
          govlistgeneral.add(govlist[i]);

          
        }
      }
      data.addAll(govlistgeneral);
    }
  }

  Timer? _timer;
  int _currentPage = 1;
  PageController? _pageController;

  @override
  void initState() {
    GetData();
    getadvertiameent();
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _startAutoPageChange();
  }

  void _startAutoPageChange() {
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      setState(() {
        _currentPage = (_currentPage + 1) % advertisment.length;
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
              _buildGridView(data)
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.blueGrey,
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Post(
                  catogreyid: FirebaseAuth.instance.currentUser!.uid,
                )));
      },
      child: const Icon(
        Icons.post_add,
        color: Colors.white,
      ),
    );
  }

  Widget _buildImageCarousel() {
    return Stack(
      children: [
        SizedBox(
          height: 270,
          child: PageView.builder(
            controller: _pageController,
            itemCount: advertisment.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: advertisment.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: "${advertisment[index]['image']}",
                        fit: BoxFit.cover,
                      )
                    : const Center(
                        child: Text("loading"),
                      ),
              );
            },
          ),
        ),
        SizedBox(
          // color: Colors.red,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    localint();
                });          },
                child: const Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "حديث",
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                    Icon(
                      Icons.change_circle,
                      color: Colors.blueGrey,
                    ),
                  ],
                ),
              ),
                 const Spacer(),
                 const SizedBox(
                 child: Center(
                 child: Text(
                    'عقارات',
                      style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              const SizedBox(
                width: 40,
              )
            ],
          ),
        ),
      ],
    );
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
                  bay = false;
                  egar = false;
                  all = true;
                  govfilter(mydata, govselect);
                });
              },
              child: Card(
                color: all == true ? Colors.blueGrey : null,
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  height: 40,
                  child: Text(
                    "الكل ",
                    style: TextStyle(
                      fontSize: 20,
                      color: all == true ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  bay = false;
                  egar = true;
                  all = false;
                  govfilter(mydataagar, govselect);
                });
              },
              child: Card(
                color: egar == true ? Colors.blueGrey : null,
                child: Container(
                  alignment: Alignment.center,
                  //   margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                //   print()
                setState(() {
                  bay = true;
                  egar = false;
                  all = false;
                  govfilter(mydatabay, govselect);
                });
              },
              child: Card(
                color: bay == true ? Colors.blueGrey[600] : null,
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
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
          ),
        ],
      ),
    );
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Widget _buildHorizontalSuggestions() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return _mohafadat(index); // _buildSuggestionItem(suggestions[index]);
        },
      ),
    );
  }

  Widget _mohafadat(index) {
    return SizedBox(
      height: 200,
      width: 100,
      child: InkWell(
        onTap: () {
          govselect = suggestions[index];
          setState(() {
            governorate = index;
            if (bay) {
              govfilter(mydatabay, govselect);
            } else if (all) {
              govfilter(mydata, govselect);
            } else if (egar) {
              govfilter(mydataagar, govselect);
            }
          });
        },
        child: Card(
          color: index == governorate ? Colors.blueGrey : null,
          child: Center(
            child: Text(
              suggestions[index],
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: index == governorate ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionsTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: const Text(
            'اقتراحات قد تعجبك',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey),
          ),
        ),
      ),
    );
  }

  Widget _buildGridView(localdata) {
    return InkWell(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: localdata.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
        ),
        itemBuilder: (context, index) {
          final doc = localdata[index];

          Timestamp timestamp = doc['time']; // جلب الـ Timestamp من Firestore
          DateTime dateTime = timestamp.toDate(); // تحويله إلى DateTime

          String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
          return _buildGridItem(doc, formattedDate);
        },
      ),
    );
  }

  Widget _buildGridItem(doc, locformattedDate) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Vieww(
                    postlocation2: doc["postlocation2"],
                    nuberOftapk: doc["nuberOftapk"],
                    numberofroom: doc["numberofroom"],
                    gov: doc['gov'],
                    mo: doc["mo"],
                    bay: doc["bay"],
                    agric: doc["agric"],
                    postphone: doc["postphone"],
                    posttitle: doc["posttitle"],
                    price: doc["postprice"],
                    posturl: doc["posturl"],
                    postlocation: doc['postlocation'],
                    postsize: doc["postsize"],
                    time: locformattedDate,
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
                    child: Hero(
                        tag: "${doc['posturl']}",
                        child: doc['posturl'].isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: doc['posturl'],
                                fit: BoxFit.cover,
                              )
                            : const Center(
                                child: Text("لا توجد صورة"),
                              )),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(doc['postprice'],
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 169, 127, 0))),
              Text(doc['posttitle'],
                  style: const TextStyle(fontSize: 16, color: Colors.grey)),
              Text(doc['postsize'],
                  style: const TextStyle(fontSize: 16, color: Colors.grey)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("$locformattedDate"),
                  const Spacer(),
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

  void localint() {
    GetData();
    getadvertiameent();

    _pageController = PageController(initialPage: _currentPage);
    _startAutoPageChange();
  }
}
