import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:somer/materal/botom.dart';
import 'package:somer/materal/intext.dart';
import 'package:somer/materal/logo.dart';
import 'package:somer/materal/titlesignin.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<StatefulWidget> createState() => _mystate();
}

class _mystate extends State<signup> {
  bool isLoding = false;
  final _formKey = GlobalKey<FormState>();
  late ScrollController scrollController;
  String _email = '';
  String password = '';
  String emailError = '';
  String passwordError = '';
  GlobalKey<FormState> keyform = GlobalKey();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerpasword = TextEditingController();
  TextEditingController controllerfersname = TextEditingController();
  TextEditingController controllerlastname = TextEditingController();
  TextEditingController controllerpasword2 = TextEditingController();
  Future<bool> isEmailAlreadyInUse(String email) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return result.docs.isNotEmpty;
  }

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      print("-------------------------${scrollController.offset}");
    });
    super.initState();
  }

  void validateEmail(String email) {
    if (!email.contains("@gmail.com")) {
      setState(() {
        emailError = "ادخا بريد الكتروني صالح";
      });
    } else {
      setState(() {
        emailError = "";
      });
    }
  }

  void validatePassword(String password) {
    if (password.length < 6) {
      setState(() {
        passwordError = "الرمز يجب ان يحتوي  على 6 احرف على الاقل";
      });
    } else if (!RegExp(r"[A-Z]").hasMatch(password)) {
      setState(() {
        passwordError = 'الرمز  يجب ان يحتوي على حرف كبير واحد على الاقل';
      });
    } else if (!RegExp(r'[0-9]').hasMatch(password)) {
      setState(() {
        passwordError = 'الرمز يجب ان يحتوي على رقم واحد على الاقل';
      });
    } else {
      setState(() {
        passwordError = '';
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: ListView(
              controller: scrollController,
              children: [
                const SizedBox(
                  height: 90,
                ),
                Column(
                  //    mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isLoding == true
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Logo(),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "  signup",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const TEXT(testt: "Ferst name"),
                    clatext(
                        hinttext: 'enter your ferst name',
                        mycontroller: controllerfersname,
                        validator: (val) {
                          if (val == '') {
                            return "اكتب اسمك يا حاج";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    const TEXT(testt: "Last name"),
                    clatext(
                        hinttext: 'enter your last name',
                        mycontroller: controllerlastname,
                        validator: (val) {
                          if (val == '') {
                            return "اكتب اسمك يا حاج";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    const TEXT(
                      testt: 'Email',
                    ),
                    clatext(
                        errortext: emailError.isNotEmpty ? emailError : null,
                        auto: (value) {
                          _email = value;
                          validateEmail(_email);
                        },
                        hinttext: "Enter your Email",
                        mycontroller: controllerEmail,
                        validator: (val) {
                          if (val == "") {
                            return "Email shold be no empty";
                          }
                          return null;
                        }),
                    // Text("  signup",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                    const SizedBox(
                      height: 20,
                    ),
                    const TEXT(
                      testt: 'Pasword',
                    ),
                    clatext(
                      errortext:
                          passwordError.isNotEmpty ? passwordError : null,
                      auto: (val) {
                        password = val;
                        validatePassword(password);
                      },
                      typetext: true,
                      hinttext: "Enter your pasword",
                      mycontroller: controllerpasword,
                      validator: (val) {
                        if (val == "") {
                          return "cant pe empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const TEXT(testt: "Confirm the password  "),
                    clatext(
                        typetext: true,
                        hinttext: 'enter your last name',
                        mycontroller: controllerpasword2,
                        validator: (val) {
                          if (val == '') {
                            return "اكتب اسمك يا حاج";
                          } else if (controllerpasword.text !=
                              controllerpasword2.text) {
                            return "الرمز غير متطابق";
                          }
                          return null;
                        }),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      width: 1000,
                      child: const SizedBox(
                        height: 10,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                botomc(
                  onpressed: () async {
                    if (_formKey.currentState!.validate() &&
                        emailError.isEmpty &&
                        passwordError.isEmpty) {
                      try {
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: controllerEmail.text,
                          password: controllerpasword.text,
                        );
                        FirebaseAuth.instance.currentUser!.sendEmailVerification();
                        showDialog(context: context, builder: (context){
                          return AlertDialog(title: const Text("تحقق من بريدك الالكتروني ثم  سجل الدخول "
                          ),
                          actions: [TextButton(onPressed: (){
                            Navigator.of(context).pushNamedAndRemoveUntil("login", (route)=>false);
                          }, child: const Text("ok"))],);
                        });
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'email-already-in-use') {
                       //   FirebaseAuth.instance.currentUser!.sendEmailVerification();
                           showDialog(context: context, builder: (context){
                          return AlertDialog(title: const Text("تحقق من بريدك الالكتروني ثم  سجل الدخول "
                          ),
                          actions: [TextButton(onPressed: (){
                            Navigator.of(context).pushNamedAndRemoveUntil("login", (route)=>false);
                          }, child: const Text("ok"))],);
                        });
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  textbotum: 'signup',
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not regestor yet ? "),
                    InkWell(
                      child: Text(
                        "Creat new Acunte",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 90,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
