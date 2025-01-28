import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:somer/auth/login.dart';
import 'package:somer/auth/signup.dart';
import 'package:somer/homepage.dart';
import 'package:somer/pageonee.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase. initializeApp(
   
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget{
    const MyApp({super.key});
  @override
  State<StatefulWidget> createState()=> _mystate();
}

class _mystate extends State<MyApp> {

  @override
  void initState(){

    FirebaseAuth.instance
  .authStateChanges()                                                                                                     
  .listen((User? user) {
    if (user == null) {
      print('----------------User is currently signed out!');
    } else {
      print('-----------------User is signed in!');
    }
  });
    super.initState();
    FirebaseMessaging.instance.getToken().then((value){
      print("--------------------------------------------");
print(value);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
           "signup":(context)=>const signup() ,
           "login":(context)=>const Login(),
           "Homep":(context)=>const Homep(),
           "pageone":(context)=> const HomePage(),
     //"View":(context)=>Vieww()
      },
home:(FirebaseAuth.instance.currentUser !=null && FirebaseAuth.instance.currentUser!.emailVerified)? const HomePage():const Login()
    //  home:FirebaseAuth.instance.currentUser !=null ? Pageonee():Login()
     //home:Upload();
    //home:Login();
    //  home:const HomePage() ,
   // home:Pageonee()
    // home:realtime();
    );
  }

}