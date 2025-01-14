import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:somer/auth/addt.dart';



class realtime extends StatefulWidget{
  const realtime({super.key});

  @override
  State<StatefulWidget> createState() => _Mystate();
}
class _Mystate extends State<realtime>{
  final Stream<QuerySnapshot>userstream=FirebaseFirestore.instance.collection("users").snapshots();

  List datag=[];

  Getdata()async{
QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection("users").get();
datag.addAll(querySnapshot.docs);
setState(() {
  
});
  }
  
  @override
  void initState() {
    Getdata();
    
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const Addt()));
        //  Addt();
          
        }),
        appBar: AppBar(title: const Text("REAL TIME"),),

        body: SizedBox(
          height: 1000,
          width: 1000,
          child: StreamBuilder(stream: userstream, builder: (context,AsyncSnapshot<QuerySnapshot> snpshott){
            if(snpshott.hasError){
              return const Text("error");

            }
            if(snpshott.connectionState==ConnectionState.waiting){
              return const Text("lodding...");

            } return ListView.builder(
          
          itemCount: snpshott.data!.docs.length,
          itemBuilder: ( context, index) { 

            return Card(
              
              child: ListTile(
              
         onTap: ()async{
       DocumentReference documentReference =FirebaseFirestore.instance.collection("users").doc(snpshott.data!.docs[index].id);

       FirebaseFirestore.instance.runTransaction((transaction)async{
         DocumentSnapshot snapshotr=await transaction.get(documentReference);
         if(snapshotr.exists){
          var snapshotData=snapshotr.data();
          if(snapshotData is Map<String,dynamic>){
            int newmoney=snapshotData["money"]+100;
            transaction.update(documentReference, {
              "money":newmoney
            });
          }
         }
       });
        },
              title: Text("${snpshott.data!.docs[index]["ferstname"]}"),
              trailing: Text("${snpshott.data!.docs[index]["money"]}"),
              
            ),
            );

           },);
           
          }),
        )
      ),
    );
  }

}

/**
 * ListView.builder(
          
          itemCount: data.length,
          itemBuilder: ( context, index) { 

            return Card(child: ListTile(
              onTap: ()async{
                 DocumentReference userRef=FirebaseFirestore.instance.collection("users").doc(data[index].id);
    await userRef.update({
       "money":{data[index]["money"]+100}
    }
     
    );setState(() {
      
    });
              },
              title: Text(data[index]["ferstname"]),
              trailing: Text("${data[index]["money"]}"),
              
              
            ),
            );

           },),
 * 
 * 
 * 
 */